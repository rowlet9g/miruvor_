import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/purchase.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_filter.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:uuid/uuid.dart';

class MiruvorStore extends ChangeNotifier {
  MiruvorStore({required AppDatabase database, ImageStore? imageStore})
      : _database = database,
        _imageStore = imageStore ?? LocalImageStore() {
    unawaited(retryImageCleanup().catchError((Object error) {
      debugPrint('Image cleanup deferred: $error');
    }));
  }

  final AppDatabase _database;
  final ImageStore _imageStore;
  final _uuid = const Uuid();
  Future<void> _pending = Future.value();
  bool _disposed = false;
  Future<void>? _closing;

  AppDatabase get database => _database;

  Stream<List<WineEntry>> watchCatalog({
    WineFilter filter = const WineFilter(),
    bool archived = false,
  }) =>
      _database.watchCatalog().map((entries) => entries
          .where((entry) =>
              entry.wine.isArchived == archived && filter.matchesEntry(entry))
          .toList());

  Stream<List<WineWithBottle>> watchCellar(
          {WineFilter filter = const WineFilter()}) =>
      _database.watchCellar().map((items) => items
          .where((item) => filter.matches(item.wine, item.purchasePrice))
          .toList());
  Stream<List<Wine>> watchWines() => _database.watchWines();
  Stream<List<TastingNote>> watchTastingNotes() =>
      _database.watchTastingNotes();
  Stream<List<PriceObservation>> watchPriceObservations() =>
      _database.watchPriceObservations();
  Stream<List<PriceObservation>> watchPriceObservationsForWine(String id) =>
      _database.watchPriceObservationsForWine(id);
  Future<Wine?> findWine(String id) => _database.findWine(id);
  Future<Purchase?> findPurchase(String id) => _database.findPurchase(id);
  Future<Bottle?> findBottle(String id) => _database.findBottle(id);
  Future<TastingNote?> findTastingNote(String id) =>
      _database.findTastingNote(id);
  Future<List<TastingNote>> notesForWine(String id) =>
      _database.notesForWine(id);
  Future<PriceObservation?> latestPriceForWine(String id) =>
      _database.latestPriceForWine(id);
  Future<WineEntry?> entryForWine(String id) async {
    for (final entry in await _database.catalogSnapshot()) {
      if (entry.wine.id == id) return entry;
    }
    return null;
  }

  Future<String> importImage(String sourcePath, {required String prefix}) =>
      _imageStore.copyIntoAppStorage(sourcePath, prefix: prefix);
  Future<void> discardImage(String? imagePath) => _write(() async {
        await _queueImages([imagePath]);
      });

  Future<String> createWine({
    String? name,
    String? producer,
    String? country,
    String? region,
    int? vintage,
    VintageKind? vintageKind,
    WineType? type,
    List<String> grapeVarieties = const [],
    String? imagePath,
    bool isWishlisted = false,
  }) =>
      _write(() async {
        final id = _uuid.v4();
        await _database.insertWine(Wine(
            id: id,
            name: _text(name),
            producer: _text(producer),
            country: _text(country),
            region: _text(region),
            vintage: vintage,
            vintageKind: vintageKind,
            type: type,
            grapeVarieties: grapeVarieties,
            imagePath: imagePath,
            isWishlisted: isWishlisted));
        return id;
      });

  Future<void> saveWine(Wine wine) => _write(() async {
        final previous = await _database.findWine(wine.id);
        await _database.updateWine(wine);
        if (previous?.imagePath != wine.imagePath) {
          await _queueImages([previous?.imagePath]);
        }
      });

  Future<String> addPurchase({
    required String wineId,
    required int purchasedQuantity,
    int? totalPaidKrw,
    DateTime? purchaseDate,
    String? shopName,
    int? volumeMl,
    String? note,
    String? storageLocation,
    BottleStatus status = BottleStatus.inStock,
  }) =>
      _write(() => _insertPurchase(
          wineId: wineId,
          purchasedQuantity: purchasedQuantity,
          totalPaidKrw: totalPaidKrw,
          purchaseDate: purchaseDate,
          shopName: shopName,
          volumeMl: volumeMl,
          note: note,
          storageLocation: storageLocation,
          status: status));

  Future<String> _insertPurchase({
    required String wineId,
    required int purchasedQuantity,
    int? totalPaidKrw,
    DateTime? purchaseDate,
    String? shopName,
    int? volumeMl,
    String? note,
    String? storageLocation,
    String? imagePath,
    BottleStatus status = BottleStatus.inStock,
  }) async {
    if (purchasedQuantity < 1) throw ArgumentError('구매 수량은 1병 이상입니다.');
    final id = _uuid.v4();
    await _database.insertPurchase(
      Purchase(
          id: id,
          wineId: wineId,
          purchasedQuantity: purchasedQuantity,
          totalPaidKrw: totalPaidKrw,
          purchaseDate: purchaseDate,
          shopName: _text(shopName),
          volumeMl: volumeMl,
          note: _text(note)),
      List.generate(
          purchasedQuantity,
          (_) => Bottle(
              id: _uuid.v4(),
              wineId: wineId,
              purchaseId: id,
              acquisitionKind: AcquisitionKind.purchase,
              volumeMl: volumeMl,
              status: status,
              storageLocation: _text(storageLocation),
              imagePath: imagePath)),
    );
    return id;
  }

