part of 'app_database.dart';

mixin RecordTimes on Table {
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
}

class WineRecords extends Table with RecordTimes {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get producer => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get vintageKind => text().withDefault(const Constant('unknown'))();
  TextColumn get type => text().nullable()();
  TextColumn get grapeVarietiesJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get imagePath => text().nullable()();
  BoolColumn get isWishlisted => boolean().withDefault(const Constant(false))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  @override
  Set<Column<Object>> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
        "CHECK (length(trim(coalesce(name, ''))) > 0 OR length(trim(coalesce(image_path, ''))) > 0)",
        "CHECK ((vintage_kind = 'year' AND vintage IS NOT NULL) OR (vintage_kind IN ('nonVintage', 'unknown') AND vintage IS NULL))",
        "CHECK (type IS NULL OR type IN ('red','white','rose','sparkling','fortified','dessert','other'))",
      ];
}

@TableIndex(name: 'purchase_wine_idx', columns: {#wineId})
class PurchaseRecords extends Table with RecordTimes {
  TextColumn get id => text()();
  TextColumn get wineId =>
      text().references(WineRecords, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  TextColumn get shopName => text().nullable()();
  IntColumn get purchasedQuantity => integer()();
  IntColumn get totalPaidKrw => integer().nullable()();
  IntColumn get volumeMl => integer().nullable()();
  TextColumn get note => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
        'CHECK (purchased_quantity > 0)',
        'CHECK (total_paid_krw IS NULL OR total_paid_krw >= 0)',
        'CHECK (volume_ml IS NULL OR volume_ml > 0)',
      ];
}

@TableIndex(name: 'bottle_wine_idx', columns: {#wineId})
@TableIndex(name: 'bottle_purchase_idx', columns: {#purchaseId})
class BottleRecords extends Table with RecordTimes {
  TextColumn get id => text()();
  TextColumn get wineId =>
      text().references(WineRecords, #id, onDelete: KeyAction.restrict)();
  TextColumn get purchaseId => text()
      .nullable()
      .references(PurchaseRecords, #id, onDelete: KeyAction.setNull)();
  TextColumn get acquisitionKind =>
      text().withDefault(const Constant('unknown'))();
  DateTimeColumn get acquiredAt => dateTime().nullable()();
  IntColumn get volumeMl => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('inStock'))();
  DateTimeColumn get statusChangedAt => dateTime().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get storageLocation => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
        "CHECK (acquisition_kind IN ('purchase','gift','other','unknown'))",
        "CHECK (status IN ('inStock','consumed','gifted','returned'))",
        "CHECK (purchase_id IS NULL OR acquisition_kind = 'purchase')",
        'CHECK (volume_ml IS NULL OR volume_ml > 0)',
      ];
}

@TableIndex(name: 'note_wine_idx', columns: {#wineId})
@TableIndex(name: 'note_bottle_idx', columns: {#bottleId})
class TastingNoteRecords extends Table with RecordTimes {
  TextColumn get id => text()();
  TextColumn get wineId =>
      text().references(WineRecords, #id, onDelete: KeyAction.restrict)();
  TextColumn get bottleId => text()
      .nullable()
      .references(BottleRecords, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get tastedAt => dateTime().nullable()();
  RealColumn get rating => real().nullable()();
  TextColumn get imagePath => text().nullable()();
  TextColumn get aroma => text().nullable()();
  TextColumn get palate => text().nullable()();
  TextColumn get pairing => text().nullable()();
  IntColumn get acidity => integer().nullable()();
  IntColumn get tannin => integer().nullable()();
  IntColumn get body => integer().nullable()();
  IntColumn get sweetness => integer().nullable()();
  TextColumn get memo => text().nullable()();
  TextColumn get buyAgain => text().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
        'CHECK (rating IS NULL OR rating BETWEEN 0 AND 5)',
        'CHECK (acidity IS NULL OR acidity BETWEEN 1 AND 5)',
        'CHECK (tannin IS NULL OR tannin BETWEEN 1 AND 5)',
        'CHECK (body IS NULL OR body BETWEEN 1 AND 5)',
        'CHECK (sweetness IS NULL OR sweetness BETWEEN 1 AND 5)',
        "CHECK (buy_again IS NULL OR buy_again IN ('yes','no','unsure'))",
        """CHECK (rating IS NOT NULL OR buy_again IS NOT NULL OR acidity IS NOT NULL OR tannin IS NOT NULL
      OR body IS NOT NULL OR sweetness IS NOT NULL OR
      length(trim(coalesce(image_path,'') || coalesce(aroma,'') || coalesce(palate,'') ||
      coalesce(pairing,'') || coalesce(memo,''))) > 0)""",
      ];
}

@TableIndex(name: 'price_wine_idx', columns: {#wineId})
class PriceObservationRecords extends Table with RecordTimes {
  TextColumn get id => text()();
  TextColumn get wineId =>
      text().references(WineRecords, #id, onDelete: KeyAction.restrict)();
  TextColumn get sourceName => text()();
  IntColumn get price => integer()();
  DateTimeColumn get observedAt => dateTime()();
  TextColumn get url => text().nullable()();
  TextColumn get note => text().nullable()();
  BoolColumn get isInStock => boolean().nullable()();
  IntColumn get volumeMl => integer().nullable()();
  @override
  Set<Column<Object>> get primaryKey => {id};
  @override
  List<String> get customConstraints => [
        'CHECK (price >= 0)',
        'CHECK (volume_ml IS NULL OR volume_ml > 0)',
      ];
}

class PendingImageDeletions extends Table {
  TextColumn get path => text()();
  DateTimeColumn get requestedAt => dateTime()();
  @override
  Set<Column<Object>> get primaryKey => {path};
}
