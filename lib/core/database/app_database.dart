import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/purchase.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'domain_constraints.dart';
import 'app_database.steps.dart';

part 'app_database.g.dart';
part 'domain_tables.dart';
part 'domain_migration.dart';

@DriftDatabase(tables: [
  WineRecords,
  PurchaseRecords,
  BottleRecords,
  TastingNoteRecords,
  PriceObservationRecords,
  PendingImageDeletions,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());
  AppDatabase.inMemory() : this(NativeDatabase.memory());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _installDomainConstraints();
        },
        onUpgrade: _upgrade,
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
          // Also install on schema-verifier connections constructed from snapshots.
          await _installDomainConstraints();
        },
      );

  Future<void> _installDomainConstraints() async {
    for (final sql in domainConstraints) {
      await customStatement(sql);
    }
  }

  Future<List<WineEntry>> catalogSnapshot() => transaction(() async {
        final wines = await (select(wineRecords)
              ..orderBy([
                (r) => OrderingTerm.desc(r.createdAt),
                (r) => OrderingTerm.asc(r.id)
              ]))
            .get();
        final purchases = await (select(purchaseRecords)
              ..orderBy([
                (r) => OrderingTerm.desc(r.purchaseDate),
                (r) => OrderingTerm.desc(r.createdAt)
              ]))
            .get();
        final bottles = await (select(bottleRecords)
              ..orderBy([
                (r) => OrderingTerm.asc(r.createdAt),
                (r) => OrderingTerm.asc(r.id)
              ]))
            .get();
        return [
          for (final w in wines)
            WineEntry(
              wine: _wine(w),
              purchases: purchases
                  .where((r) => r.wineId == w.id)
                  .map(_purchase)
                  .toList(),
              bottles:
                  bottles.where((r) => r.wineId == w.id).map(_bottle).toList(),
            ),
        ];
      });

  Stream<List<WineEntry>> watchCatalog() => customSelect(
        'SELECT id FROM wine_records',
        readsFrom: {wineRecords, purchaseRecords, bottleRecords},
      ).watch().asyncMap((_) => catalogSnapshot());

  Future<List<WineWithBottle>> watchCellarSnapshotOnce() async =>
      (await catalogSnapshot())
          .expand((entry) => entry.bottles.map(
                (bottle) => WineWithBottle(
                    wine: entry.wine,
                    bottle: bottle,
                    purchase: entry.purchaseFor(bottle)),
              ))
          .toList();

  Stream<List<WineWithBottle>> watchCellar() => watchCatalog().map(
        (entries) => entries
            .expand((entry) => entry.bottles.map(
                  (bottle) => WineWithBottle(
                      wine: entry.wine,
                      bottle: bottle,
                      purchase: entry.purchaseFor(bottle)),
                ))
            .toList(),
      );

  Stream<List<Wine>> watchWines() =>
      (select(wineRecords)..orderBy([(r) => OrderingTerm.asc(r.name)]))
          .watch()
          .map((rows) => rows.map(_wine).toList());

  Stream<List<TastingNote>> watchTastingNotes() => (select(tastingNoteRecords)
        ..orderBy([
          (r) => OrderingTerm.desc(r.tastedAt),
          (r) => OrderingTerm.desc(r.createdAt)
        ]))
      .watch()
      .map((rows) => rows.map(_note).toList());

  Stream<List<PriceObservation>> watchPriceObservations() =>
      (select(priceObservationRecords)
            ..orderBy([(r) => OrderingTerm.desc(r.observedAt)]))
          .watch()
          .map((rows) => rows.map(_price).toList());

  Stream<List<PriceObservation>> watchPriceObservationsForWine(String wineId) =>
      (select(priceObservationRecords)
            ..where((r) => r.wineId.equals(wineId))
            ..orderBy([(r) => OrderingTerm.desc(r.observedAt)]))
          .watch()
          .map((rows) => rows.map(_price).toList());

  Future<Wine?> findWine(String id) async {
    final row = await (select(wineRecords)..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _wine(row);
  }

  Future<Purchase?> findPurchase(String id) async {
    final row = await (select(purchaseRecords)..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _purchase(row);
  }

  Future<Bottle?> findBottle(String id) async {
    final row = await (select(bottleRecords)..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _bottle(row);
  }

  Future<TastingNote?> findTastingNote(String id) async {
    final row = await (select(tastingNoteRecords)
          ..where((r) => r.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _note(row);
  }

  Future<List<TastingNote>> notesForWine(String wineId) async =>
      (await (select(tastingNoteRecords)..where((r) => r.wineId.equals(wineId)))
              .get())
          .map(_note)
          .toList();

  Future<PriceObservation?> latestPriceForWine(String wineId) async {
    final rows = await (select(priceObservationRecords)
          ..where((r) => r.wineId.equals(wineId))
          ..orderBy([(r) => OrderingTerm.desc(r.observedAt)])
          ..limit(1))
        .get();
    return rows.isEmpty ? null : _price(rows.first);
  }

  Future<void> insertWine(Wine wine) async {
    _validateWine(wine);
    final now = DateTime.now();
    await into(wineRecords).insert(_wineValues(wine)
        .copyWith(createdAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> updateWine(Wine wine) async {
    _validateWine(wine);
    _requireChanged(await (update(wineRecords)
          ..where((r) => r.id.equals(wine.id)))
        .write(_wineValues(wine).copyWith(updatedAt: Value(DateTime.now()))));
  }

  WineRecordsCompanion _wineValues(Wine wine) => WineRecordsCompanion(
        id: Value(wine.id),
        name: Value(wine.name),
        producer: Value(wine.producer),
        country: Value(wine.country),
        region: Value(wine.region),
        vintage: Value(wine.vintage),
        vintageKind: Value(wine.vintageKind.name),
        type: Value(wine.type?.name),
        grapeVarietiesJson: Value(jsonEncode(wine.grapeVarieties)),
        imagePath: Value(wine.imagePath),
        isWishlisted: Value(wine.isWishlisted),
        isArchived: Value(wine.isArchived),
      );

  Future<void> insertPurchase(Purchase purchase, List<Bottle> bottles) =>
      transaction(() async {
        _validatePurchase(purchase);
        if (bottles.length != purchase.purchasedQuantity) {
          throw ArgumentError('최초 구매 수량과 병 수가 일치해야 합니다.');
        }
        for (final bottle in bottles) {
          if (bottle.wineId != purchase.wineId ||
              bottle.purchaseId != purchase.id) {
            throw ArgumentError('구매와 병의 연결이 일치하지 않습니다.');
          }
        }
        final now = DateTime.now();
        await into(purchaseRecords).insert(_purchaseValues(purchase)
            .copyWith(createdAt: Value(now), updatedAt: Value(now)));
        for (final bottle in bottles) {
          await insertBottle(bottle);
        }
      });

  Future<void> updatePurchase(Purchase purchase) => transaction(() async {
        _validatePurchase(purchase);
        final previous = await findPurchase(purchase.id);
        if (previous == null || previous.wineId != purchase.wineId) {
          throw ArgumentError('구매의 와인 연결은 변경할 수 없습니다.');
        }
        final linked = await (select(bottleRecords)
              ..where((r) => r.purchaseId.equals(purchase.id)))
            .get();
        if (linked.length > purchase.purchasedQuantity) {
          throw ArgumentError('수량은 연결된 병 수보다 작을 수 없습니다.');
        }
        // Detach first to keep immediate relationship triggers valid during a
        // volume correction; the entire operation is one transaction.
        await (update(bottleRecords)
              ..where((r) => r.purchaseId.equals(purchase.id)))
            .write(const BottleRecordsCompanion(purchaseId: Value(null)));
        await (update(purchaseRecords)..where((r) => r.id.equals(purchase.id)))
            .write(_purchaseValues(purchase)
                .copyWith(updatedAt: Value(DateTime.now())));
        for (final bottle in linked) {
          await (update(bottleRecords)..where((r) => r.id.equals(bottle.id)))
              .write(BottleRecordsCompanion(
                  purchaseId: Value(purchase.id),
                  volumeMl: Value(purchase.volumeMl),
                  updatedAt: Value(DateTime.now())));
        }
      });

  PurchaseRecordsCompanion _purchaseValues(Purchase purchase) =>
      PurchaseRecordsCompanion(
        id: Value(purchase.id),
        wineId: Value(purchase.wineId),
        purchaseDate: Value(purchase.purchaseDate),
        shopName: Value(purchase.shopName),
        purchasedQuantity: Value(purchase.purchasedQuantity),
        totalPaidKrw: Value(purchase.totalPaidKrw),
        volumeMl: Value(purchase.volumeMl),
        note: Value(purchase.note),
      );

  Future<void> insertBottle(Bottle bottle) async {
    await _validateBottle(bottle);
    final now = DateTime.now();
    await into(bottleRecords).insert(_bottleValues(bottle)
        .copyWith(createdAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> updateBottle(Bottle bottle) async {
    final previous = await findBottle(bottle.id);
    if (previous == null || previous.wineId != bottle.wineId) {
      throw ArgumentError('병의 와인 연결은 변경할 수 없습니다.');
    }
    await _validateBottle(bottle);
    _requireChanged(await (update(bottleRecords)
          ..where((r) => r.id.equals(bottle.id)))
        .write(
            _bottleValues(bottle).copyWith(updatedAt: Value(DateTime.now()))));
  }

  BottleRecordsCompanion _bottleValues(Bottle bottle) => BottleRecordsCompanion(
        id: Value(bottle.id),
        wineId: Value(bottle.wineId),
        purchaseId: Value(bottle.purchaseId),
        acquisitionKind: Value(bottle.acquisitionKind.name),
        acquiredAt: Value(bottle.acquiredAt),
        volumeMl: Value(bottle.volumeMl),
        status: Value(bottle.status.name),
        statusChangedAt: Value(bottle.statusChangedAt),
        imagePath: Value(bottle.imagePath),
        storageLocation: Value(bottle.storageLocation),
      );

  Future<void> insertTastingNote(TastingNote note) async {
    await _validateNote(note);
    final now = DateTime.now();
    await into(tastingNoteRecords).insert(_noteValues(note)
        .copyWith(createdAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> updateTastingNote(TastingNote note) async {
    await _validateNote(note);
    _requireChanged(await (update(tastingNoteRecords)
          ..where((r) => r.id.equals(note.id)))
        .write(_noteValues(note).copyWith(updatedAt: Value(DateTime.now()))));
  }

  TastingNoteRecordsCompanion _noteValues(TastingNote note) =>
      TastingNoteRecordsCompanion(
        id: Value(note.id),
        wineId: Value(note.wineId),
        bottleId: Value(note.bottleId),
        tastedAt: Value(note.tastedAt),
        rating: Value(note.rating),
        imagePath: Value(note.imagePath),
        aroma: Value(note.aroma),
        palate: Value(note.palate),
        pairing: Value(note.pairing),
        acidity: Value(note.acidity),
        tannin: Value(note.tannin),
        body: Value(note.body),
        sweetness: Value(note.sweetness),
        memo: Value(note.memo),
        buyAgain: Value(note.buyAgain?.name),
      );

  Future<void> insertPriceObservation(PriceObservation price) async {
    _validatePrice(price);
    final now = DateTime.now();
    await into(priceObservationRecords).insert(_priceValues(price)
        .copyWith(createdAt: Value(now), updatedAt: Value(now)));
  }

  Future<void> updatePriceObservation(PriceObservation price) async {
    _validatePrice(price);
    _requireChanged(await (update(priceObservationRecords)
          ..where((r) => r.id.equals(price.id)))
        .write(_priceValues(price).copyWith(updatedAt: Value(DateTime.now()))));
  }

  PriceObservationRecordsCompanion _priceValues(PriceObservation price) =>
      PriceObservationRecordsCompanion(
        id: Value(price.id),
        wineId: Value(price.wineId),
        sourceName: Value(price.sourceName),
        price: Value(price.price),
        observedAt: Value(price.observedAt),
        url: Value(price.url),
        note: Value(price.note),
        isInStock: Value(price.isInStock),
        volumeMl: Value(price.volumeMl),
      );

  Future<void> deletePurchase(String id) async {
    await (delete(purchaseRecords)..where((r) => r.id.equals(id))).go();
  }

  Future<void> deleteBottle(String id) async {
    await (delete(bottleRecords)..where((r) => r.id.equals(id))).go();
  }

  Future<void> deleteTastingNote(String id) async {
    await (delete(tastingNoteRecords)..where((r) => r.id.equals(id))).go();
  }

  Future<void> deletePriceObservation(String id) async {
    await (delete(priceObservationRecords)..where((r) => r.id.equals(id))).go();
  }

  Future<void> deleteWine(String id) => transaction(() async {
        await (delete(tastingNoteRecords)..where((r) => r.wineId.equals(id)))
            .go();
        await (delete(priceObservationRecords)
              ..where((r) => r.wineId.equals(id)))
            .go();
        await (delete(bottleRecords)..where((r) => r.wineId.equals(id))).go();
        await (delete(purchaseRecords)..where((r) => r.wineId.equals(id))).go();
        await (delete(wineRecords)..where((r) => r.id.equals(id))).go();
      });

  Future<void> setArchived(String id, bool archived) async {
    _requireChanged(await (update(wineRecords)..where((r) => r.id.equals(id)))
        .write(WineRecordsCompanion(
            isArchived: Value(archived), updatedAt: Value(DateTime.now()))));
  }

  Future<Set<String>> imageReferences() async {
    final rows = await customSelect('''
      SELECT image_path FROM wine_records WHERE image_path IS NOT NULL
      UNION SELECT image_path FROM bottle_records WHERE image_path IS NOT NULL
      UNION SELECT image_path FROM tasting_note_records WHERE image_path IS NOT NULL
    ''').get();
    return rows.map((r) => r.read<String>('image_path')).toSet();
  }

  Future<void> queueImageDeletion(String path) async {
    await into(pendingImageDeletions).insert(
        PendingImageDeletionsCompanion.insert(
            path: path, requestedAt: DateTime.now()),
        mode: InsertMode.insertOrIgnore);
  }

  Future<List<String>> pendingImages() async =>
      (await select(pendingImageDeletions).get()).map((r) => r.path).toList();
  Future<void> finishImageDeletion(String path) async {
    await (delete(pendingImageDeletions)..where((r) => r.path.equals(path)))
        .go();
  }

  Future<WineDeletionImpact> deletionImpact(String wineId) async {
    final wine = await findWine(wineId);
    if (wine == null) throw StateError('와인 기록을 찾을 수 없습니다.');
    final purchases = await (select(purchaseRecords)
          ..where((r) => r.wineId.equals(wineId)))
        .get();
    final bottles = await (select(bottleRecords)
          ..where((r) => r.wineId.equals(wineId)))
        .get();
    final notes = await (select(tastingNoteRecords)
          ..where((r) => r.wineId.equals(wineId)))
        .get();
    final prices = await (select(priceObservationRecords)
          ..where((r) => r.wineId.equals(wineId)))
        .get();
    final candidates = <String>{
      if (wine.imagePath != null) wine.imagePath!,
      ...bottles.map((b) => b.imagePath).whereType<String>(),
      ...notes.map((n) => n.imagePath).whereType<String>()
    };
    final outside = await customSelect('''
      SELECT image_path FROM wine_records WHERE id <> ? AND image_path IS NOT NULL
      UNION SELECT image_path FROM bottle_records WHERE wine_id <> ? AND image_path IS NOT NULL
      UNION SELECT image_path FROM tasting_note_records WHERE wine_id <> ? AND image_path IS NOT NULL
    ''', variables: [Variable(wineId), Variable(wineId), Variable(wineId)])
        .get();
    final protected =
        outside.map((r) => imageKey(r.read<String>('image_path'))).toSet();
    final orphanPaths =
        candidates.where((path) => !protected.contains(imageKey(path))).toSet();
    final signature = [
      wineId,
      ...purchases.map((r) => 'p:${r.id}'),
      ...bottles.map((r) => 'b:${r.id}'),
      ...notes.map((r) => 'n:${r.id}'),
      ...prices.map((r) => 'r:${r.id}'),
      ...candidates.map((r) => 'i:$r'),
      ...orphanPaths.map((r) => 'o:$r')
    ]..sort();
    return WineDeletionImpact(
        purchases: purchases.length,
        bottles: bottles.length,
        notes: notes.length,
        prices: prices.length,
        imagePaths: candidates,
        unreferencedImages: orphanPaths,
        signature: jsonEncode(signature));
  }

  void _validateWine(Wine wine) {
    if ((wine.name?.trim().isEmpty ?? true) &&
        (wine.imagePath?.trim().isEmpty ?? true)) {
      throw ArgumentError('이름 또는 사진이 필요합니다.');
    }
    if ((wine.vintageKind == VintageKind.year) != (wine.vintage != null)) {
      throw ArgumentError('빈티지 구분과 연도를 확인해 주세요.');
    }
  }

  void _validatePurchase(Purchase purchase) {
    if (purchase.purchasedQuantity < 1 ||
        (purchase.totalPaidKrw != null && purchase.totalPaidKrw! < 0) ||
        (purchase.volumeMl != null && purchase.volumeMl! < 1)) {
      throw ArgumentError('수량·결제액·용량을 확인해 주세요.');
    }
  }

  Future<void> _validateBottle(Bottle bottle) async {
    if (bottle.volumeMl != null && bottle.volumeMl! < 1) {
      throw ArgumentError('용량은 양수여야 합니다.');
    }
    if (bottle.purchaseId != null) {
      final purchase = await findPurchase(bottle.purchaseId!);
      if (purchase == null ||
          purchase.wineId != bottle.wineId ||
          purchase.volumeMl != bottle.volumeMl ||
          bottle.acquisitionKind != AcquisitionKind.purchase) {
        throw ArgumentError('병과 구매의 와인·용량·취득 종류가 일치해야 합니다.');
      }
      final count = await (select(bottleRecords)
            ..where((r) =>
                r.purchaseId.equals(purchase.id) &
                r.id.equals(bottle.id).not()))
          .get();
      if (count.length >= purchase.purchasedQuantity) {
        throw ArgumentError('구매 수량을 초과합니다.');
      }
    }
  }

  Future<void> _validateNote(TastingNote note) async {
    if (note.rating != null &&
        (!note.rating!.isFinite || note.rating! < 0 || note.rating! > 5)) {
      throw ArgumentError('평점은 0~5의 유한한 값이어야 합니다.');
    }
    final senses = [note.acidity, note.tannin, note.body, note.sweetness];
    if (senses.whereType<int>().any((v) => v < 1 || v > 5)) {
      throw ArgumentError('세부 평가는 1~5입니다.');
    }
    if (note.rating == null &&
        note.buyAgain == null &&
        senses.every((s) => s == null) &&
        [note.aroma, note.palate, note.pairing, note.memo, note.imagePath]
            .every((s) => s?.trim().isEmpty ?? true)) {
      throw ArgumentError('감상·사진·평가 중 하나 이상을 남겨 주세요.');
    }
    if (note.bottleId != null &&
        (await findBottle(note.bottleId!))?.wineId != note.wineId) {
      throw ArgumentError('다른 와인의 병에는 시음 기록을 연결할 수 없습니다.');
    }
  }

  void _validatePrice(PriceObservation price) {
    if (price.price <= 0 ||
        price.sourceName.trim().isEmpty ||
        (price.volumeMl != null && price.volumeMl! <= 0)) {
      throw ArgumentError('출처와 양수 가격·용량을 확인해 주세요.');
    }
  }

  void _requireChanged(int count) {
    if (count != 1) throw StateError('수정할 기록을 찾을 수 없습니다.');
  }

  Wine _wine(WineRecord r) => Wine(
      id: r.id,
      name: r.name,
      producer: r.producer,
      country: r.country,
      region: r.region,
      vintage: r.vintage,
      vintageKind: VintageKind.values.byName(r.vintageKind),
      type: r.type == null ? null : WineType.values.byName(r.type!),
      grapeVarieties: (jsonDecode(r.grapeVarietiesJson) as List).cast<String>(),
      imagePath: r.imagePath,
      isWishlisted: r.isWishlisted,
      isArchived: r.isArchived);
  Purchase _purchase(PurchaseRecord r) => Purchase(
      id: r.id,
      wineId: r.wineId,
      purchasedQuantity: r.purchasedQuantity,
      totalPaidKrw: r.totalPaidKrw,
      purchaseDate: r.purchaseDate,
      shopName: r.shopName,
      volumeMl: r.volumeMl,
      note: r.note);
  Bottle _bottle(BottleRecord r) => Bottle(
      id: r.id,
      wineId: r.wineId,
      purchaseId: r.purchaseId,
      acquisitionKind: AcquisitionKind.values.byName(r.acquisitionKind),
      acquiredAt: r.acquiredAt,
      volumeMl: r.volumeMl,
      status: BottleStatus.values.byName(r.status),
      statusChangedAt: r.statusChangedAt,
      imagePath: r.imagePath,
      storageLocation: r.storageLocation);
  TastingNote _note(TastingNoteRecord r) => TastingNote(
      id: r.id,
      wineId: r.wineId,
      bottleId: r.bottleId,
      tastedAt: r.tastedAt,
      rating: r.rating,
      imagePath: r.imagePath,
      aroma: r.aroma,
      palate: r.palate,
      pairing: r.pairing,
      memo: r.memo,
      acidity: r.acidity,
      tannin: r.tannin,
      body: r.body,
      sweetness: r.sweetness,
      buyAgain:
          r.buyAgain == null ? null : BuyAgain.values.byName(r.buyAgain!));
  PriceObservation _price(PriceObservationRecord r) => PriceObservation(
      id: r.id,
      wineId: r.wineId,
      sourceName: r.sourceName,
      price: r.price,
      observedAt: r.observedAt,
      url: r.url,
      note: r.note,
      isInStock: r.isInStock,
      volumeMl: r.volumeMl);
}

class WineWithBottle {
  const WineWithBottle(
      {required this.wine, required this.bottle, this.purchase});
  final Wine wine;
  final Bottle bottle;
  final Purchase? purchase;
  double? get purchasePrice => purchase?.unitPrice;
}

class WineEntry {
  const WineEntry(
      {required this.wine, required this.purchases, required this.bottles});
  final Wine wine;
  final List<Purchase> purchases;
  final List<Bottle> bottles;
  int get stockCount => bottles.where((b) => b.isInStock).length;
  Purchase? purchaseFor(Bottle bottle) {
    for (final purchase in purchases) {
      if (purchase.id == bottle.purchaseId) return purchase;
    }
    return null;
  }

  double? get latestUnitPrice =>
      purchases.isEmpty ? null : purchases.first.unitPrice;
}

class WineDeletionImpact {
  const WineDeletionImpact(
      {required this.purchases,
      required this.bottles,
      required this.notes,
      required this.prices,
      required this.imagePaths,
      required this.unreferencedImages,
      required this.signature});
  final int purchases, bottles, notes, prices;
  final Set<String> imagePaths;
  final Set<String> unreferencedImages;
  final String signature;
}

String imageKey(String path) {
  final normalized = p.normalize(p.absolute(path));
  return Platform.isWindows ? normalized.toLowerCase() : normalized;
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final directory = await getApplicationDocumentsDirectory();
      return NativeDatabase.createInBackground(
          File(p.join(directory.path, 'miruvor.sqlite')));
    });
