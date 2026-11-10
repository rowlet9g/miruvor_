import 'dart:io';

import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

import 'generated/schema_v1.dart' as v1;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late Directory root;
  late File file;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('miruvor-v1-upgrade-');
    file = File('${root.path}/records.sqlite');
  });
  tearDown(() async {
    if (await root.exists()) await root.delete(recursive: true);
  });

  test(
      'populated v1 with WAL migrates losslessly, creates a usable recovery copy and reopens',
      () async {
    final photo = File('${root.path}/images/original.jpg');
    await photo.parent.create();
    await photo.writeAsBytes([1, 3, 5, 7]);
    final old = v1.DatabaseAtV1(NativeDatabase(file));
    await old.customStatement('PRAGMA journal_mode = WAL');
    await old.customStatement('PRAGMA wal_autocheckpoint = 0');
    final keeper = v1.DatabaseAtV1(NativeDatabase(file));
    await keeper.customSelect('SELECT count(*) FROM wine_records').get();
    await seedV1(old, photo.path);
    final before = await snapshot(old);
    expect(await File('${file.path}-wal').exists(), isTrue);
    await old.close();

    final db = AppDatabase(NativeDatabase(file));
    final catalog = await db.catalogSnapshot();
    expect(catalog, hasLength(2)); // identical labels are not merged
    final first = catalog.singleWhere((e) => e.wine.id == 'wine-year');
    final unknown = catalog.singleWhere((e) => e.wine.id == 'wine-unknown');
    expect(first.wine.vintageKind, VintageKind.year);
    expect(first.wine.vintage, 2020);
    expect(unknown.wine.vintageKind, VintageKind.unknown);
    expect(unknown.wine.producer, isNull);
    expect(unknown.wine.country, isNull);
    expect(first.wine.imagePath, isNull);
    expect(first.wine.isArchived, isFalse);
    expect(first.wine.isWishlisted, isFalse);
    expect(first.bottles.single.id, 'bottle-consumed');
    expect(first.bottles.single.status, BottleStatus.consumed);
    expect(first.bottles.single.statusChangedAt, isNull);
    expect(first.bottles.single.acquiredAt, isNull);
    expect(first.bottles.single.volumeMl, isNull);
    expect(first.bottles.single.acquisitionKind, AcquisitionKind.purchase);
    expect(first.bottles.single.imagePath, photo.path);
    expect(unknown.bottles.single.status, BottleStatus.inStock);
    expect(first.purchases.single.id, 'legacy-purchase:bottle-consumed');
    expect(first.bottles.single.purchaseId, first.purchases.single.id);
    expect(first.purchases.single.purchasedQuantity, 1);
    expect(first.purchases.single.totalPaidKrw, 42000);
    expect(unknown.purchases.single.totalPaidKrw, 0);
    expect(first.purchases.single.volumeMl, isNull);

    for (final table in ['tasting_note_records', 'price_observation_records']) {
      final after = await rows(db, table);
      for (var index = 0; index < before[table]!.length; index++) {
        for (final field in before[table]![index].entries) {
          expect(after[index][field.key], field.value,
              reason: '$table.${field.key}');
        }
      }
    }
    final priceRows = await rows(db, 'price_observation_records');
    expect(
        priceRows
            .every((r) => r['updated_at'] == null && r['volume_ml'] == null),
        isTrue);
    expect(
        priceRows.map((r) => r['source_name']), contains('Manual reference'));
    expect(priceRows.map((r) => r['price']), contains(0));
    final note = (await db.findTastingNote('note-linked'))!;
    expect(note.bottleId, 'bottle-consumed');
    expect(note.buyAgain, isNull);
    final wineRows = await rows(db, 'wine_records');
    for (final oldWine in before['wine_records']!) {
      final newWine = wineRows.singleWhere((r) => r['id'] == oldWine['id']);
      for (final field in oldWine.entries) {
        final normalizedEmpty =
            ['name', 'producer', 'country', 'region'].contains(field.key) &&
                field.value == '';
        expect(newWine[field.key], normalizedEmpty ? null : field.value,
            reason: 'wine.${field.key}');
      }
    }
    final bottles = await rows(db, 'bottle_records');
    final purchases = await rows(db, 'purchase_records');
    for (final oldBottle in before['bottle_records']!) {
      final b = bottles.singleWhere((r) => r['id'] == oldBottle['id']);
      final p = purchases
          .singleWhere((r) => r['id'] == 'legacy-purchase:${oldBottle['id']}');
      for (final key in [
        'id',
        'wine_id',
        'image_path',
        'storage_location',
        'created_at',
        'updated_at'
      ]) {
        expect(b[key], oldBottle[key], reason: 'bottle.$key');
      }
      for (final key in [
        'wine_id',
        'purchase_date',
        'shop_name',
        'created_at',
        'updated_at'
      ]) {
        expect(p[key], oldBottle[key], reason: 'purchase.$key');
      }
      expect(p['total_paid_krw'], oldBottle['purchase_price']);
      expect(b.containsKey('purchase_price'), isFalse);
      expect(b.containsKey('purchase_date'), isFalse);
      expect(b.containsKey('shop_name'), isFalse);
    }
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
    expect(
        (await db.customSelect('PRAGMA user_version').getSingle())
            .read<int>('user_version'),
        2);
    expect(await photo.readAsBytes(), [1, 3, 5, 7]);
    await db.close();
    await keeper.close();

    final backups = await recoveryFiles(root);
    expect(backups, hasLength(1));
    final recovery = v1.DatabaseAtV1(NativeDatabase(backups.single));
    expect(await snapshot(recovery), before);
    expect(
        (await recovery.customSelect('PRAGMA user_version').getSingle())
            .read<int>('user_version'),
        1);
    await recovery.close();

    final reopened = AppDatabase(NativeDatabase(file));
    expect((await reopened.catalogSnapshot()).length, 2);
    expect(await reopened.select(reopened.purchaseRecords).get(), hasLength(2));
    await reopened.close();
    expect(await recoveryFiles(root), hasLength(1));
  });

  test(
      'failure after a schema change rolls back schema, rows and version, leaving photos intact',
      () async {
    final photo = File('${root.path}/original.jpg');
    await photo.writeAsBytes([4, 2]);
    final old = v1.DatabaseAtV1(NativeDatabase(file));
    await seedV1(old, photo.path);
    final before = await snapshot(old);
    await old.close();
    final failing = FailDuringMigration(NativeDatabase(file));
    await expectLater(failing.catalogSnapshot(), throwsA(isA<StateError>()));
    await failing.close();
    final original = v1.DatabaseAtV1(NativeDatabase(file));
    expect(await snapshot(original), before);
    expect(
        (await original.customSelect('PRAGMA user_version').getSingle())
            .read<int>('user_version'),
        1);
    final tables = await original
        .customSelect("SELECT name FROM sqlite_master WHERE type = 'table'")
        .get();
    expect(tables.map((r) => r.read<String>('name')),
        isNot(contains('purchase_records')));
    expect(await photo.readAsBytes(), [4, 2]);
    await original.close();
    expect(await recoveryFiles(root), hasLength(1));
    // A later normal launch can migrate the intact source.
    final retry = AppDatabase(NativeDatabase(file));
    expect(await retry.catalogSnapshot(), hasLength(2));
    await retry.close();
  });

  for (final (name, sql) in [
    (
      'negative purchase',
      "UPDATE bottle_records SET purchase_price = -1 WHERE id = 'bottle-stock'"
    ),
    (
      'invalid sensory value',
      "UPDATE tasting_note_records SET acidity = 0 WHERE id = 'note-linked'"
    ),
    (
      'cross-wine note',
      "UPDATE tasting_note_records SET wine_id = 'wine-unknown' WHERE id = 'note-linked'"
    ),
    (
      'dangling wine',
      "UPDATE bottle_records SET wine_id = 'missing' WHERE id = 'bottle-stock'"
    ),
  ]) {
    test(
        'invalid v1 $name stops before conversion without guessing or discarding data',
        () async {
      final old = v1.DatabaseAtV1(NativeDatabase(file));
      await seedV1(old, 'original/photo.jpg');
      await old.customStatement(sql);
      final before = await snapshot(old);
      await old.close();
      final db = AppDatabase(NativeDatabase(file));
      await expectLater(db.catalogSnapshot(), throwsA(isA<StateError>()));
      await db.close();
      final original = v1.DatabaseAtV1(NativeDatabase(file));
      expect(await snapshot(original), before);
      expect(
          (await original.customSelect('PRAGMA user_version').getSingle())
              .read<int>('user_version'),
          1);
      await original.close();
    });
  }

  test('pending image cleanup survives closing and reopening the database',
      () async {
    final images = FailingImages();
    final store = MiruvorStore(
        database: AppDatabase(NativeDatabase(file)), imageStore: images);
    final wine = await store.createWine(name: 'Retry');
    final note = await store.addTastingNote(
        wineId: wine, imagePath: 'managed/retry.jpg');
    await store.deleteTastingNote(note);
    expect(await store.findTastingNote(note), isNull);
    expect(await store.database.pendingImages(), ['managed/retry.jpg']);
    await store.close();

    images.fail = false;
    final reopened = MiruvorStore(
        database: AppDatabase(NativeDatabase(file)), imageStore: images);
    await reopened.retryImageCleanup();
    expect(await reopened.database.pendingImages(), isEmpty);
    expect(images.deleted, ['managed/retry.jpg']);
    expect(await reopened.findWine(wine), isNotNull);
    await reopened.close();
  });
}