  // Convenience operation for creating a new wine and its first purchase atomically.
  Future<String> addWinePurchase({
    String? name,
    String? producer,
    String? country,
    WineType? type,
    DateTime? purchaseDate,
    int? purchasePrice,
    String? region,
    int? vintage,
    VintageKind? vintageKind,
    List<String> grapeVarieties = const [],
    String? shopName,
    String? storageLocation,
    String? imagePath,
    int? referencePrice,
    int purchasedQuantity = 1,
    int? volumeMl,
    bool isConsumed = false,
  }) =>
      _write(() async {
        final wineId = _uuid.v4();
        await _database.insertWine(Wine(
            id: wineId,
            name: _text(name),
            producer: _text(producer),
            country: _text(country),
            region: _text(region),
            vintage: vintage,
            vintageKind: vintageKind,
            type: type,
            grapeVarieties: grapeVarieties));
        await _insertPurchase(
            wineId: wineId,
            purchasedQuantity: purchasedQuantity,
            totalPaidKrw: purchasePrice,
            purchaseDate: purchaseDate,
            shopName: shopName,
            volumeMl: volumeMl,
            storageLocation: storageLocation,
            imagePath: imagePath,
            status: isConsumed ? BottleStatus.consumed : BottleStatus.inStock);
        if (referencePrice != null) {
          await _database.insertPriceObservation(PriceObservation(
              id: _uuid.v4(),
              wineId: wineId,
              sourceName: 'Manual reference',
              price: referencePrice,
              observedAt: DateTime.now(),
              volumeMl: volumeMl));
        }
        return wineId;
      });

  Future<void> savePurchase(Purchase purchase) =>
      _write(() => _database.updatePurchase(purchase));
  Future<void> deletePurchase(String id) =>
      _write(() => _database.deletePurchase(id));

  Future<String> addBottle({
    required String wineId,
    String? purchaseId,
    AcquisitionKind acquisitionKind = AcquisitionKind.gift,
    DateTime? acquiredAt,
    int? volumeMl,
    String? storageLocation,
    String? imagePath,
    BottleStatus status = BottleStatus.inStock,
    DateTime? statusChangedAt,
  }) =>
      _write(() async {
        final id = _uuid.v4();
        await _database.insertBottle(Bottle(
            id: id,
            wineId: wineId,
            purchaseId: purchaseId,
            acquisitionKind: acquisitionKind,
            acquiredAt: acquiredAt,
            volumeMl: volumeMl,
            storageLocation: _text(storageLocation),
            imagePath: imagePath,
            status: status,
            statusChangedAt: statusChangedAt));
        return id;
      });

  Future<void> saveBottle(Bottle bottle) => _write(() async {
        final previous = await _database.findBottle(bottle.id);
        await _database.updateBottle(bottle);
        if (previous?.imagePath != bottle.imagePath) {
          await _queueImages([previous?.imagePath]);
        }
      });

  Future<void> setBottleStatus(String id, BottleStatus status,
          {DateTime? changedAt}) =>
      _write(() => _setBottleStatus(id, status, changedAt));
  Future<void> _setBottleStatus(
      String id, BottleStatus status, DateTime? changedAt) async {
    final bottle = await _database.findBottle(id);
    if (bottle == null) throw StateError('병 기록을 찾을 수 없습니다.');
    if (bottle.status == status) return;
    await _database.updateBottle(bottle.withStatus(status, changedAt));
  }

  Future<void> deleteBottle(String id) => _write(() async {
        final bottle = await _database.findBottle(id);
        await _database.deleteBottle(id);
        await _queueImages([bottle?.imagePath]);
      });
  Future<void> setArchived(String wineId, bool archived) =>
      _write(() => _database.setArchived(wineId, archived));

  Future<WineDeletionImpact> previewWineDeletion(String id) =>
      _serial(() => _database.transaction(() => _database.deletionImpact(id)));
  Future<void> deleteWine(String id, {required WineDeletionImpact expected}) =>
      _write(() async {
        final current = await _database.deletionImpact(id);
        if (expected.signature != current.signature) {
          throw StateError('관련 기록이 변경되었습니다. 삭제 범위를 다시 확인해 주세요.');
        }
        await _database.deleteWine(id);
        await _queueImages(current.imagePaths);
      });

