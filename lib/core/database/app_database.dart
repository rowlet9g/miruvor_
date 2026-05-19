import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:miruvor/core/models/bottle.dart';
import 'package:miruvor/core/models/price_observation.dart';
import 'package:miruvor/core/models/tasting_note.dart';
import 'package:miruvor/core/models/wine.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class WineRecords extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get producer => text()();
  TextColumn get country => text()();
  TextColumn get region => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get type => text()();
  TextColumn get grapeVarietiesJson =>
      text().withDefault(const Constant('[]'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class BottleRecords extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text().references(WineRecords, #id)();
  DateTimeColumn get purchaseDate => dateTime()();
  IntColumn get purchasePrice => integer()();
  TextColumn get shopName => text().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get storageLocation => text().nullable()();
  BoolColumn get isConsumed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TastingNoteRecords extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text().references(WineRecords, #id)();
  TextColumn get bottleId => text().nullable().references(BottleRecords, #id)();
  DateTimeColumn get tastedAt => dateTime()();
  RealColumn get rating => real()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get aroma => text().nullable()();
  TextColumn get palate => text().nullable()();
  TextColumn get pairing => text().nullable()();
  IntColumn get acidity => integer().nullable()();
  IntColumn get tannin => integer().nullable()();
  IntColumn get body => integer().nullable()();
  IntColumn get sweetness => integer().nullable()();
  TextColumn get memo => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PriceObservationRecords extends Table {
  TextColumn get id => text()();
  TextColumn get wineId => text().references(WineRecords, #id)();
  TextColumn get sourceName => text()();
  IntColumn get price => integer()();
  DateTimeColumn get observedAt => dateTime()();
  TextColumn get url => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isInStock => boolean().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    WineRecords,
    BottleRecords,
    TastingNoteRecords,
    PriceObservationRecords,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.inMemory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  Future<List<WineWithBottle>> watchCellarSnapshotOnce() async {
    final rows = await (select(bottleRecords).join([
      innerJoin(wineRecords, wineRecords.id.equalsExp(bottleRecords.wineId)),
    ])
          ..orderBy([OrderingTerm.desc(bottleRecords.purchaseDate)]))
        .get();

    return rows.map((row) {
      return WineWithBottle(
        wine: _wineFromRecord(row.readTable(wineRecords)),
        bottle: _bottleFromRecord(row.readTable(bottleRecords)),
      );
    }).toList();
  }

  Stream<List<WineWithBottle>> watchCellar() {
    final query = select(bottleRecords).join([
      innerJoin(wineRecords, wineRecords.id.equalsExp(bottleRecords.wineId)),
    ])
      ..orderBy([OrderingTerm.desc(bottleRecords.purchaseDate)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return WineWithBottle(
          wine: _wineFromRecord(row.readTable(wineRecords)),
          bottle: _bottleFromRecord(row.readTable(bottleRecords)),
        );
      }).toList();
    });
  }

  Stream<List<Wine>> watchWines() {
    return (select(wineRecords)..orderBy([(row) => OrderingTerm.asc(row.name)]))
        .watch()
        .map((rows) => rows.map(_wineFromRecord).toList());
  }

  Stream<List<TastingNote>> watchTastingNotes() {
    return (select(tastingNoteRecords)
          ..orderBy([(row) => OrderingTerm.desc(row.tastedAt)]))
        .watch()
        .map((rows) => rows.map(_tastingNoteFromRecord).toList());
  }

  Stream<List<PriceObservation>> watchPriceObservations() {
    return (select(priceObservationRecords)
          ..orderBy([(row) => OrderingTerm.desc(row.observedAt)]))
        .watch()
        .map((rows) => rows.map(_priceObservationFromRecord).toList());
  }

  Future<Wine?> findWine(String id) async {
    final row = await (select(wineRecords)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _wineFromRecord(row);
  }

  Future<Bottle?> findBottle(String id) async {
    final row = await (select(bottleRecords)
          ..where((table) => table.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _bottleFromRecord(row);
  }

  Future<List<TastingNote>> notesForWine(String wineId) async {
    final rows = await (select(tastingNoteRecords)
          ..where((table) => table.wineId.equals(wineId))
          ..orderBy([(row) => OrderingTerm.desc(row.tastedAt)]))
        .get();
    return rows.map(_tastingNoteFromRecord).toList();
  }

  Future<PriceObservation?> latestPriceForWine(String wineId) async {
    final row = await (select(priceObservationRecords)
          ..where((table) => table.wineId.equals(wineId))
          ..orderBy([(row) => OrderingTerm.desc(row.observedAt)])
          ..limit(1))
        .getSingleOrNull();
    return row == null ? null : _priceObservationFromRecord(row);
  }

  Future<void> insertWinePurchase({
    required Wine wine,
    required Bottle bottle,
    PriceObservation? referencePrice,
  }) {
    final now = DateTime.now();

    return transaction(() async {
      await into(wineRecords).insertOnConflictUpdate(
        WineRecordsCompanion.insert(
          id: wine.id,
          name: wine.name,
          producer: wine.producer,
          country: wine.country,
          region: Value(wine.region),
          vintage: Value(wine.vintage),
          type: wine.type.name,
          grapeVarietiesJson: Value(jsonEncode(wine.grapeVarieties)),
          createdAt: now,
          updatedAt: now,
        ),
      );

      await into(bottleRecords).insert(
        BottleRecordsCompanion.insert(
          id: bottle.id,
          wineId: bottle.wineId,
          purchaseDate: bottle.purchaseDate,
          purchasePrice: bottle.purchasePrice,
          shopName: Value(bottle.shopName),
          imagePath: Value(bottle.imagePath),
          storageLocation: Value(bottle.storageLocation),
          isConsumed: Value(bottle.isConsumed),
          createdAt: now,
          updatedAt: now,
        ),
      );

      if (referencePrice != null) {
        await into(priceObservationRecords).insert(
          PriceObservationRecordsCompanion.insert(
            id: referencePrice.id,
            wineId: referencePrice.wineId,
            sourceName: referencePrice.sourceName,
            price: referencePrice.price,
            observedAt: referencePrice.observedAt,
            url: Value(referencePrice.url),
            note: Value(referencePrice.note),
            isInStock: Value(referencePrice.isInStock),
            createdAt: now,
          ),
        );
      }
    });
  }

  Future<void> updateWinePurchase({
    required Wine wine,
    required Bottle bottle,
    PriceObservation? referencePrice,
  }) {
    final now = DateTime.now();

    return transaction(() async {
      await (update(wineRecords)..where((table) => table.id.equals(wine.id)))
          .write(
        WineRecordsCompanion(
          name: Value(wine.name),
          producer: Value(wine.producer),
          country: Value(wine.country),
          region: Value(wine.region),
          vintage: Value(wine.vintage),
          type: Value(wine.type.name),
          grapeVarietiesJson: Value(jsonEncode(wine.grapeVarieties)),
          updatedAt: Value(now),
        ),
      );

      await (update(bottleRecords)
            ..where((table) => table.id.equals(bottle.id)))
          .write(
        BottleRecordsCompanion(
          purchaseDate: Value(bottle.purchaseDate),
          purchasePrice: Value(bottle.purchasePrice),
          shopName: Value(bottle.shopName),
          imagePath: Value(bottle.imagePath),
          storageLocation: Value(bottle.storageLocation),
          isConsumed: Value(bottle.isConsumed),
          updatedAt: Value(now),
        ),
      );

      await (delete(priceObservationRecords)
            ..where((table) => table.wineId.equals(wine.id)))
          .go();

      if (referencePrice != null) {
        await into(priceObservationRecords).insert(
          PriceObservationRecordsCompanion.insert(
            id: referencePrice.id,
            wineId: referencePrice.wineId,
            sourceName: referencePrice.sourceName,
            price: referencePrice.price,
            observedAt: referencePrice.observedAt,
            url: Value(referencePrice.url),
            note: Value(referencePrice.note),
            isInStock: Value(referencePrice.isInStock),
            createdAt: now,
          ),
        );
      }
    });
  }

  Future<void> deleteWinePurchase({
    required String wineId,
    required String bottleId,
  }) {
    return transaction(() async {
      await (delete(priceObservationRecords)
            ..where((table) => table.wineId.equals(wineId)))
          .go();
      await (delete(tastingNoteRecords)
            ..where((table) => table.wineId.equals(wineId)))
          .go();
      await (delete(bottleRecords)..where((table) => table.id.equals(bottleId)))
          .go();
      await (delete(wineRecords)..where((table) => table.id.equals(wineId)))
          .go();
    });
  }

  Future<void> insertTastingNote(TastingNote note) {
    final now = DateTime.now();

    return into(tastingNoteRecords).insert(
      TastingNoteRecordsCompanion.insert(
        id: note.id,
        wineId: note.wineId,
        bottleId: Value(note.bottleId),
        tastedAt: note.tastedAt,
        rating: note.rating,
        imagePath: Value(note.imagePath),
        aroma: Value(note.aroma),
        palate: Value(note.palate),
        pairing: Value(note.pairing),
        acidity: Value(note.acidity),
        tannin: Value(note.tannin),
        body: Value(note.body),
        sweetness: Value(note.sweetness),
        memo: Value(note.memo),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<void> updateTastingNote(TastingNote note) {
    final now = DateTime.now();

    return (update(tastingNoteRecords)
          ..where((table) => table.id.equals(note.id)))
        .write(
      TastingNoteRecordsCompanion(
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
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> deleteTastingNote(String id) {
    return (delete(tastingNoteRecords)..where((table) => table.id.equals(id)))
        .go();
  }

  Wine _wineFromRecord(WineRecord row) {
    return Wine(
      id: row.id,
      name: row.name,
      producer: row.producer,
      country: row.country,
      region: row.region,
      vintage: row.vintage,
      type: WineType.values.firstWhere(
        (type) => type.name == row.type,
        orElse: () => WineType.other,
      ),
      grapeVarieties: _decodeGrapeVarieties(row.grapeVarietiesJson),
    );
  }

  Bottle _bottleFromRecord(BottleRecord row) {
    return Bottle(
      id: row.id,
      wineId: row.wineId,
      purchaseDate: row.purchaseDate,
      purchasePrice: row.purchasePrice,
      shopName: row.shopName,
      imagePath: row.imagePath,
      storageLocation: row.storageLocation,
      isConsumed: row.isConsumed,
    );
  }

  TastingNote _tastingNoteFromRecord(TastingNoteRecord row) {
    return TastingNote(
      id: row.id,
      wineId: row.wineId,
      bottleId: row.bottleId,
      tastedAt: row.tastedAt,
      rating: row.rating,
      imagePath: row.imagePath,
      aroma: row.aroma,
      palate: row.palate,
      pairing: row.pairing,
      acidity: row.acidity,
      tannin: row.tannin,
      body: row.body,
      sweetness: row.sweetness,
      memo: row.memo,
    );
  }

  PriceObservation _priceObservationFromRecord(PriceObservationRecord row) {
    return PriceObservation(
      id: row.id,
      wineId: row.wineId,
      sourceName: row.sourceName,
      price: row.price,
      observedAt: row.observedAt,
      url: row.url,
      note: row.note,
      isInStock: row.isInStock,
    );
  }

  List<String> _decodeGrapeVarieties(String jsonText) {
    final decoded = jsonDecode(jsonText);
    if (decoded is! List) {
      return const [];
    }

    return decoded.whereType<String>().toList();
  }
}

class WineWithBottle {
  const WineWithBottle({
    required this.wine,
    required this.bottle,
  });

  final Wine wine;
  final Bottle bottle;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(appDocDir.path, 'miruvor.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