Future<void> seedV1(v1.DatabaseAtV1 old, String photo) async {
  await old.customStatement("""
    INSERT INTO wine_records (id,name,producer,country,region,vintage,type,grape_varieties_json,created_at,updated_at)
    VALUES ('wine-year','Same label','Producer','France','Bordeaux',2020,'red','["Merlot","카베르네"]',1700000000,1700000123),
           ('wine-unknown','Same label','','','',NULL,'white','[]',1700000200,1700000321)
  """);
  await old.customStatement("""
    INSERT INTO bottle_records (id,wine_id,purchase_date,purchase_price,shop_name,image_path,storage_location,is_consumed,created_at,updated_at)
    VALUES ('bottle-consumed','wine-year',1700000400,42000,'Shop',?,'Shelf A',1,1700000500,1700000600),
           ('bottle-stock','wine-unknown',1700000700,0,NULL,NULL,NULL,0,1700000800,1700000900)
  """, [photo]);
  await old.customStatement("""
    INSERT INTO tasting_note_records (id,wine_id,bottle_id,tasted_at,rating,image_path,aroma,palate,pairing,acidity,tannin,body,sweetness,memo,created_at,updated_at)
    VALUES ('note-linked','wine-year','bottle-consumed',1700001000,4.5,?,'체리','fresh','Pasta',3,2,4,1,'Original memo',1700001100,1700001200),
           ('note-unlinked','wine-unknown',NULL,1700001300,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'unlinked',1700001400,1700001500)
  """, [photo]);
  await old.customStatement("""
    INSERT INTO price_observation_records (id,wine_id,source_name,price,observed_at,url,note,is_in_stock,created_at)
    VALUES ('price-manual','wine-year','Manual reference',0,1700001600,NULL,'legacy zero',NULL,1700001700),
           ('price-shop','wine-year','Retailer',50000,1700001800,'https://example.com/wine','discount',1,1700001900)
  """);
}

