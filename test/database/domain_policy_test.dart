import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/purchase.dart';
import 'package:miruvor/core/models/price_analysis.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

void main() {
  late AppDatabase db;
  late MiruvorStore store;
  late RecordingImages images;

  setUp(() {
    db = AppDatabase.inMemory();
    images = RecordingImages();
    store = MiruvorStore(database: db, imageStore: images);
  });
  tearDown(() async => store.close());

  test(
      'wine-only tasting, photo-only wine, gifts and unknown values need no purchase',
      () async {
    final id = await store.createWine(name: 'Wine bar glass');
    final noteId =
        await store.addTastingNote(wineId: id, memo: 'Bright acidity');
    final gift = await store.addBottle(wineId: id);
    final photoOnly = await store.createWine(imagePath: 'managed/label.jpg');
    final wine = (await store.findWine(id))!;
    final note = (await store.findTastingNote(noteId))!;
    expect(wine.producer, isNull);
    expect(wine.type, isNull);
    expect(wine.vintageKind, VintageKind.unknown);
    expect(note.bottleId, isNull);
    expect(note.rating, isNull);
    expect(note.tastedAt, isNull);
    expect(
        (await store.findBottle(gift))!.acquisitionKind, AcquisitionKind.gift);
    expect((await store.findWine(photoOnly))!.name, isNull);
    expect(await db.select(db.purchaseRecords).get(), isEmpty);
    expect((await store.entryForWine(id))!.stockCount, 1);
  });

  test(
      'three bottles, consumption and repurchase share one wine and preserve original quantity',
      () async {
    final id = await store.createWine(name: 'One wine', vintage: 2020);
    final p1 = await store.addPurchase(
        wineId: id,
        purchasedQuantity: 3,
        totalPaidKrw: 90000,
        purchaseDate: DateTime(2026, 11, 1),
        volumeMl: 750);
    var entry = (await store.entryForWine(id))!;
    expect(entry.bottles, hasLength(3));
    expect(entry.purchases.single.unitPrice, 30000);
    final bottle = entry.bottles.first;
    final noteId = await store.addTastingNote(
        wineId: id,
        bottleId: bottle.id,
        rating: 4,
        tastedAt: DateTime(2026, 11, 2),
        consumeBottle: true);
    await store.addPurchase(
        wineId: id,
        purchasedQuantity: 2,
        totalPaidKrw: 64000,
        purchaseDate: DateTime(2026, 11, 3),
        volumeMl: 750);
    entry = (await store.entryForWine(id))!;
    expect(entry.stockCount, 4);
    expect(entry.bottles, hasLength(5));
    expect(entry.purchases, hasLength(2));
    expect((await store.findPurchase(p1))!.purchasedQuantity, 3);
    expect((await db.select(db.wineRecords).get()), hasLength(1));
    await store.deleteTastingNote(noteId);
    expect((await store.findBottle(bottle.id))!.status, BottleStatus.consumed);
    expect((await store.entryForWine(id))!.stockCount, 4);
  });

  test(
      'purchase deletion only detaches bottles; bottle deletion only detaches notes',
      () async {
    final id = await store.addWinePurchase(
        name: 'Preserved wine',
        purchasePrice: 90000,
        purchasedQuantity: 3,
        volumeMl: 750,
        imagePath: 'managed/bottle.jpg',
        referencePrice: 35000);
    final entry = (await store.entryForWine(id))!;
    final bottle = entry.bottles.first;
    final note = await store.addTastingNote(
        wineId: id,
        bottleId: bottle.id,
        memo: 'Keep this memory',
        imagePath: 'managed/note.jpg');
    await store.deletePurchase(entry.purchases.single.id);
    expect(await db.select(db.purchaseRecords).get(), isEmpty);
    final detached = (await store.entryForWine(id))!;
    expect(detached.stockCount, 3);
    expect(
        detached.bottles
            .every((b) => b.purchaseId == null && b.volumeMl == 750),
        isTrue);
    expect(
        detached.bottles
            .every((b) => b.acquisitionKind == AcquisitionKind.purchase),
        isTrue);
    expect((await store.findTastingNote(note))!.bottleId, bottle.id);
    expect(await db.select(db.priceObservationRecords).get(), hasLength(1));
    expect(images.deleted, isEmpty);
    await store.deleteBottle(bottle.id);
    expect((await store.findTastingNote(note))!.bottleId, isNull);
    expect((await store.findTastingNote(note))!.memo, 'Keep this memory');
    expect((await store.findTastingNote(note))!.imagePath, 'managed/note.jpg');
    expect(images.deleted,
        isEmpty); // other bottles still reference the shared photo
    expect((await store.entryForWine(id))!.stockCount, 2);
    expect(await store.findWine(id), isNotNull);
  });

  test(
      'deleting an erroneous bottle leaves purchase quantity and total untouched',
      () async {
    final id = await store.addWinePurchase(
        name: 'History', purchasedQuantity: 3, purchasePrice: 100000);
    final entry = (await store.entryForWine(id))!;
    await store.deleteBottle(entry.bottles.first.id);
    final purchase = (await store.findPurchase(entry.purchases.single.id))!;
    expect(purchase.purchasedQuantity, 3);
    expect(purchase.totalPaidKrw, 100000);
    expect(purchase.unitPrice, closeTo(33333.333333, 0.00001));
    expect((await store.entryForWine(id))!.stockCount, 2);
  });

  test(
      'purchase edits preserve price observations and correct linked volumes atomically',
      () async {
    final id = await store.addWinePurchase(
        name: 'Purchase edit',
        purchasedQuantity: 2,
        purchasePrice: 50000,
        referencePrice: 30000);
    final entry = (await store.entryForWine(id))!;
    final originalPrice =
        (await db.select(db.priceObservationRecords).get()).single;
    final p = entry.purchases.single;
    await store.savePurchase(Purchase(
        id: p.id,
        wineId: id,
        purchasedQuantity: 3,
        totalPaidKrw: 60000,
        volumeMl: 1500));
    final updated = (await store.entryForWine(id))!;
    expect(updated.bottles,
        hasLength(2)); // quantity correction is not stock creation
    expect(
        updated.bottles
            .every((b) => b.volumeMl == 1500 && b.purchaseId == p.id),
        isTrue);
    expect((await db.select(db.priceObservationRecords).get()).single,
        originalPrice);
    await expectLater(
        store.savePurchase(Purchase(
            id: p.id,
            wineId: id,
            purchasedQuantity: 1,
            totalPaidKrw: 1,
            volumeMl: 375)),
        throwsArgumentError);
    expect((await store.findPurchase(p.id))!.totalPaidKrw, 60000);
    expect(
        (await store.entryForWine(id))!
            .bottles
            .every((b) => b.volumeMl == 1500),
        isTrue);
  });

  test('same labels stay separate and vintage unknown is not NV', () async {
    final unknown = await store.createWine(name: 'Same label');
    final nv = await store.createWine(
        name: 'Same label', vintageKind: VintageKind.nonVintage);
    final year = await store.createWine(name: 'Same label', vintage: 2020);
    expect({unknown, nv, year}, hasLength(3));
    expect((await store.findWine(unknown))!.displayVintage, '빈티지 미상');
    expect((await store.findWine(nv))!.displayVintage, 'NV');
    expect((await store.findWine(year))!.displayVintage, '2020');
    await expectLater(
        store.createWine(
            name: 'Invalid', vintage: 2020, vintageKind: VintageKind.unknown),
        throwsArgumentError);
  });

  test('unknown price and confirmed zero purchase remain distinct', () async {
    final id = await store.createWine(name: 'Unknowns');
    await store.addPurchase(wineId: id, purchasedQuantity: 1);
    await store.addPurchase(wineId: id, purchasedQuantity: 1, totalPaidKrw: 0);
    final values = (await store.entryForWine(id))!
        .purchases
        .map((p) => p.totalPaidKrw)
        .toList();
    expect(values, containsAll([null, 0]));
    expect(
        (await store.entryForWine(id))!
            .purchases
            .every((p) => p.purchaseDate == null),
        isTrue);
    final zeroReference = PriceObservation(
        id: 'legacy',
        wineId: id,
        sourceName: 'Legacy',
        price: 0,
        observedAt: DateTime(2026));
    expect(
        PriceAnalysis(purchasePrice: 100, observations: [zeroReference])
            .judgement,
        PriceJudgement.unknown);
    expect(
        PriceAnalysis(purchasePrice: null, observations: [
          PriceObservation(
              id: 'price',
              wineId: id,
              sourceName: 'Shop',
              price: 100,
              observedAt: DateTime(2026)),
        ]).judgement,
        PriceJudgement.unknown);
  });

  test(
      'foreign keys and cross-row triggers reject raw invalid links and reparenting',
      () async {
    final id = await store.addWinePurchase(
        name: 'First', purchasedQuantity: 2, volumeMl: 750);
    final second = await store.createWine(name: 'Second');
    final entry = (await store.entryForWine(id))!;
    final purchase = entry.purchases.single;
    final bottle = entry.bottles.first;
    final invalidSql = <(String, List<Object?>)>[
      ('DELETE FROM wine_records WHERE id = ?', [id]),
      (
        'UPDATE purchase_records SET purchased_quantity = 1 WHERE id = ?',
        [purchase.id]
      ),
      (
        'UPDATE purchase_records SET volume_ml = 375 WHERE id = ?',
        [purchase.id]
      ),
      (
        'UPDATE purchase_records SET wine_id = ? WHERE id = ?',
        [second, purchase.id]
      ),
      ('UPDATE bottle_records SET volume_ml = 375 WHERE id = ?', [bottle.id]),
      (
        'UPDATE bottle_records SET acquisition_kind = ? WHERE id = ?',
        ['gift', bottle.id]
      ),
      (
        'UPDATE bottle_records SET wine_id = ? WHERE id = ?',
        [second, bottle.id]
      ),
      (
        """INSERT INTO tasting_note_records (id, wine_id, bottle_id, memo, created_at)
        VALUES ('wrong-note', ?, ?, 'note', 1)""",
        [second, bottle.id]
      ),
      (
        """INSERT INTO bottle_records (id, wine_id, purchase_id, acquisition_kind, volume_ml, created_at)
        VALUES ('excess', ?, ?, 'purchase', 750, 1)""",
        [id, purchase.id]
      ),
      (
        """INSERT INTO bottle_records (id, wine_id, created_at)
        VALUES ('orphan', 'missing-wine', 1)""",
        []
      ),
    ];
    for (final (sql, args) in invalidSql) {
      await expectLater(db.customStatement(sql, args), throwsA(anything),
          reason: sql);
    }
    expect((await store.entryForWine(id))!.bottles, hasLength(2));
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
    final note = await store.addTastingNote(
        wineId: id, bottleId: bottle.id, memo: 'valid');
    await expectLater(
        store.updateTastingNote(id: note, wineId: second, memo: 'wrong'),
        throwsA(anything));
    expect((await store.findTastingNote(note))!.wineId, id);
  });

  test('invalid new purchase rolls back wine, purchase and bottles together',
      () async {
    await expectLater(
        store.addWinePurchase(
            name: 'Rollback', purchasePrice: 1, referencePrice: -5),
        throwsArgumentError);
    expect(await db.catalogSnapshot(), isEmpty);
    expect(await db.select(db.purchaseRecords).get(), isEmpty);
    expect(await db.select(db.bottleRecords).get(), isEmpty);
  });

  test('failed combined consumption saves neither note nor status', () async {
    final id = await store.createWine(name: 'Given away');
    final bottle =
        await store.addBottle(wineId: id, status: BottleStatus.gifted);
    await expectLater(
        store.addTastingNote(
            wineId: id, bottleId: bottle, memo: 'attempt', consumeBottle: true),
        throwsArgumentError);
    expect(await store.notesForWine(id), isEmpty);
    expect((await store.findBottle(bottle))!.status, BottleStatus.gifted);
  });

  test(
      'repeated tastings do not consume; status retries and archive/restock stay consistent',
      () async {
    final id = await store.createWine(name: 'Status');
    final bottle = await store.addBottle(wineId: id);
    await store.addTastingNote(
        wineId: id, bottleId: bottle, memo: 'First glass');
    await store.addTastingNote(
        wineId: id, bottleId: bottle, memo: 'Second glass');
    expect((await store.entryForWine(id))!.stockCount, 1);
    await expectLater(store.setArchived(id, true), throwsA(anything));
    await store.setBottleStatus(bottle, BottleStatus.consumed,
        changedAt: DateTime(2026, 11, 1));
    await store.setBottleStatus(bottle, BottleStatus.consumed,
        changedAt: DateTime(2026, 11, 2));
    expect((await store.findBottle(bottle))!.statusChangedAt,
        DateTime(2026, 11, 1));
    await store.setArchived(id, true);
    await store.setBottleStatus(bottle, BottleStatus.inStock);
    expect((await store.findWine(id))!.isArchived, isFalse);
    expect((await store.entryForWine(id))!.stockCount, 1);
    for (final status in [BottleStatus.gifted, BottleStatus.returned]) {
      await store.setBottleStatus(bottle, status);
      expect((await store.entryForWine(id))!.stockCount, 0);
    }
    await store.setArchived(id, true);
    await store.addBottle(wineId: id);
    expect((await store.findWine(id))!.isArchived, isFalse);
    expect(await store.notesForWine(id), hasLength(2));
  });

  test(
      'full erasure requires current impact and preserves unrelated records and shared photos',
      () async {
    final id =
        await store.createWine(name: 'Erase', imagePath: 'managed/shared.jpg');
    final other =
        await store.createWine(name: 'Keep', imagePath: 'managed/shared.jpg');
    final preview = await store.previewWineDeletion(id);
    await store.addPurchase(
        wineId: id, purchasedQuantity: 2, totalPaidKrw: 100);
    await expectLater(
        store.deleteWine(id, expected: preview), throwsStateError);
    final bottle = (await store.entryForWine(id))!.bottles.first.id;
    await store.addTastingNote(
        wineId: id,
        bottleId: bottle,
        memo: 'own',
        imagePath: 'managed/own-note.jpg');
    await store.addPriceObservation(
        wineId: id, sourceName: 'Shop', price: 100, observedAt: DateTime(2026));
    final impact = await store.previewWineDeletion(id);
    expect([impact.purchases, impact.bottles, impact.notes, impact.prices],
        [1, 2, 1, 1]);
    expect(impact.unreferencedImages, {'managed/own-note.jpg'});
    await store.deleteWine(id, expected: impact);
    expect(await store.findWine(id), isNull);
    expect(await store.findWine(other), isNotNull);
    expect(await db.select(db.purchaseRecords).get(), isEmpty);
    expect(await db.select(db.bottleRecords).get(), isEmpty);
    expect(await db.select(db.tastingNoteRecords).get(), isEmpty);
    expect(await db.select(db.priceObservationRecords).get(), isEmpty);
    expect(images.deleted, ['managed/own-note.jpg']);
    expect(await db.customSelect('PRAGMA foreign_key_check').get(), isEmpty);
  });

  test('empty notes, invalid ratings and invalid quantities are rejected',
      () async {
    final id = await store.createWine(name: 'Validation');
    await expectLater(store.addTastingNote(wineId: id), throwsArgumentError);
    for (final rating in [double.nan, double.infinity, -1.0, 5.1]) {
      await expectLater(store.addTastingNote(wineId: id, rating: rating),
          throwsArgumentError);
    }
    await expectLater(
        store.addTastingNote(wineId: id, acidity: 0), throwsArgumentError);
    await expectLater(store.addPurchase(wineId: id, purchasedQuantity: 0),
        throwsArgumentError);
    await expectLater(
        store.addPurchase(wineId: id, purchasedQuantity: 1, totalPaidKrw: -1),
        throwsArgumentError);
    expect(await db.select(db.bottleRecords).get(), isEmpty);
    expect(await db.select(db.tastingNoteRecords).get(), isEmpty);
  });

  test(
      'shared references protect images and failed cleanup stays queued for retry',
      () async {
    final id =
        await store.createWine(name: 'Photos', imagePath: 'managed/shared.jpg');
    final note = await store.addTastingNote(
        wineId: id, memo: 'shared', imagePath: 'managed/shared.jpg');
    await store.deleteTastingNote(note);
    await store.discardImage('managed/shared.jpg');
    expect(images.deleted, isEmpty);
    final orphan = await store.addTastingNote(
        wineId: id, memo: 'orphan', imagePath: 'managed/orphan.jpg');
    images.fail = true;
    await store.deleteTastingNote(orphan);
    expect(await store.findTastingNote(orphan), isNull);
    expect(await db.pendingImages(), ['managed/orphan.jpg']);
    images.fail = false;
    await store.retryImageCleanup();
    expect(images.deleted, ['managed/orphan.jpg']);
    expect(await db.pendingImages(), isEmpty);
  });
}

class RecordingImages implements ImageStore {
  final deleted = <String>[];
  bool fail = false;
  @override
  Future<String> copyIntoAppStorage(String sourcePath,
          {required String prefix}) async =>
      'managed/$prefix-new.jpg';
  @override
  Future<void> deleteManagedFile(String? filePath) async {
    if (fail) throw StateError('Temporary filesystem failure');
    if (filePath != null) deleted.add(filePath);
  }
}
