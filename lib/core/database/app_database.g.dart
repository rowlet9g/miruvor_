// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WineRecordsTable extends WineRecords
    with TableInfo<$WineRecordsTable, WineRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _producerMeta =
      const VerificationMeta('producer');
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
      'producer', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vintageMeta =
      const VerificationMeta('vintage');
  @override
  late final GeneratedColumn<int> vintage = GeneratedColumn<int>(
      'vintage', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grapeVarietiesJsonMeta =
      const VerificationMeta('grapeVarietiesJson');
  @override
  late final GeneratedColumn<String> grapeVarietiesJson =
      GeneratedColumn<String>('grape_varieties_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        producer,
        country,
        region,
        vintage,
        type,
        grapeVarietiesJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wine_records';
  @override
  VerificationContext validateIntegrity(Insertable<WineRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('producer')) {
      context.handle(_producerMeta,
          producer.isAcceptableOrUnknown(data['producer']!, _producerMeta));
    } else if (isInserting) {
      context.missing(_producerMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('vintage')) {
      context.handle(_vintageMeta,
          vintage.isAcceptableOrUnknown(data['vintage']!, _vintageMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('grape_varieties_json')) {
      context.handle(
          _grapeVarietiesJsonMeta,
          grapeVarietiesJson.isAcceptableOrUnknown(
              data['grape_varieties_json']!, _grapeVarietiesJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      producer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}producer'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      vintage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vintage']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      grapeVarietiesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}grape_varieties_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WineRecordsTable createAlias(String alias) {
    return $WineRecordsTable(attachedDatabase, alias);
  }
}

class WineRecord extends DataClass implements Insertable<WineRecord> {
  final String id;
  final String name;
  final String producer;
  final String country;
  final String? region;
  final int? vintage;
  final String type;
  final String grapeVarietiesJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WineRecord(
      {required this.id,
      required this.name,
      required this.producer,
      required this.country,
      this.region,
      this.vintage,
      required this.type,
      required this.grapeVarietiesJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['producer'] = Variable<String>(producer);
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || vintage != null) {
      map['vintage'] = Variable<int>(vintage);
    }
    map['type'] = Variable<String>(type);
    map['grape_varieties_json'] = Variable<String>(grapeVarietiesJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WineRecordsCompanion toCompanion(bool nullToAbsent) {
    return WineRecordsCompanion(
      id: Value(id),
      name: Value(name),
      producer: Value(producer),
      country: Value(country),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      vintage: vintage == null && nullToAbsent
          ? const Value.absent()
          : Value(vintage),
      type: Value(type),
      grapeVarietiesJson: Value(grapeVarietiesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WineRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      producer: serializer.fromJson<String>(json['producer']),
      country: serializer.fromJson<String>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      type: serializer.fromJson<String>(json['type']),
      grapeVarietiesJson:
          serializer.fromJson<String>(json['grapeVarietiesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'producer': serializer.toJson<String>(producer),
      'country': serializer.toJson<String>(country),
      'region': serializer.toJson<String?>(region),
      'vintage': serializer.toJson<int?>(vintage),
      'type': serializer.toJson<String>(type),
      'grapeVarietiesJson': serializer.toJson<String>(grapeVarietiesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WineRecord copyWith(
          {String? id,
          String? name,
          String? producer,
          String? country,
          Value<String?> region = const Value.absent(),
          Value<int?> vintage = const Value.absent(),
          String? type,
          String? grapeVarietiesJson,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      WineRecord(
        id: id ?? this.id,
        name: name ?? this.name,
        producer: producer ?? this.producer,
        country: country ?? this.country,
        region: region.present ? region.value : this.region,
        vintage: vintage.present ? vintage.value : this.vintage,
        type: type ?? this.type,
        grapeVarietiesJson: grapeVarietiesJson ?? this.grapeVarietiesJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WineRecord copyWithCompanion(WineRecordsCompanion data) {
    return WineRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      producer: data.producer.present ? data.producer.value : this.producer,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      vintage: data.vintage.present ? data.vintage.value : this.vintage,
      type: data.type.present ? data.type.value : this.type,
      grapeVarietiesJson: data.grapeVarietiesJson.present
          ? data.grapeVarietiesJson.value
          : this.grapeVarietiesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('vintage: $vintage, ')
          ..write('type: $type, ')
          ..write('grapeVarietiesJson: $grapeVarietiesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, producer, country, region, vintage,
      type, grapeVarietiesJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.producer == this.producer &&
          other.country == this.country &&
          other.region == this.region &&
          other.vintage == this.vintage &&
          other.type == this.type &&
          other.grapeVarietiesJson == this.grapeVarietiesJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WineRecordsCompanion extends UpdateCompanion<WineRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> producer;
  final Value<String> country;
  final Value<String?> region;
  final Value<int?> vintage;
  final Value<String> type;
  final Value<String> grapeVarietiesJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WineRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.producer = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.vintage = const Value.absent(),
    this.type = const Value.absent(),
    this.grapeVarietiesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineRecordsCompanion.insert({
    required String id,
    required String name,
    required String producer,
    required String country,
    this.region = const Value.absent(),
    this.vintage = const Value.absent(),
    required String type,
    this.grapeVarietiesJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        producer = Value(producer),
        country = Value(country),
        type = Value(type),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<WineRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? producer,
    Expression<String>? country,
    Expression<String>? region,
    Expression<int>? vintage,
    Expression<String>? type,
    Expression<String>? grapeVarietiesJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (producer != null) 'producer': producer,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (vintage != null) 'vintage': vintage,
      if (type != null) 'type': type,
      if (grapeVarietiesJson != null)
        'grape_varieties_json': grapeVarietiesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WineRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? producer,
      Value<String>? country,
      Value<String?>? region,
      Value<int?>? vintage,
      Value<String>? type,
      Value<String>? grapeVarietiesJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return WineRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      producer: producer ?? this.producer,
      country: country ?? this.country,
      region: region ?? this.region,
      vintage: vintage ?? this.vintage,
      type: type ?? this.type,
      grapeVarietiesJson: grapeVarietiesJson ?? this.grapeVarietiesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (vintage.present) {
      map['vintage'] = Variable<int>(vintage.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (grapeVarietiesJson.present) {
      map['grape_varieties_json'] = Variable<String>(grapeVarietiesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('vintage: $vintage, ')
          ..write('type: $type, ')
          ..write('grapeVarietiesJson: $grapeVarietiesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BottleRecordsTable extends BottleRecords
    with TableInfo<$BottleRecordsTable, BottleRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BottleRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES wine_records (id)'));
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<int> purchasePrice = GeneratedColumn<int>(
      'purchase_price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _shopNameMeta =
      const VerificationMeta('shopName');
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
      'shop_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _storageLocationMeta =
      const VerificationMeta('storageLocation');
  @override
  late final GeneratedColumn<String> storageLocation = GeneratedColumn<String>(
      'storage_location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isConsumedMeta =
      const VerificationMeta('isConsumed');
  @override
  late final GeneratedColumn<bool> isConsumed = GeneratedColumn<bool>(
      'is_consumed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_consumed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wineId,
        purchaseDate,
        purchasePrice,
        shopName,
        imagePath,
        storageLocation,
        isConsumed,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bottle_records';
  @override
  VerificationContext validateIntegrity(Insertable<BottleRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
          _purchaseDateMeta,
          purchaseDate.isAcceptableOrUnknown(
              data['purchase_date']!, _purchaseDateMeta));
    } else if (isInserting) {
      context.missing(_purchaseDateMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('storage_location')) {
      context.handle(
          _storageLocationMeta,
          storageLocation.isAcceptableOrUnknown(
              data['storage_location']!, _storageLocationMeta));
    }
    if (data.containsKey('is_consumed')) {
      context.handle(
          _isConsumedMeta,
          isConsumed.isAcceptableOrUnknown(
              data['is_consumed']!, _isConsumedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BottleRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BottleRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      purchaseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}purchase_date'])!,
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}purchase_price'])!,
      shopName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shop_name']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      storageLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}storage_location']),
      isConsumed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_consumed'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BottleRecordsTable createAlias(String alias) {
    return $BottleRecordsTable(attachedDatabase, alias);
  }
}

class BottleRecord extends DataClass implements Insertable<BottleRecord> {
  final String id;
  final String wineId;
  final DateTime purchaseDate;
  final int purchasePrice;
  final String? shopName;
  final String? imagePath;
  final String? storageLocation;
  final bool isConsumed;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BottleRecord(
      {required this.id,
      required this.wineId,
      required this.purchaseDate,
      required this.purchasePrice,
      this.shopName,
      this.imagePath,
      this.storageLocation,
      required this.isConsumed,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    map['purchase_date'] = Variable<DateTime>(purchaseDate);
    map['purchase_price'] = Variable<int>(purchasePrice);
    if (!nullToAbsent || shopName != null) {
      map['shop_name'] = Variable<String>(shopName);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || storageLocation != null) {
      map['storage_location'] = Variable<String>(storageLocation);
    }
    map['is_consumed'] = Variable<bool>(isConsumed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BottleRecordsCompanion toCompanion(bool nullToAbsent) {
    return BottleRecordsCompanion(
      id: Value(id),
      wineId: Value(wineId),
      purchaseDate: Value(purchaseDate),
      purchasePrice: Value(purchasePrice),
      shopName: shopName == null && nullToAbsent
          ? const Value.absent()
          : Value(shopName),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      storageLocation: storageLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(storageLocation),
      isConsumed: Value(isConsumed),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BottleRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BottleRecord(
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      purchaseDate: serializer.fromJson<DateTime>(json['purchaseDate']),
      purchasePrice: serializer.fromJson<int>(json['purchasePrice']),
      shopName: serializer.fromJson<String?>(json['shopName']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      storageLocation: serializer.fromJson<String?>(json['storageLocation']),
      isConsumed: serializer.fromJson<bool>(json['isConsumed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'purchaseDate': serializer.toJson<DateTime>(purchaseDate),
      'purchasePrice': serializer.toJson<int>(purchasePrice),
      'shopName': serializer.toJson<String?>(shopName),
      'imagePath': serializer.toJson<String?>(imagePath),
      'storageLocation': serializer.toJson<String?>(storageLocation),
      'isConsumed': serializer.toJson<bool>(isConsumed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BottleRecord copyWith(
          {String? id,
          String? wineId,
          DateTime? purchaseDate,
          int? purchasePrice,
          Value<String?> shopName = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> storageLocation = const Value.absent(),
          bool? isConsumed,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BottleRecord(
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        shopName: shopName.present ? shopName.value : this.shopName,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        storageLocation: storageLocation.present
            ? storageLocation.value
            : this.storageLocation,
        isConsumed: isConsumed ?? this.isConsumed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BottleRecord copyWithCompanion(BottleRecordsCompanion data) {
    return BottleRecord(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      storageLocation: data.storageLocation.present
          ? data.storageLocation.value
          : this.storageLocation,
      isConsumed:
          data.isConsumed.present ? data.isConsumed.value : this.isConsumed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BottleRecord(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('shopName: $shopName, ')
          ..write('imagePath: $imagePath, ')
          ..write('storageLocation: $storageLocation, ')
          ..write('isConsumed: $isConsumed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wineId, purchaseDate, purchasePrice,
      shopName, imagePath, storageLocation, isConsumed, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BottleRecord &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.purchaseDate == this.purchaseDate &&
          other.purchasePrice == this.purchasePrice &&
          other.shopName == this.shopName &&
          other.imagePath == this.imagePath &&
          other.storageLocation == this.storageLocation &&
          other.isConsumed == this.isConsumed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BottleRecordsCompanion extends UpdateCompanion<BottleRecord> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<DateTime> purchaseDate;
  final Value<int> purchasePrice;
  final Value<String?> shopName;
  final Value<String?> imagePath;
  final Value<String?> storageLocation;
  final Value<bool> isConsumed;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BottleRecordsCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.shopName = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.isConsumed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BottleRecordsCompanion.insert({
    required String id,
    required String wineId,
    required DateTime purchaseDate,
    required int purchasePrice,
    this.shopName = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.isConsumed = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        wineId = Value(wineId),
        purchaseDate = Value(purchaseDate),
        purchasePrice = Value(purchasePrice),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<BottleRecord> custom({
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<DateTime>? purchaseDate,
    Expression<int>? purchasePrice,
    Expression<String>? shopName,
    Expression<String>? imagePath,
    Expression<String>? storageLocation,
    Expression<bool>? isConsumed,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (shopName != null) 'shop_name': shopName,
      if (imagePath != null) 'image_path': imagePath,
      if (storageLocation != null) 'storage_location': storageLocation,
      if (isConsumed != null) 'is_consumed': isConsumed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BottleRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? wineId,
      Value<DateTime>? purchaseDate,
      Value<int>? purchasePrice,
      Value<String?>? shopName,
      Value<String?>? imagePath,
      Value<String?>? storageLocation,
      Value<bool>? isConsumed,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return BottleRecordsCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      shopName: shopName ?? this.shopName,
      imagePath: imagePath ?? this.imagePath,
      storageLocation: storageLocation ?? this.storageLocation,
      isConsumed: isConsumed ?? this.isConsumed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<int>(purchasePrice.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (storageLocation.present) {
      map['storage_location'] = Variable<String>(storageLocation.value);
    }
    if (isConsumed.present) {
      map['is_consumed'] = Variable<bool>(isConsumed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BottleRecordsCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('shopName: $shopName, ')
          ..write('imagePath: $imagePath, ')
          ..write('storageLocation: $storageLocation, ')
          ..write('isConsumed: $isConsumed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TastingNoteRecordsTable extends TastingNoteRecords
    with TableInfo<$TastingNoteRecordsTable, TastingNoteRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TastingNoteRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES wine_records (id)'));
  static const VerificationMeta _bottleIdMeta =
      const VerificationMeta('bottleId');
  @override
  late final GeneratedColumn<String> bottleId = GeneratedColumn<String>(
      'bottle_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES bottle_records (id)'));
  static const VerificationMeta _tastedAtMeta =
      const VerificationMeta('tastedAt');
  @override
  late final GeneratedColumn<DateTime> tastedAt = GeneratedColumn<DateTime>(
      'tasted_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _aromaMeta = const VerificationMeta('aroma');
  @override
  late final GeneratedColumn<String> aroma = GeneratedColumn<String>(
      'aroma', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _palateMeta = const VerificationMeta('palate');
  @override
  late final GeneratedColumn<String> palate = GeneratedColumn<String>(
      'palate', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pairingMeta =
      const VerificationMeta('pairing');
  @override
  late final GeneratedColumn<String> pairing = GeneratedColumn<String>(
      'pairing', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _acidityMeta =
      const VerificationMeta('acidity');
  @override
  late final GeneratedColumn<int> acidity = GeneratedColumn<int>(
      'acidity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tanninMeta = const VerificationMeta('tannin');
  @override
  late final GeneratedColumn<int> tannin = GeneratedColumn<int>(
      'tannin', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<int> body = GeneratedColumn<int>(
      'body', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sweetnessMeta =
      const VerificationMeta('sweetness');
  @override
  late final GeneratedColumn<int> sweetness = GeneratedColumn<int>(
      'sweetness', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wineId,
        bottleId,
        tastedAt,
        rating,
        imagePath,
        aroma,
        palate,
        pairing,
        acidity,
        tannin,
        body,
        sweetness,
        memo,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasting_note_records';
  @override
  VerificationContext validateIntegrity(Insertable<TastingNoteRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('bottle_id')) {
      context.handle(_bottleIdMeta,
          bottleId.isAcceptableOrUnknown(data['bottle_id']!, _bottleIdMeta));
    }
    if (data.containsKey('tasted_at')) {
      context.handle(_tastedAtMeta,
          tastedAt.isAcceptableOrUnknown(data['tasted_at']!, _tastedAtMeta));
    } else if (isInserting) {
      context.missing(_tastedAtMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('aroma')) {
      context.handle(
          _aromaMeta, aroma.isAcceptableOrUnknown(data['aroma']!, _aromaMeta));
    }
    if (data.containsKey('palate')) {
      context.handle(_palateMeta,
          palate.isAcceptableOrUnknown(data['palate']!, _palateMeta));
    }
    if (data.containsKey('pairing')) {
      context.handle(_pairingMeta,
          pairing.isAcceptableOrUnknown(data['pairing']!, _pairingMeta));
    }
    if (data.containsKey('acidity')) {
      context.handle(_acidityMeta,
          acidity.isAcceptableOrUnknown(data['acidity']!, _acidityMeta));
    }
    if (data.containsKey('tannin')) {
      context.handle(_tanninMeta,
          tannin.isAcceptableOrUnknown(data['tannin']!, _tanninMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    }
    if (data.containsKey('sweetness')) {
      context.handle(_sweetnessMeta,
          sweetness.isAcceptableOrUnknown(data['sweetness']!, _sweetnessMeta));
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TastingNoteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TastingNoteRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      bottleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bottle_id']),
      tastedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tasted_at'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      aroma: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aroma']),
      palate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}palate']),
      pairing: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pairing']),
      acidity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}acidity']),
      tannin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tannin']),
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}body']),
      sweetness: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sweetness']),
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $TastingNoteRecordsTable createAlias(String alias) {
    return $TastingNoteRecordsTable(attachedDatabase, alias);
  }
}

class TastingNoteRecord extends DataClass
    implements Insertable<TastingNoteRecord> {
  final String id;
  final String wineId;
  final String? bottleId;
  final DateTime tastedAt;
  final double rating;
  final String? imagePath;
  final String? aroma;
  final String? palate;
  final String? pairing;
  final int? acidity;
  final int? tannin;
  final int? body;
  final int? sweetness;
  final String? memo;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TastingNoteRecord(
      {required this.id,
      required this.wineId,
      this.bottleId,
      required this.tastedAt,
      required this.rating,
      this.imagePath,
      this.aroma,
      this.palate,
      this.pairing,
      this.acidity,
      this.tannin,
      this.body,
      this.sweetness,
      this.memo,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    if (!nullToAbsent || bottleId != null) {
      map['bottle_id'] = Variable<String>(bottleId);
    }
    map['tasted_at'] = Variable<DateTime>(tastedAt);
    map['rating'] = Variable<double>(rating);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || aroma != null) {
      map['aroma'] = Variable<String>(aroma);
    }
    if (!nullToAbsent || palate != null) {
      map['palate'] = Variable<String>(palate);
    }
    if (!nullToAbsent || pairing != null) {
      map['pairing'] = Variable<String>(pairing);
    }
    if (!nullToAbsent || acidity != null) {
      map['acidity'] = Variable<int>(acidity);
    }
    if (!nullToAbsent || tannin != null) {
      map['tannin'] = Variable<int>(tannin);
    }
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<int>(body);
    }
    if (!nullToAbsent || sweetness != null) {
      map['sweetness'] = Variable<int>(sweetness);
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TastingNoteRecordsCompanion toCompanion(bool nullToAbsent) {
    return TastingNoteRecordsCompanion(
      id: Value(id),
      wineId: Value(wineId),
      bottleId: bottleId == null && nullToAbsent
          ? const Value.absent()
          : Value(bottleId),
      tastedAt: Value(tastedAt),
      rating: Value(rating),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      aroma:
          aroma == null && nullToAbsent ? const Value.absent() : Value(aroma),
      palate:
          palate == null && nullToAbsent ? const Value.absent() : Value(palate),
      pairing: pairing == null && nullToAbsent
          ? const Value.absent()
          : Value(pairing),
      acidity: acidity == null && nullToAbsent
          ? const Value.absent()
          : Value(acidity),
      tannin:
          tannin == null && nullToAbsent ? const Value.absent() : Value(tannin),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      sweetness: sweetness == null && nullToAbsent
          ? const Value.absent()
          : Value(sweetness),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TastingNoteRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TastingNoteRecord(
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      bottleId: serializer.fromJson<String?>(json['bottleId']),
      tastedAt: serializer.fromJson<DateTime>(json['tastedAt']),
      rating: serializer.fromJson<double>(json['rating']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      aroma: serializer.fromJson<String?>(json['aroma']),
      palate: serializer.fromJson<String?>(json['palate']),
      pairing: serializer.fromJson<String?>(json['pairing']),
      acidity: serializer.fromJson<int?>(json['acidity']),
      tannin: serializer.fromJson<int?>(json['tannin']),
      body: serializer.fromJson<int?>(json['body']),
      sweetness: serializer.fromJson<int?>(json['sweetness']),
      memo: serializer.fromJson<String?>(json['memo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'bottleId': serializer.toJson<String?>(bottleId),
      'tastedAt': serializer.toJson<DateTime>(tastedAt),
      'rating': serializer.toJson<double>(rating),
      'imagePath': serializer.toJson<String?>(imagePath),
      'aroma': serializer.toJson<String?>(aroma),
      'palate': serializer.toJson<String?>(palate),
      'pairing': serializer.toJson<String?>(pairing),
      'acidity': serializer.toJson<int?>(acidity),
      'tannin': serializer.toJson<int?>(tannin),
      'body': serializer.toJson<int?>(body),
      'sweetness': serializer.toJson<int?>(sweetness),
      'memo': serializer.toJson<String?>(memo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TastingNoteRecord copyWith(
          {String? id,
          String? wineId,
          Value<String?> bottleId = const Value.absent(),
          DateTime? tastedAt,
          double? rating,
          Value<String?> imagePath = const Value.absent(),
          Value<String?> aroma = const Value.absent(),
          Value<String?> palate = const Value.absent(),
          Value<String?> pairing = const Value.absent(),
          Value<int?> acidity = const Value.absent(),
          Value<int?> tannin = const Value.absent(),
          Value<int?> body = const Value.absent(),
          Value<int?> sweetness = const Value.absent(),
          Value<String?> memo = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      TastingNoteRecord(
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        bottleId: bottleId.present ? bottleId.value : this.bottleId,
        tastedAt: tastedAt ?? this.tastedAt,
        rating: rating ?? this.rating,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        aroma: aroma.present ? aroma.value : this.aroma,
        palate: palate.present ? palate.value : this.palate,
        pairing: pairing.present ? pairing.value : this.pairing,
        acidity: acidity.present ? acidity.value : this.acidity,
        tannin: tannin.present ? tannin.value : this.tannin,
        body: body.present ? body.value : this.body,
        sweetness: sweetness.present ? sweetness.value : this.sweetness,
        memo: memo.present ? memo.value : this.memo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  TastingNoteRecord copyWithCompanion(TastingNoteRecordsCompanion data) {
    return TastingNoteRecord(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      bottleId: data.bottleId.present ? data.bottleId.value : this.bottleId,
      tastedAt: data.tastedAt.present ? data.tastedAt.value : this.tastedAt,
      rating: data.rating.present ? data.rating.value : this.rating,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      aroma: data.aroma.present ? data.aroma.value : this.aroma,
      palate: data.palate.present ? data.palate.value : this.palate,
      pairing: data.pairing.present ? data.pairing.value : this.pairing,
      acidity: data.acidity.present ? data.acidity.value : this.acidity,
      tannin: data.tannin.present ? data.tannin.value : this.tannin,
      body: data.body.present ? data.body.value : this.body,
      sweetness: data.sweetness.present ? data.sweetness.value : this.sweetness,
      memo: data.memo.present ? data.memo.value : this.memo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TastingNoteRecord(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('bottleId: $bottleId, ')
          ..write('tastedAt: $tastedAt, ')
          ..write('rating: $rating, ')
          ..write('imagePath: $imagePath, ')
          ..write('aroma: $aroma, ')
          ..write('palate: $palate, ')
          ..write('pairing: $pairing, ')
          ..write('acidity: $acidity, ')
          ..write('tannin: $tannin, ')
          ..write('body: $body, ')
          ..write('sweetness: $sweetness, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      wineId,
      bottleId,
      tastedAt,
      rating,
      imagePath,
      aroma,
      palate,
      pairing,
      acidity,
      tannin,
      body,
      sweetness,
      memo,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TastingNoteRecord &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.bottleId == this.bottleId &&
          other.tastedAt == this.tastedAt &&
          other.rating == this.rating &&
          other.imagePath == this.imagePath &&
          other.aroma == this.aroma &&
          other.palate == this.palate &&
          other.pairing == this.pairing &&
          other.acidity == this.acidity &&
          other.tannin == this.tannin &&
          other.body == this.body &&
          other.sweetness == this.sweetness &&
          other.memo == this.memo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TastingNoteRecordsCompanion extends UpdateCompanion<TastingNoteRecord> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<String?> bottleId;
  final Value<DateTime> tastedAt;
  final Value<double> rating;
  final Value<String?> imagePath;
  final Value<String?> aroma;
  final Value<String?> palate;
  final Value<String?> pairing;
  final Value<int?> acidity;
  final Value<int?> tannin;
  final Value<int?> body;
  final Value<int?> sweetness;
  final Value<String?> memo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TastingNoteRecordsCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.bottleId = const Value.absent(),
    this.tastedAt = const Value.absent(),
    this.rating = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.aroma = const Value.absent(),
    this.palate = const Value.absent(),
    this.pairing = const Value.absent(),
    this.acidity = const Value.absent(),
    this.tannin = const Value.absent(),
    this.body = const Value.absent(),
    this.sweetness = const Value.absent(),
    this.memo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TastingNoteRecordsCompanion.insert({
    required String id,
    required String wineId,
    this.bottleId = const Value.absent(),
    required DateTime tastedAt,
    required double rating,
    this.imagePath = const Value.absent(),
    this.aroma = const Value.absent(),
    this.palate = const Value.absent(),
    this.pairing = const Value.absent(),
    this.acidity = const Value.absent(),
    this.tannin = const Value.absent(),
    this.body = const Value.absent(),
    this.sweetness = const Value.absent(),
    this.memo = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        wineId = Value(wineId),
        tastedAt = Value(tastedAt),
        rating = Value(rating),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TastingNoteRecord> custom({
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<String>? bottleId,
    Expression<DateTime>? tastedAt,
    Expression<double>? rating,
    Expression<String>? imagePath,
    Expression<String>? aroma,
    Expression<String>? palate,
    Expression<String>? pairing,
    Expression<int>? acidity,
    Expression<int>? tannin,
    Expression<int>? body,
    Expression<int>? sweetness,
    Expression<String>? memo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (bottleId != null) 'bottle_id': bottleId,
      if (tastedAt != null) 'tasted_at': tastedAt,
      if (rating != null) 'rating': rating,
      if (imagePath != null) 'image_path': imagePath,
      if (aroma != null) 'aroma': aroma,
      if (palate != null) 'palate': palate,
      if (pairing != null) 'pairing': pairing,
      if (acidity != null) 'acidity': acidity,
      if (tannin != null) 'tannin': tannin,
      if (body != null) 'body': body,
      if (sweetness != null) 'sweetness': sweetness,
      if (memo != null) 'memo': memo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TastingNoteRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? wineId,
      Value<String?>? bottleId,
      Value<DateTime>? tastedAt,
      Value<double>? rating,
      Value<String?>? imagePath,
      Value<String?>? aroma,
      Value<String?>? palate,
      Value<String?>? pairing,
      Value<int?>? acidity,
      Value<int?>? tannin,
      Value<int?>? body,
      Value<int?>? sweetness,
      Value<String?>? memo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return TastingNoteRecordsCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      bottleId: bottleId ?? this.bottleId,
      tastedAt: tastedAt ?? this.tastedAt,
      rating: rating ?? this.rating,
      imagePath: imagePath ?? this.imagePath,
      aroma: aroma ?? this.aroma,
      palate: palate ?? this.palate,
      pairing: pairing ?? this.pairing,
      acidity: acidity ?? this.acidity,
      tannin: tannin ?? this.tannin,
      body: body ?? this.body,
      sweetness: sweetness ?? this.sweetness,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (bottleId.present) {
      map['bottle_id'] = Variable<String>(bottleId.value);
    }
    if (tastedAt.present) {
      map['tasted_at'] = Variable<DateTime>(tastedAt.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (aroma.present) {
      map['aroma'] = Variable<String>(aroma.value);
    }
    if (palate.present) {
      map['palate'] = Variable<String>(palate.value);
    }
    if (pairing.present) {
      map['pairing'] = Variable<String>(pairing.value);
    }
    if (acidity.present) {
      map['acidity'] = Variable<int>(acidity.value);
    }
    if (tannin.present) {
      map['tannin'] = Variable<int>(tannin.value);
    }
    if (body.present) {
      map['body'] = Variable<int>(body.value);
    }
    if (sweetness.present) {
      map['sweetness'] = Variable<int>(sweetness.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TastingNoteRecordsCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('bottleId: $bottleId, ')
          ..write('tastedAt: $tastedAt, ')
          ..write('rating: $rating, ')
          ..write('imagePath: $imagePath, ')
          ..write('aroma: $aroma, ')
          ..write('palate: $palate, ')
          ..write('pairing: $pairing, ')
          ..write('acidity: $acidity, ')
          ..write('tannin: $tannin, ')
          ..write('body: $body, ')
          ..write('sweetness: $sweetness, ')
          ..write('memo: $memo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceObservationRecordsTable extends PriceObservationRecords
    with TableInfo<$PriceObservationRecordsTable, PriceObservationRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceObservationRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _wineIdMeta = const VerificationMeta('wineId');
  @override
  late final GeneratedColumn<String> wineId = GeneratedColumn<String>(
      'wine_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES wine_records (id)'));
  static const VerificationMeta _sourceNameMeta =
      const VerificationMeta('sourceName');
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
      'source_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _observedAtMeta =
      const VerificationMeta('observedAt');
  @override
  late final GeneratedColumn<DateTime> observedAt = GeneratedColumn<DateTime>(
      'observed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isInStockMeta =
      const VerificationMeta('isInStock');
  @override
  late final GeneratedColumn<bool> isInStock = GeneratedColumn<bool>(
      'is_in_stock', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_in_stock" IN (0, 1))'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        wineId,
        sourceName,
        price,
        observedAt,
        url,
        note,
        isInStock,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_observation_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<PriceObservationRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wine_id')) {
      context.handle(_wineIdMeta,
          wineId.isAcceptableOrUnknown(data['wine_id']!, _wineIdMeta));
    } else if (isInserting) {
      context.missing(_wineIdMeta);
    }
    if (data.containsKey('source_name')) {
      context.handle(
          _sourceNameMeta,
          sourceName.isAcceptableOrUnknown(
              data['source_name']!, _sourceNameMeta));
    } else if (isInserting) {
      context.missing(_sourceNameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('observed_at')) {
      context.handle(
          _observedAtMeta,
          observedAt.isAcceptableOrUnknown(
              data['observed_at']!, _observedAtMeta));
    } else if (isInserting) {
      context.missing(_observedAtMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_in_stock')) {
      context.handle(
          _isInStockMeta,
          isInStock.isAcceptableOrUnknown(
              data['is_in_stock']!, _isInStockMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceObservationRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceObservationRecord(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      sourceName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source_name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      observedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}observed_at'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isInStock: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_in_stock']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PriceObservationRecordsTable createAlias(String alias) {
    return $PriceObservationRecordsTable(attachedDatabase, alias);
  }
}

class PriceObservationRecord extends DataClass
    implements Insertable<PriceObservationRecord> {
  final String id;
  final String wineId;
  final String sourceName;
  final int price;
  final DateTime observedAt;
  final String? url;
  final String? note;
  final bool? isInStock;
  final DateTime createdAt;
  const PriceObservationRecord(
      {required this.id,
      required this.wineId,
      required this.sourceName,
      required this.price,
      required this.observedAt,
      this.url,
      this.note,
      this.isInStock,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    map['source_name'] = Variable<String>(sourceName);
    map['price'] = Variable<int>(price);
    map['observed_at'] = Variable<DateTime>(observedAt);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || isInStock != null) {
      map['is_in_stock'] = Variable<bool>(isInStock);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PriceObservationRecordsCompanion toCompanion(bool nullToAbsent) {
    return PriceObservationRecordsCompanion(
      id: Value(id),
      wineId: Value(wineId),
      sourceName: Value(sourceName),
      price: Value(price),
      observedAt: Value(observedAt),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isInStock: isInStock == null && nullToAbsent
          ? const Value.absent()
          : Value(isInStock),
      createdAt: Value(createdAt),
    );
  }

  factory PriceObservationRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceObservationRecord(
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      price: serializer.fromJson<int>(json['price']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      url: serializer.fromJson<String?>(json['url']),
      note: serializer.fromJson<String?>(json['note']),
      isInStock: serializer.fromJson<bool?>(json['isInStock']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'sourceName': serializer.toJson<String>(sourceName),
      'price': serializer.toJson<int>(price),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'url': serializer.toJson<String?>(url),
      'note': serializer.toJson<String?>(note),
      'isInStock': serializer.toJson<bool?>(isInStock),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PriceObservationRecord copyWith(
          {String? id,
          String? wineId,
          String? sourceName,
          int? price,
          DateTime? observedAt,
          Value<String?> url = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<bool?> isInStock = const Value.absent(),
          DateTime? createdAt}) =>
      PriceObservationRecord(
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        sourceName: sourceName ?? this.sourceName,
        price: price ?? this.price,
        observedAt: observedAt ?? this.observedAt,
        url: url.present ? url.value : this.url,
        note: note.present ? note.value : this.note,
        isInStock: isInStock.present ? isInStock.value : this.isInStock,
        createdAt: createdAt ?? this.createdAt,
      );
  PriceObservationRecord copyWithCompanion(
      PriceObservationRecordsCompanion data) {
    return PriceObservationRecord(
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      sourceName:
          data.sourceName.present ? data.sourceName.value : this.sourceName,
      price: data.price.present ? data.price.value : this.price,
      observedAt:
          data.observedAt.present ? data.observedAt.value : this.observedAt,
      url: data.url.present ? data.url.value : this.url,
      note: data.note.present ? data.note.value : this.note,
      isInStock: data.isInStock.present ? data.isInStock.value : this.isInStock,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservationRecord(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('sourceName: $sourceName, ')
          ..write('price: $price, ')
          ..write('observedAt: $observedAt, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('isInStock: $isInStock, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wineId, sourceName, price, observedAt,
      url, note, isInStock, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceObservationRecord &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.sourceName == this.sourceName &&
          other.price == this.price &&
          other.observedAt == this.observedAt &&
          other.url == this.url &&
          other.note == this.note &&
          other.isInStock == this.isInStock &&
          other.createdAt == this.createdAt);
}

class PriceObservationRecordsCompanion
    extends UpdateCompanion<PriceObservationRecord> {
  final Value<String> id;
  final Value<String> wineId;
  final Value<String> sourceName;
  final Value<int> price;
  final Value<DateTime> observedAt;
  final Value<String?> url;
  final Value<String?> note;
  final Value<bool?> isInStock;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PriceObservationRecordsCompanion({
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.price = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.isInStock = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceObservationRecordsCompanion.insert({
    required String id,
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.isInStock = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        wineId = Value(wineId),
        sourceName = Value(sourceName),
        price = Value(price),
        observedAt = Value(observedAt),
        createdAt = Value(createdAt);
  static Insertable<PriceObservationRecord> custom({
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<String>? sourceName,
    Expression<int>? price,
    Expression<DateTime>? observedAt,
    Expression<String>? url,
    Expression<String>? note,
    Expression<bool>? isInStock,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (sourceName != null) 'source_name': sourceName,
      if (price != null) 'price': price,
      if (observedAt != null) 'observed_at': observedAt,
      if (url != null) 'url': url,
      if (note != null) 'note': note,
      if (isInStock != null) 'is_in_stock': isInStock,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceObservationRecordsCompanion copyWith(
      {Value<String>? id,
      Value<String>? wineId,
      Value<String>? sourceName,
      Value<int>? price,
      Value<DateTime>? observedAt,
      Value<String?>? url,
      Value<String?>? note,
      Value<bool?>? isInStock,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PriceObservationRecordsCompanion(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      sourceName: sourceName ?? this.sourceName,
      price: price ?? this.price,
      observedAt: observedAt ?? this.observedAt,
      url: url ?? this.url,
      note: note ?? this.note,
      isInStock: isInStock ?? this.isInStock,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (observedAt.present) {
      map['observed_at'] = Variable<DateTime>(observedAt.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isInStock.present) {
      map['is_in_stock'] = Variable<bool>(isInStock.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservationRecordsCompanion(')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('sourceName: $sourceName, ')
          ..write('price: $price, ')
          ..write('observedAt: $observedAt, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('isInStock: $isInStock, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WineRecordsTable wineRecords = $WineRecordsTable(this);
  late final $BottleRecordsTable bottleRecords = $BottleRecordsTable(this);
  late final $TastingNoteRecordsTable tastingNoteRecords =
      $TastingNoteRecordsTable(this);
  late final $PriceObservationRecordsTable priceObservationRecords =
      $PriceObservationRecordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [wineRecords, bottleRecords, tastingNoteRecords, priceObservationRecords];
}

typedef $$WineRecordsTableCreateCompanionBuilder = WineRecordsCompanion
    Function({
  required String id,
  required String name,
  required String producer,
  required String country,
  Value<String?> region,
  Value<int?> vintage,
  required String type,
  Value<String> grapeVarietiesJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$WineRecordsTableUpdateCompanionBuilder = WineRecordsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> producer,
  Value<String> country,
  Value<String?> region,
  Value<int?> vintage,
  Value<String> type,
  Value<String> grapeVarietiesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$WineRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $WineRecordsTable, WineRecord> {
  $$WineRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BottleRecordsTable, List<BottleRecord>>
      _bottleRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.bottleRecords,
              aliasName: $_aliasNameGenerator(
                  db.wineRecords.id, db.bottleRecords.wineId));

  $$BottleRecordsTableProcessedTableManager get bottleRecordsRefs {
    final manager = $$BottleRecordsTableTableManager($_db, $_db.bottleRecords)
        .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bottleRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TastingNoteRecordsTable, List<TastingNoteRecord>>
      _tastingNoteRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.tastingNoteRecords,
              aliasName: $_aliasNameGenerator(
                  db.wineRecords.id, db.tastingNoteRecords.wineId));

  $$TastingNoteRecordsTableProcessedTableManager get tastingNoteRecordsRefs {
    final manager =
        $$TastingNoteRecordsTableTableManager($_db, $_db.tastingNoteRecords)
            .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_tastingNoteRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PriceObservationRecordsTable,
      List<PriceObservationRecord>> _priceObservationRecordsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.priceObservationRecords,
          aliasName: $_aliasNameGenerator(
              db.wineRecords.id, db.priceObservationRecords.wineId));

  $$PriceObservationRecordsTableProcessedTableManager
      get priceObservationRecordsRefs {
    final manager = $$PriceObservationRecordsTableTableManager(
            $_db, $_db.priceObservationRecords)
        .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_priceObservationRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WineRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $WineRecordsTable> {
  $$WineRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> bottleRecordsRefs(
      Expression<bool> Function($$BottleRecordsTableFilterComposer f) f) {
    final $$BottleRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BottleRecordsTableFilterComposer(
              $db: $db,
              $table: $db.bottleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> tastingNoteRecordsRefs(
      Expression<bool> Function($$TastingNoteRecordsTableFilterComposer f) f) {
    final $$TastingNoteRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tastingNoteRecords,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TastingNoteRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tastingNoteRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> priceObservationRecordsRefs(
      Expression<bool> Function($$PriceObservationRecordsTableFilterComposer f)
          f) {
    final $$PriceObservationRecordsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.priceObservationRecords,
            getReferencedColumn: (t) => t.wineId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PriceObservationRecordsTableFilterComposer(
                  $db: $db,
                  $table: $db.priceObservationRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$WineRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WineRecordsTable> {
  $$WineRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get producer => $composableBuilder(
      column: $table.producer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vintage => $composableBuilder(
      column: $table.vintage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WineRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WineRecordsTable> {
  $$WineRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<int> get vintage =>
      $composableBuilder(column: $table.vintage, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> bottleRecordsRefs<T extends Object>(
      Expression<T> Function($$BottleRecordsTableAnnotationComposer a) f) {
    final $$BottleRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BottleRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.bottleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> tastingNoteRecordsRefs<T extends Object>(
      Expression<T> Function($$TastingNoteRecordsTableAnnotationComposer a) f) {
    final $$TastingNoteRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tastingNoteRecords,
            getReferencedColumn: (t) => t.wineId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TastingNoteRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tastingNoteRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> priceObservationRecordsRefs<T extends Object>(
      Expression<T> Function($$PriceObservationRecordsTableAnnotationComposer a)
          f) {
    final $$PriceObservationRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.priceObservationRecords,
            getReferencedColumn: (t) => t.wineId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PriceObservationRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.priceObservationRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$WineRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WineRecordsTable,
    WineRecord,
    $$WineRecordsTableFilterComposer,
    $$WineRecordsTableOrderingComposer,
    $$WineRecordsTableAnnotationComposer,
    $$WineRecordsTableCreateCompanionBuilder,
    $$WineRecordsTableUpdateCompanionBuilder,
    (WineRecord, $$WineRecordsTableReferences),
    WineRecord,
    PrefetchHooks Function(
        {bool bottleRecordsRefs,
        bool tastingNoteRecordsRefs,
        bool priceObservationRecordsRefs})> {
  $$WineRecordsTableTableManager(_$AppDatabase db, $WineRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WineRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WineRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WineRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> producer = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> grapeVarietiesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WineRecordsCompanion(
            id: id,
            name: name,
            producer: producer,
            country: country,
            region: region,
            vintage: vintage,
            type: type,
            grapeVarietiesJson: grapeVarietiesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String producer,
            required String country,
            Value<String?> region = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            required String type,
            Value<String> grapeVarietiesJson = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WineRecordsCompanion.insert(
            id: id,
            name: name,
            producer: producer,
            country: country,
            region: region,
            vintage: vintage,
            type: type,
            grapeVarietiesJson: grapeVarietiesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WineRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {bottleRecordsRefs = false,
              tastingNoteRecordsRefs = false,
              priceObservationRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bottleRecordsRefs) db.bottleRecords,
                if (tastingNoteRecordsRefs) db.tastingNoteRecords,
                if (priceObservationRecordsRefs) db.priceObservationRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bottleRecordsRefs)
                    await $_getPrefetchedData<WineRecord, $WineRecordsTable,
                            BottleRecord>(
                        currentTable: table,
                        referencedTable: $$WineRecordsTableReferences
                            ._bottleRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WineRecordsTableReferences(db, table, p0)
                                .bottleRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items),
                  if (tastingNoteRecordsRefs)
                    await $_getPrefetchedData<WineRecord, $WineRecordsTable,
                            TastingNoteRecord>(
                        currentTable: table,
                        referencedTable: $$WineRecordsTableReferences
                            ._tastingNoteRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WineRecordsTableReferences(db, table, p0)
                                .tastingNoteRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items),
                  if (priceObservationRecordsRefs)
                    await $_getPrefetchedData<WineRecord, $WineRecordsTable,
                            PriceObservationRecord>(
                        currentTable: table,
                        referencedTable: $$WineRecordsTableReferences
                            ._priceObservationRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WineRecordsTableReferences(db, table, p0)
                                .priceObservationRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WineRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WineRecordsTable,
    WineRecord,
    $$WineRecordsTableFilterComposer,
    $$WineRecordsTableOrderingComposer,
    $$WineRecordsTableAnnotationComposer,
    $$WineRecordsTableCreateCompanionBuilder,
    $$WineRecordsTableUpdateCompanionBuilder,
    (WineRecord, $$WineRecordsTableReferences),
    WineRecord,
    PrefetchHooks Function(
        {bool bottleRecordsRefs,
        bool tastingNoteRecordsRefs,
        bool priceObservationRecordsRefs})>;
typedef $$BottleRecordsTableCreateCompanionBuilder = BottleRecordsCompanion
    Function({
  required String id,
  required String wineId,
  required DateTime purchaseDate,
  required int purchasePrice,
  Value<String?> shopName,
  Value<String?> imagePath,
  Value<String?> storageLocation,
  Value<bool> isConsumed,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BottleRecordsTableUpdateCompanionBuilder = BottleRecordsCompanion
    Function({
  Value<String> id,
  Value<String> wineId,
  Value<DateTime> purchaseDate,
  Value<int> purchasePrice,
  Value<String?> shopName,
  Value<String?> imagePath,
  Value<String?> storageLocation,
  Value<bool> isConsumed,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BottleRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $BottleRecordsTable, BottleRecord> {
  $$BottleRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WineRecordsTable _wineIdTable(_$AppDatabase db) =>
      db.wineRecords.createAlias(
          $_aliasNameGenerator(db.bottleRecords.wineId, db.wineRecords.id));

  $$WineRecordsTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WineRecordsTableTableManager($_db, $_db.wineRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TastingNoteRecordsTable, List<TastingNoteRecord>>
      _tastingNoteRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.tastingNoteRecords,
              aliasName: $_aliasNameGenerator(
                  db.bottleRecords.id, db.tastingNoteRecords.bottleId));

  $$TastingNoteRecordsTableProcessedTableManager get tastingNoteRecordsRefs {
    final manager = $$TastingNoteRecordsTableTableManager(
            $_db, $_db.tastingNoteRecords)
        .filter((f) => f.bottleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_tastingNoteRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BottleRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $BottleRecordsTable> {
  $$BottleRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WineRecordsTableFilterComposer get wineId {
    final $$WineRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableFilterComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> tastingNoteRecordsRefs(
      Expression<bool> Function($$TastingNoteRecordsTableFilterComposer f) f) {
    final $$TastingNoteRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tastingNoteRecords,
        getReferencedColumn: (t) => t.bottleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TastingNoteRecordsTableFilterComposer(
              $db: $db,
              $table: $db.tastingNoteRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BottleRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $BottleRecordsTable> {
  $$BottleRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WineRecordsTableOrderingComposer get wineId {
    final $$WineRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BottleRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BottleRecordsTable> {
  $$BottleRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<int> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation, builder: (column) => column);

  GeneratedColumn<bool> get isConsumed => $composableBuilder(
      column: $table.isConsumed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WineRecordsTableAnnotationComposer get wineId {
    final $$WineRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> tastingNoteRecordsRefs<T extends Object>(
      Expression<T> Function($$TastingNoteRecordsTableAnnotationComposer a) f) {
    final $$TastingNoteRecordsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.tastingNoteRecords,
            getReferencedColumn: (t) => t.bottleId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TastingNoteRecordsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.tastingNoteRecords,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$BottleRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BottleRecordsTable,
    BottleRecord,
    $$BottleRecordsTableFilterComposer,
    $$BottleRecordsTableOrderingComposer,
    $$BottleRecordsTableAnnotationComposer,
    $$BottleRecordsTableCreateCompanionBuilder,
    $$BottleRecordsTableUpdateCompanionBuilder,
    (BottleRecord, $$BottleRecordsTableReferences),
    BottleRecord,
    PrefetchHooks Function({bool wineId, bool tastingNoteRecordsRefs})> {
  $$BottleRecordsTableTableManager(_$AppDatabase db, $BottleRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BottleRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BottleRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BottleRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<DateTime> purchaseDate = const Value.absent(),
            Value<int> purchasePrice = const Value.absent(),
            Value<String?> shopName = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<bool> isConsumed = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BottleRecordsCompanion(
            id: id,
            wineId: wineId,
            purchaseDate: purchaseDate,
            purchasePrice: purchasePrice,
            shopName: shopName,
            imagePath: imagePath,
            storageLocation: storageLocation,
            isConsumed: isConsumed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String wineId,
            required DateTime purchaseDate,
            required int purchasePrice,
            Value<String?> shopName = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<bool> isConsumed = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              BottleRecordsCompanion.insert(
            id: id,
            wineId: wineId,
            purchaseDate: purchaseDate,
            purchasePrice: purchasePrice,
            shopName: shopName,
            imagePath: imagePath,
            storageLocation: storageLocation,
            isConsumed: isConsumed,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BottleRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {wineId = false, tastingNoteRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tastingNoteRecordsRefs) db.tastingNoteRecords
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable:
                        $$BottleRecordsTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$BottleRecordsTableReferences._wineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tastingNoteRecordsRefs)
                    await $_getPrefetchedData<BottleRecord, $BottleRecordsTable,
                            TastingNoteRecord>(
                        currentTable: table,
                        referencedTable: $$BottleRecordsTableReferences
                            ._tastingNoteRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BottleRecordsTableReferences(db, table, p0)
                                .tastingNoteRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.bottleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BottleRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BottleRecordsTable,
    BottleRecord,
    $$BottleRecordsTableFilterComposer,
    $$BottleRecordsTableOrderingComposer,
    $$BottleRecordsTableAnnotationComposer,
    $$BottleRecordsTableCreateCompanionBuilder,
    $$BottleRecordsTableUpdateCompanionBuilder,
    (BottleRecord, $$BottleRecordsTableReferences),
    BottleRecord,
    PrefetchHooks Function({bool wineId, bool tastingNoteRecordsRefs})>;
typedef $$TastingNoteRecordsTableCreateCompanionBuilder
    = TastingNoteRecordsCompanion Function({
  required String id,
  required String wineId,
  Value<String?> bottleId,
  required DateTime tastedAt,
  required double rating,
  Value<String?> imagePath,
  Value<String?> aroma,
  Value<String?> palate,
  Value<String?> pairing,
  Value<int?> acidity,
  Value<int?> tannin,
  Value<int?> body,
  Value<int?> sweetness,
  Value<String?> memo,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$TastingNoteRecordsTableUpdateCompanionBuilder
    = TastingNoteRecordsCompanion Function({
  Value<String> id,
  Value<String> wineId,
  Value<String?> bottleId,
  Value<DateTime> tastedAt,
  Value<double> rating,
  Value<String?> imagePath,
  Value<String?> aroma,
  Value<String?> palate,
  Value<String?> pairing,
  Value<int?> acidity,
  Value<int?> tannin,
  Value<int?> body,
  Value<int?> sweetness,
  Value<String?> memo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$TastingNoteRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $TastingNoteRecordsTable, TastingNoteRecord> {
  $$TastingNoteRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WineRecordsTable _wineIdTable(_$AppDatabase db) =>
      db.wineRecords.createAlias($_aliasNameGenerator(
          db.tastingNoteRecords.wineId, db.wineRecords.id));

  $$WineRecordsTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WineRecordsTableTableManager($_db, $_db.wineRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BottleRecordsTable _bottleIdTable(_$AppDatabase db) =>
      db.bottleRecords.createAlias($_aliasNameGenerator(
          db.tastingNoteRecords.bottleId, db.bottleRecords.id));

  $$BottleRecordsTableProcessedTableManager? get bottleId {
    final $_column = $_itemColumn<String>('bottle_id');
    if ($_column == null) return null;
    final manager = $$BottleRecordsTableTableManager($_db, $_db.bottleRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bottleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TastingNoteRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $TastingNoteRecordsTable> {
  $$TastingNoteRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tastedAt => $composableBuilder(
      column: $table.tastedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aroma => $composableBuilder(
      column: $table.aroma, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get palate => $composableBuilder(
      column: $table.palate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pairing => $composableBuilder(
      column: $table.pairing, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get acidity => $composableBuilder(
      column: $table.acidity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tannin => $composableBuilder(
      column: $table.tannin, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sweetness => $composableBuilder(
      column: $table.sweetness, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$WineRecordsTableFilterComposer get wineId {
    final $$WineRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableFilterComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BottleRecordsTableFilterComposer get bottleId {
    final $$BottleRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bottleId,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BottleRecordsTableFilterComposer(
              $db: $db,
              $table: $db.bottleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNoteRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $TastingNoteRecordsTable> {
  $$TastingNoteRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tastedAt => $composableBuilder(
      column: $table.tastedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aroma => $composableBuilder(
      column: $table.aroma, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get palate => $composableBuilder(
      column: $table.palate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pairing => $composableBuilder(
      column: $table.pairing, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get acidity => $composableBuilder(
      column: $table.acidity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tannin => $composableBuilder(
      column: $table.tannin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sweetness => $composableBuilder(
      column: $table.sweetness, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$WineRecordsTableOrderingComposer get wineId {
    final $$WineRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BottleRecordsTableOrderingComposer get bottleId {
    final $$BottleRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bottleId,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BottleRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.bottleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNoteRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TastingNoteRecordsTable> {
  $$TastingNoteRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get tastedAt =>
      $composableBuilder(column: $table.tastedAt, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get aroma =>
      $composableBuilder(column: $table.aroma, builder: (column) => column);

  GeneratedColumn<String> get palate =>
      $composableBuilder(column: $table.palate, builder: (column) => column);

  GeneratedColumn<String> get pairing =>
      $composableBuilder(column: $table.pairing, builder: (column) => column);

  GeneratedColumn<int> get acidity =>
      $composableBuilder(column: $table.acidity, builder: (column) => column);

  GeneratedColumn<int> get tannin =>
      $composableBuilder(column: $table.tannin, builder: (column) => column);

  GeneratedColumn<int> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get sweetness =>
      $composableBuilder(column: $table.sweetness, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$WineRecordsTableAnnotationComposer get wineId {
    final $$WineRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$BottleRecordsTableAnnotationComposer get bottleId {
    final $$BottleRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.bottleId,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BottleRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.bottleRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TastingNoteRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TastingNoteRecordsTable,
    TastingNoteRecord,
    $$TastingNoteRecordsTableFilterComposer,
    $$TastingNoteRecordsTableOrderingComposer,
    $$TastingNoteRecordsTableAnnotationComposer,
    $$TastingNoteRecordsTableCreateCompanionBuilder,
    $$TastingNoteRecordsTableUpdateCompanionBuilder,
    (TastingNoteRecord, $$TastingNoteRecordsTableReferences),
    TastingNoteRecord,
    PrefetchHooks Function({bool wineId, bool bottleId})> {
  $$TastingNoteRecordsTableTableManager(
      _$AppDatabase db, $TastingNoteRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TastingNoteRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TastingNoteRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TastingNoteRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String?> bottleId = const Value.absent(),
            Value<DateTime> tastedAt = const Value.absent(),
            Value<double> rating = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> aroma = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> pairing = const Value.absent(),
            Value<int?> acidity = const Value.absent(),
            Value<int?> tannin = const Value.absent(),
            Value<int?> body = const Value.absent(),
            Value<int?> sweetness = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNoteRecordsCompanion(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String wineId,
            Value<String?> bottleId = const Value.absent(),
            required DateTime tastedAt,
            required double rating,
            Value<String?> imagePath = const Value.absent(),
            Value<String?> aroma = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> pairing = const Value.absent(),
            Value<int?> acidity = const Value.absent(),
            Value<int?> tannin = const Value.absent(),
            Value<int?> body = const Value.absent(),
            Value<int?> sweetness = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNoteRecordsCompanion.insert(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TastingNoteRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wineId = false, bottleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable:
                        $$TastingNoteRecordsTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$TastingNoteRecordsTableReferences._wineIdTable(db).id,
                  ) as T;
                }
                if (bottleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.bottleId,
                    referencedTable:
                        $$TastingNoteRecordsTableReferences._bottleIdTable(db),
                    referencedColumn: $$TastingNoteRecordsTableReferences
                        ._bottleIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TastingNoteRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TastingNoteRecordsTable,
    TastingNoteRecord,
    $$TastingNoteRecordsTableFilterComposer,
    $$TastingNoteRecordsTableOrderingComposer,
    $$TastingNoteRecordsTableAnnotationComposer,
    $$TastingNoteRecordsTableCreateCompanionBuilder,
    $$TastingNoteRecordsTableUpdateCompanionBuilder,
    (TastingNoteRecord, $$TastingNoteRecordsTableReferences),
    TastingNoteRecord,
    PrefetchHooks Function({bool wineId, bool bottleId})>;
typedef $$PriceObservationRecordsTableCreateCompanionBuilder
    = PriceObservationRecordsCompanion Function({
  required String id,
  required String wineId,
  required String sourceName,
  required int price,
  required DateTime observedAt,
  Value<String?> url,
  Value<String?> note,
  Value<bool?> isInStock,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PriceObservationRecordsTableUpdateCompanionBuilder
    = PriceObservationRecordsCompanion Function({
  Value<String> id,
  Value<String> wineId,
  Value<String> sourceName,
  Value<int> price,
  Value<DateTime> observedAt,
  Value<String?> url,
  Value<String?> note,
  Value<bool?> isInStock,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PriceObservationRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $PriceObservationRecordsTable, PriceObservationRecord> {
  $$PriceObservationRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WineRecordsTable _wineIdTable(_$AppDatabase db) =>
      db.wineRecords.createAlias($_aliasNameGenerator(
          db.priceObservationRecords.wineId, db.wineRecords.id));

  $$WineRecordsTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WineRecordsTableTableManager($_db, $_db.wineRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PriceObservationRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PriceObservationRecordsTable> {
  $$PriceObservationRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sourceName => $composableBuilder(
      column: $table.sourceName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get observedAt => $composableBuilder(
      column: $table.observedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isInStock => $composableBuilder(
      column: $table.isInStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$WineRecordsTableFilterComposer get wineId {
    final $$WineRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableFilterComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PriceObservationRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceObservationRecordsTable> {
  $$PriceObservationRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sourceName => $composableBuilder(
      column: $table.sourceName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get observedAt => $composableBuilder(
      column: $table.observedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isInStock => $composableBuilder(
      column: $table.isInStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$WineRecordsTableOrderingComposer get wineId {
    final $$WineRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PriceObservationRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceObservationRecordsTable> {
  $$PriceObservationRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
      column: $table.sourceName, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get observedAt => $composableBuilder(
      column: $table.observedAt, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isInStock =>
      $composableBuilder(column: $table.isInStock, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WineRecordsTableAnnotationComposer get wineId {
    final $$WineRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wineId,
        referencedTable: $db.wineRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WineRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.wineRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PriceObservationRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PriceObservationRecordsTable,
    PriceObservationRecord,
    $$PriceObservationRecordsTableFilterComposer,
    $$PriceObservationRecordsTableOrderingComposer,
    $$PriceObservationRecordsTableAnnotationComposer,
    $$PriceObservationRecordsTableCreateCompanionBuilder,
    $$PriceObservationRecordsTableUpdateCompanionBuilder,
    (PriceObservationRecord, $$PriceObservationRecordsTableReferences),
    PriceObservationRecord,
    PrefetchHooks Function({bool wineId})> {
  $$PriceObservationRecordsTableTableManager(
      _$AppDatabase db, $PriceObservationRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceObservationRecordsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceObservationRecordsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceObservationRecordsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String> sourceName = const Value.absent(),
            Value<int> price = const Value.absent(),
            Value<DateTime> observedAt = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool?> isInStock = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceObservationRecordsCompanion(
            id: id,
            wineId: wineId,
            sourceName: sourceName,
            price: price,
            observedAt: observedAt,
            url: url,
            note: note,
            isInStock: isInStock,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String wineId,
            required String sourceName,
            required int price,
            required DateTime observedAt,
            Value<String?> url = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool?> isInStock = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceObservationRecordsCompanion.insert(
            id: id,
            wineId: wineId,
            sourceName: sourceName,
            price: price,
            observedAt: observedAt,
            url: url,
            note: note,
            isInStock: isInStock,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PriceObservationRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (wineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wineId,
                    referencedTable: $$PriceObservationRecordsTableReferences
                        ._wineIdTable(db),
                    referencedColumn: $$PriceObservationRecordsTableReferences
                        ._wineIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PriceObservationRecordsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PriceObservationRecordsTable,
        PriceObservationRecord,
        $$PriceObservationRecordsTableFilterComposer,
        $$PriceObservationRecordsTableOrderingComposer,
        $$PriceObservationRecordsTableAnnotationComposer,
        $$PriceObservationRecordsTableCreateCompanionBuilder,
        $$PriceObservationRecordsTableUpdateCompanionBuilder,
        (PriceObservationRecord, $$PriceObservationRecordsTableReferences),
        PriceObservationRecord,
        PrefetchHooks Function({bool wineId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WineRecordsTableTableManager get wineRecords =>
      $$WineRecordsTableTableManager(_db, _db.wineRecords);
  $$BottleRecordsTableTableManager get bottleRecords =>
      $$BottleRecordsTableTableManager(_db, _db.bottleRecords);
  $$TastingNoteRecordsTableTableManager get tastingNoteRecords =>
      $$TastingNoteRecordsTableTableManager(_db, _db.tastingNoteRecords);
  $$PriceObservationRecordsTableTableManager get priceObservationRecords =>
      $$PriceObservationRecordsTableTableManager(
          _db, _db.priceObservationRecords);
}