Future<List<Map<String, Object?>>> rows(
        GeneratedDatabase db, String table) async =>
    (await db.customSelect('SELECT * FROM $table ORDER BY id').get())
        .map((r) => r.data)
        .toList();
Future<Map<String, List<Map<String, Object?>>>> snapshot(
        GeneratedDatabase db) async =>
    {
      for (final table in [
        'wine_records',
        'bottle_records',
        'tasting_note_records',
        'price_observation_records'
      ])
        table: await rows(db, table),
    };
Future<List<File>> recoveryFiles(Directory root) async =>
    (await root.list().toList())
        .whereType<File>()
        .where((f) => f.path.contains('.v1-backup-'))
        .toList();

class FailDuringMigration extends AppDatabase {
  FailDuringMigration(super.executor);
  @override
  Future<void> customStatement(String statement, [List<Object?>? args]) {
    if (statement.contains('INSERT INTO purchase_records')) {
      throw StateError('Injected mid-upgrade failure');
    }
    return super.customStatement(statement, args);
  }
}

class FailingImages implements ImageStore {
  bool fail = true;
  final deleted = <String>[];
  @override
  Future<String> copyIntoAppStorage(String sourcePath,
          {required String prefix}) async =>
      sourcePath;
  @override
  Future<void> deleteManagedFile(String? filePath) async {
    if (fail) throw const FileSystemException('Injected filesystem failure');
    if (filePath != null) deleted.add(filePath);
  }
}
