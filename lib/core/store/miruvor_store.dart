import 'package:flutter/foundation.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_filter.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:uuid/uuid.dart';

class MiruvorStore extends ChangeNotifier {
  MiruvorStore({
    required AppDatabase database,
  }) : _database = database;

  final AppDatabase _database;
  final _uuid = const Uuid();

  AppDatabase get database => _database;

  Stream<List<WineWithBottle>> watchCellar({
    WineFilter filter = const WineFilter(),
  }) {
    return _database.watchCellar().map((items) {
      return items.where((item) {
        return filter.matches(item.wine, item.bottle);
      }).toList();
    });
  }

  Stream<List<Wine>> watchWines() => _database.watchWines();

  Stream<List<TastingNote>> watchTastingNotes() {
    return _database.watchTastingNotes();
  }

  Stream<List<PriceObservation>> watchPriceObservations() {
    return _database.watchPriceObservations();
  }

  Stream<List<PriceObservation>> watchPriceObservationsForWine(String wineId) {
    return _database.watchPriceObservationsForWine(wineId);
  }

  Future<Wine?> findWine(String id) => _database.findWine(id);

  Future<Bottle?> findBottle(String id) => _database.findBottle(id);

  Future<List<TastingNote>> notesForWine(String wineId) {
    return _database.notesForWine(wineId);
  }

  Future<PriceObservation?> latestPriceForWine(String wineId) {
    return _database.latestPriceForWine(wineId);
  }

  Future<PriceObservation?> manualReferenceForWine(String wineId) {
    return _database.manualReferenceForWine(wineId);
  }

  Future<void> addWinePurchase({
    required String name,
    required String producer,
    required String country,
    required WineType type,
    required DateTime purchaseDate,
    required int purchasePrice,
    String? region,
    int? vintage,
    List<String> grapeVarieties = const [],
    String? shopName,
    String? storageLocation,
    String? imagePath,
    int? referencePrice,
  }) async {
    final wineId = _uuid.v4();
    final wine = Wine(
      id: wineId,
      name: name,
      producer: producer,
      country: country,
      region: region,
      vintage: vintage,
      type: type,
      grapeVarieties: grapeVarieties,
    );
    final bottle = Bottle(
      id: _uuid.v4(),
      wineId: wineId,
      purchaseDate: purchaseDate,
      purchasePrice: purchasePrice,
      shopName: shopName,
      storageLocation: storageLocation,
      imagePath: imagePath,
    );
    final price = referencePrice == null
        ? null
        : PriceObservation(
            id: _uuid.v4(),
            wineId: wineId,
            sourceName: 'Manual reference',
            price: referencePrice,
            observedAt: DateTime.now(),
            note: 'User-entered baseline price',
          );

    await _database.insertWinePurchase(
      wine: wine,
      bottle: bottle,
      referencePrice: price,
    );
    notifyListeners();
  }

  Future<void> updateWinePurchase({
    required String wineId,
    required String bottleId,
    required DateTime purchaseDate,
    required String name,
    required String producer,
    required String country,
    required WineType type,
    required int purchasePrice,
    String? region,
    int? vintage,
    List<String> grapeVarieties = const [],
    String? shopName,
    String? storageLocation,
    String? imagePath,
    bool isConsumed = false,
    int? referencePrice,
  }) async {
    final wine = Wine(
      id: wineId,
      name: name,
      producer: producer,
      country: country,
      region: region,
      vintage: vintage,
      type: type,
      grapeVarieties: grapeVarieties,
    );
    final bottle = Bottle(
      id: bottleId,
      wineId: wineId,
      purchaseDate: purchaseDate,
      purchasePrice: purchasePrice,
      shopName: shopName,
      storageLocation: storageLocation,
      imagePath: imagePath,
      isConsumed: isConsumed,
    );
    final price = referencePrice == null
        ? null
        : PriceObservation(
            id: _uuid.v4(),
            wineId: wineId,
            sourceName: 'Manual reference',
            price: referencePrice,
            observedAt: DateTime.now(),
            note: 'User-entered baseline price',
          );

    await _database.updateWinePurchase(
      wine: wine,
      bottle: bottle,
      referencePrice: price,
    );
    notifyListeners();
  }

  Future<void> deleteWinePurchase({
    required String wineId,
    required String bottleId,
  }) async {
    await _database.deleteWinePurchase(wineId: wineId, bottleId: bottleId);
    notifyListeners();
  }

  Future<void> addTastingNote({
    required String wineId,
    required DateTime tastedAt,
    required double rating,
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
  }) async {
    await _database.insertTastingNote(
      TastingNote(
        id: _uuid.v4(),
        wineId: wineId,
        bottleId: bottleId,
        tastedAt: tastedAt,
        rating: rating,
        imagePath: imagePath,
        aroma: aroma,
        palate: palate,
        pairing: pairing,
        acidity: acidity,
        tannin: tannin,
        body: body,
        sweetness: sweetness,
        memo: memo,
      ),
    );
    notifyListeners();
  }

  Future<void> updateTastingNote({
    required String id,
    required String wineId,
    required DateTime tastedAt,
    required double rating,
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
  }) async {
    await _database.updateTastingNote(
      TastingNote(
        id: id,
        wineId: wineId,
        bottleId: bottleId,
        tastedAt: tastedAt,
        rating: rating,
        imagePath: imagePath,
        aroma: aroma,
        palate: palate,
        pairing: pairing,
        acidity: acidity,
        tannin: tannin,
        body: body,
        sweetness: sweetness,
        memo: memo,
      ),
    );
    notifyListeners();
  }

  Future<void> deleteTastingNote(String id) async {
    await _database.deleteTastingNote(id);
    notifyListeners();
  }

  Future<void> addPriceObservation({
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    String? url,
    String? note,
    bool? isInStock,
  }) async {
    await _database.insertPriceObservation(
      PriceObservation(
        id: _uuid.v4(),
        wineId: wineId,
        sourceName: sourceName,
        price: price,
        observedAt: observedAt,
        url: url,
        note: note,
        isInStock: isInStock,
      ),
    );
    notifyListeners();
  }

  Future<void> updatePriceObservation({
    required String id,
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    String? url,
    String? note,
    bool? isInStock,
  }) async {
    await _database.updatePriceObservation(
      PriceObservation(
        id: id,
        wineId: wineId,
        sourceName: sourceName,
        price: price,
        observedAt: observedAt,
        url: url,
        note: note,
        isInStock: isInStock,
      ),
    );
    notifyListeners();
  }

  Future<void> deletePriceObservation(String id) async {
    await _database.deletePriceObservation(id);
    notifyListeners();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }
}