  Future<String> addTastingNote({
    required String wineId,
    DateTime? tastedAt,
    double? rating,
    String? bottleId,
    String? imagePath,
    String? aroma,
    String? palate,
    String? pairing,
    int? acidity,
    int? tannin,
    int? body,
    int? sweetness,
    String? memo,
    BuyAgain? buyAgain,
    bool consumeBottle = false,
  }) =>
      _write(() async {
        final id = _uuid.v4();
        await _database.insertTastingNote(TastingNote(
            id: id,
            wineId: wineId,
            bottleId: bottleId,
            tastedAt: tastedAt,
            rating: rating,
            imagePath: imagePath,
            aroma: _text(aroma),
            palate: _text(palate),
            pairing: _text(pairing),
            acidity: acidity,
            tannin: tannin,
            body: body,
            sweetness: sweetness,
            memo: _text(memo),
            buyAgain: buyAgain));
        if (consumeBottle) {
          final bottle =
              bottleId == null ? null : await _database.findBottle(bottleId);
          if (bottle == null ||
              (bottle.status != BottleStatus.inStock &&
                  bottle.status != BottleStatus.consumed)) {
            throw ArgumentError('소비 처리할 보유 병을 선택해 주세요.');
          }
          await _setBottleStatus(bottle.id, BottleStatus.consumed, tastedAt);
        }
        return id;
      });

  Future<void> updateTastingNote({
    required String id,
    required String wineId,
    DateTime? tastedAt,
    double? rating,
    String? bottleId,
    String? imagePath,
    String? aroma,
    String? palate,
    String? pairing,
    int? acidity,
    int? tannin,
    int? body,
    int? sweetness,
    String? memo,
    BuyAgain? buyAgain,
  }) =>
      _write(() async {
        final previous = await _database.findTastingNote(id);
        await _database.updateTastingNote(TastingNote(
            id: id,
            wineId: wineId,
            bottleId: bottleId,
            tastedAt: tastedAt,
            rating: rating,
            imagePath: imagePath,
            aroma: _text(aroma),
            palate: _text(palate),
            pairing: _text(pairing),
            acidity: acidity,
            tannin: tannin,
            body: body,
            sweetness: sweetness,
            memo: _text(memo),
            buyAgain: buyAgain));
        if (previous?.imagePath != imagePath) {
          await _queueImages([previous?.imagePath]);
        }
      });

  Future<void> deleteTastingNote(String id) => _write(() async {
        final note = await _database.findTastingNote(id);
        await _database.deleteTastingNote(id);
        await _queueImages([note?.imagePath]);
      });

  Future<void> addPriceObservation({
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    String? url,
    String? note,
    bool? isInStock,
    int? volumeMl,
  }) =>
      _write(() => _database.insertPriceObservation(PriceObservation(
          id: _uuid.v4(),
          wineId: wineId,
          sourceName: sourceName,
          price: price,
          observedAt: observedAt,
          url: url,
          note: note,
          isInStock: isInStock,
          volumeMl: volumeMl)));

  Future<void> updatePriceObservation({
    required String id,
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    String? url,
    String? note,
    bool? isInStock,
    int? volumeMl,
  }) =>
      _write(() => _database.updatePriceObservation(PriceObservation(
          id: id,
          wineId: wineId,
          sourceName: sourceName,
          price: price,
          observedAt: observedAt,
          url: url,
          note: note,
          isInStock: isInStock,
          volumeMl: volumeMl)));

  Future<void> deletePriceObservation(String id) =>
      _write(() => _database.deletePriceObservation(id));

  Future<void> _queueImages(Iterable<String?> paths) async {
    for (final path in paths.whereType<String>().toSet()) {
      await _database.queueImageDeletion(path);
    }
  }

  Future<void> retryImageCleanup() => _serial(_cleanImages);
  Future<void> _cleanImages() async {
    final paths = await _database.pendingImages();
    for (final path in paths) {
      try {
        final references =
            (await _database.imageReferences()).map(imageKey).toSet();
        if (!references.contains(imageKey(path))) {
          await _imageStore.deleteManagedFile(path);
        }
        await _database.finishImageDeletion(path);
      } catch (error) {
        // The durable queue survives app restarts. A committed DB change stays
        // successful even when the filesystem is temporarily unavailable.
        debugPrint('Image cleanup deferred for $path: $error');
      }
    }
  }

  Future<T> _write<T>(Future<T> Function() action) => _serial(() async {
        final result = await _database.transaction(action);
        try {
          await _cleanImages();
        } catch (error) {
          debugPrint('Image cleanup deferred: $error');
        }
        if (!_disposed) notifyListeners();
        return result;
      });

  // All application writes and reference checks/file cleanup share this queue.
  Future<T> _serial<T>(Future<T> Function() action) {
    if (_disposed) return Future.error(StateError('저장소가 닫혔습니다.'));
    final result = _pending.then((_) => action());
    _pending =
        result.then<void>((_) {}, onError: (Object error, StackTrace stack) {});
    return result;
  }

  String? _text(String? value) =>
      value == null || value.trim().isEmpty ? null : value.trim();

  Future<void> close() {
    _disposed = true;
    return _closing ??= _closeDatabase();
  }

  Future<void> _closeDatabase() async {
    await _pending;
    await _database.close();
  }

  @override
  void dispose() {
    unawaited(close());
    super.dispose();
  }
}
