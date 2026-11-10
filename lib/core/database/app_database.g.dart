// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WineRecordsTable extends WineRecords
    with TableInfo<$WineRecordsTable, WineRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WineRecordsTable(this.attachedDatabase, [this._alias]);
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
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _producerMeta =
      const VerificationMeta('producer');
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
      'producer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  static const VerificationMeta _vintageKindMeta =
      const VerificationMeta('vintageKind');
  @override
  late final GeneratedColumn<String> vintageKind = GeneratedColumn<String>(
      'vintage_kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _grapeVarietiesJsonMeta =
      const VerificationMeta('grapeVarietiesJson');
  @override
  late final GeneratedColumn<String> grapeVarietiesJson =
      GeneratedColumn<String>('grape_varieties_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isWishlistedMeta =
      const VerificationMeta('isWishlisted');
  @override
  late final GeneratedColumn<bool> isWishlisted = GeneratedColumn<bool>(
      'is_wishlisted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_wishlisted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        updatedAt,
        id,
        name,
        producer,
        country,
        region,
        vintage,
        vintageKind,
        type,
        grapeVarietiesJson,
        imagePath,
        isWishlisted,
        isArchived
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('producer')) {
      context.handle(_producerMeta,
          producer.isAcceptableOrUnknown(data['producer']!, _producerMeta));
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('vintage')) {
      context.handle(_vintageMeta,
          vintage.isAcceptableOrUnknown(data['vintage']!, _vintageMeta));
    }
    if (data.containsKey('vintage_kind')) {
      context.handle(
          _vintageKindMeta,
          vintageKind.isAcceptableOrUnknown(
              data['vintage_kind']!, _vintageKindMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('grape_varieties_json')) {
      context.handle(
          _grapeVarietiesJsonMeta,
          grapeVarietiesJson.isAcceptableOrUnknown(
              data['grape_varieties_json']!, _grapeVarietiesJsonMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('is_wishlisted')) {
      context.handle(
          _isWishlistedMeta,
          isWishlisted.isAcceptableOrUnknown(
              data['is_wishlisted']!, _isWishlistedMeta));
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WineRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WineRecord(
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      producer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}producer']),
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country']),
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      vintage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vintage']),
      vintageKind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vintage_kind'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      grapeVarietiesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}grape_varieties_json'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      isWishlisted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_wishlisted'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
    );
  }

  @override
  $WineRecordsTable createAlias(String alias) {
    return $WineRecordsTable(attachedDatabase, alias);
  }
}

class WineRecord extends DataClass implements Insertable<WineRecord> {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String id;
  final String? name;
  final String? producer;
  final String? country;
  final String? region;
  final int? vintage;
  final String vintageKind;
  final String? type;
  final String grapeVarietiesJson;
  final String? imagePath;
  final bool isWishlisted;
  final bool isArchived;
  const WineRecord(
      {required this.createdAt,
      this.updatedAt,
      required this.id,
      this.name,
      this.producer,
      this.country,
      this.region,
      this.vintage,
      required this.vintageKind,
      this.type,
      required this.grapeVarietiesJson,
      this.imagePath,
      required this.isWishlisted,
      required this.isArchived});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || vintage != null) {
      map['vintage'] = Variable<int>(vintage);
    }
    map['vintage_kind'] = Variable<String>(vintageKind);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    map['grape_varieties_json'] = Variable<String>(grapeVarietiesJson);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['is_wishlisted'] = Variable<bool>(isWishlisted);
    map['is_archived'] = Variable<bool>(isArchived);
    return map;
  }

  WineRecordsCompanion toCompanion(bool nullToAbsent) {
    return WineRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      vintage: vintage == null && nullToAbsent
          ? const Value.absent()
          : Value(vintage),
      vintageKind: Value(vintageKind),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      grapeVarietiesJson: Value(grapeVarietiesJson),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      isWishlisted: Value(isWishlisted),
      isArchived: Value(isArchived),
    );
  }

  factory WineRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WineRecord(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      producer: serializer.fromJson<String?>(json['producer']),
      country: serializer.fromJson<String?>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      vintage: serializer.fromJson<int?>(json['vintage']),
      vintageKind: serializer.fromJson<String>(json['vintageKind']),
      type: serializer.fromJson<String?>(json['type']),
      grapeVarietiesJson:
          serializer.fromJson<String>(json['grapeVarietiesJson']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      isWishlisted: serializer.fromJson<bool>(json['isWishlisted']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'producer': serializer.toJson<String?>(producer),
      'country': serializer.toJson<String?>(country),
      'region': serializer.toJson<String?>(region),
      'vintage': serializer.toJson<int?>(vintage),
      'vintageKind': serializer.toJson<String>(vintageKind),
      'type': serializer.toJson<String?>(type),
      'grapeVarietiesJson': serializer.toJson<String>(grapeVarietiesJson),
      'imagePath': serializer.toJson<String?>(imagePath),
      'isWishlisted': serializer.toJson<bool>(isWishlisted),
      'isArchived': serializer.toJson<bool>(isArchived),
    };
  }

  WineRecord copyWith(
          {DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          String? id,
          Value<String?> name = const Value.absent(),
          Value<String?> producer = const Value.absent(),
          Value<String?> country = const Value.absent(),
          Value<String?> region = const Value.absent(),
          Value<int?> vintage = const Value.absent(),
          String? vintageKind,
          Value<String?> type = const Value.absent(),
          String? grapeVarietiesJson,
          Value<String?> imagePath = const Value.absent(),
          bool? isWishlisted,
          bool? isArchived}) =>
      WineRecord(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        producer: producer.present ? producer.value : this.producer,
        country: country.present ? country.value : this.country,
        region: region.present ? region.value : this.region,
        vintage: vintage.present ? vintage.value : this.vintage,
        vintageKind: vintageKind ?? this.vintageKind,
        type: type.present ? type.value : this.type,
        grapeVarietiesJson: grapeVarietiesJson ?? this.grapeVarietiesJson,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        isWishlisted: isWishlisted ?? this.isWishlisted,
        isArchived: isArchived ?? this.isArchived,
      );
  WineRecord copyWithCompanion(WineRecordsCompanion data) {
    return WineRecord(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      producer: data.producer.present ? data.producer.value : this.producer,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      vintage: data.vintage.present ? data.vintage.value : this.vintage,
      vintageKind:
          data.vintageKind.present ? data.vintageKind.value : this.vintageKind,
      type: data.type.present ? data.type.value : this.type,
      grapeVarietiesJson: data.grapeVarietiesJson.present
          ? data.grapeVarietiesJson.value
          : this.grapeVarietiesJson,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      isWishlisted: data.isWishlisted.present
          ? data.isWishlisted.value
          : this.isWishlisted,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WineRecord(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('vintage: $vintage, ')
          ..write('vintageKind: $vintageKind, ')
          ..write('type: $type, ')
          ..write('grapeVarietiesJson: $grapeVarietiesJson, ')
          ..write('imagePath: $imagePath, ')
          ..write('isWishlisted: $isWishlisted, ')
          ..write('isArchived: $isArchived')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      createdAt,
      updatedAt,
      id,
      name,
      producer,
      country,
      region,
      vintage,
      vintageKind,
      type,
      grapeVarietiesJson,
      imagePath,
      isWishlisted,
      isArchived);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WineRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.producer == this.producer &&
          other.country == this.country &&
          other.region == this.region &&
          other.vintage == this.vintage &&
          other.vintageKind == this.vintageKind &&
          other.type == this.type &&
          other.grapeVarietiesJson == this.grapeVarietiesJson &&
          other.imagePath == this.imagePath &&
          other.isWishlisted == this.isWishlisted &&
          other.isArchived == this.isArchived);
}

class WineRecordsCompanion extends UpdateCompanion<WineRecord> {
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> producer;
  final Value<String?> country;
  final Value<String?> region;
  final Value<int?> vintage;
  final Value<String> vintageKind;
  final Value<String?> type;
  final Value<String> grapeVarietiesJson;
  final Value<String?> imagePath;
  final Value<bool> isWishlisted;
  final Value<bool> isArchived;
  final Value<int> rowid;
  const WineRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.producer = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.vintage = const Value.absent(),
    this.vintageKind = const Value.absent(),
    this.type = const Value.absent(),
    this.grapeVarietiesJson = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isWishlisted = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WineRecordsCompanion.insert({
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String id,
    this.name = const Value.absent(),
    this.producer = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.vintage = const Value.absent(),
    this.vintageKind = const Value.absent(),
    this.type = const Value.absent(),
    this.grapeVarietiesJson = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.isWishlisted = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : createdAt = Value(createdAt),
        id = Value(id);
  static Insertable<WineRecord> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? producer,
    Expression<String>? country,
    Expression<String>? region,
    Expression<int>? vintage,
    Expression<String>? vintageKind,
    Expression<String>? type,
    Expression<String>? grapeVarietiesJson,
    Expression<String>? imagePath,
    Expression<bool>? isWishlisted,
    Expression<bool>? isArchived,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (producer != null) 'producer': producer,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (vintage != null) 'vintage': vintage,
      if (vintageKind != null) 'vintage_kind': vintageKind,
      if (type != null) 'type': type,
      if (grapeVarietiesJson != null)
        'grape_varieties_json': grapeVarietiesJson,
      if (imagePath != null) 'image_path': imagePath,
      if (isWishlisted != null) 'is_wishlisted': isWishlisted,
      if (isArchived != null) 'is_archived': isArchived,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WineRecordsCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? id,
      Value<String?>? name,
      Value<String?>? producer,
      Value<String?>? country,
      Value<String?>? region,
      Value<int?>? vintage,
      Value<String>? vintageKind,
      Value<String?>? type,
      Value<String>? grapeVarietiesJson,
      Value<String?>? imagePath,
      Value<bool>? isWishlisted,
      Value<bool>? isArchived,
      Value<int>? rowid}) {
    return WineRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      producer: producer ?? this.producer,
      country: country ?? this.country,
      region: region ?? this.region,
      vintage: vintage ?? this.vintage,
      vintageKind: vintageKind ?? this.vintageKind,
      type: type ?? this.type,
      grapeVarietiesJson: grapeVarietiesJson ?? this.grapeVarietiesJson,
      imagePath: imagePath ?? this.imagePath,
      isWishlisted: isWishlisted ?? this.isWishlisted,
      isArchived: isArchived ?? this.isArchived,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
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
    if (vintageKind.present) {
      map['vintage_kind'] = Variable<String>(vintageKind.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (grapeVarietiesJson.present) {
      map['grape_varieties_json'] = Variable<String>(grapeVarietiesJson.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (isWishlisted.present) {
      map['is_wishlisted'] = Variable<bool>(isWishlisted.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WineRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('producer: $producer, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('vintage: $vintage, ')
          ..write('vintageKind: $vintageKind, ')
          ..write('type: $type, ')
          ..write('grapeVarietiesJson: $grapeVarietiesJson, ')
          ..write('imagePath: $imagePath, ')
          ..write('isWishlisted: $isWishlisted, ')
          ..write('isArchived: $isArchived, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseRecordsTable extends PurchaseRecords
    with TableInfo<$PurchaseRecordsTable, PurchaseRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseRecordsTable(this.attachedDatabase, [this._alias]);
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
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wine_records (id) ON DELETE RESTRICT'));
  static const VerificationMeta _purchaseDateMeta =
      const VerificationMeta('purchaseDate');
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
      'purchase_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _shopNameMeta =
      const VerificationMeta('shopName');
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
      'shop_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _purchasedQuantityMeta =
      const VerificationMeta('purchasedQuantity');
  @override
  late final GeneratedColumn<int> purchasedQuantity = GeneratedColumn<int>(
      'purchased_quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _totalPaidKrwMeta =
      const VerificationMeta('totalPaidKrw');
  @override
  late final GeneratedColumn<int> totalPaidKrw = GeneratedColumn<int>(
      'total_paid_krw', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _volumeMlMeta =
      const VerificationMeta('volumeMl');
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
      'volume_ml', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        updatedAt,
        id,
        wineId,
        purchaseDate,
        shopName,
        purchasedQuantity,
        totalPaidKrw,
        volumeMl,
        note
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_records';
  @override
  VerificationContext validateIntegrity(Insertable<PurchaseRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
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
    }
    if (data.containsKey('shop_name')) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta));
    }
    if (data.containsKey('purchased_quantity')) {
      context.handle(
          _purchasedQuantityMeta,
          purchasedQuantity.isAcceptableOrUnknown(
              data['purchased_quantity']!, _purchasedQuantityMeta));
    } else if (isInserting) {
      context.missing(_purchasedQuantityMeta);
    }
    if (data.containsKey('total_paid_krw')) {
      context.handle(
          _totalPaidKrwMeta,
          totalPaidKrw.isAcceptableOrUnknown(
              data['total_paid_krw']!, _totalPaidKrwMeta));
    }
    if (data.containsKey('volume_ml')) {
      context.handle(_volumeMlMeta,
          volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseRecord(
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      purchaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}purchase_date']),
      shopName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shop_name']),
      purchasedQuantity: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}purchased_quantity'])!,
      totalPaidKrw: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_paid_krw']),
      volumeMl: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume_ml']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $PurchaseRecordsTable createAlias(String alias) {
    return $PurchaseRecordsTable(attachedDatabase, alias);
  }
}

class PurchaseRecord extends DataClass implements Insertable<PurchaseRecord> {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String id;
  final String wineId;
  final DateTime? purchaseDate;
  final String? shopName;
  final int purchasedQuantity;
  final int? totalPaidKrw;
  final int? volumeMl;
  final String? note;
  const PurchaseRecord(
      {required this.createdAt,
      this.updatedAt,
      required this.id,
      required this.wineId,
      this.purchaseDate,
      this.shopName,
      required this.purchasedQuantity,
      this.totalPaidKrw,
      this.volumeMl,
      this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || shopName != null) {
      map['shop_name'] = Variable<String>(shopName);
    }
    map['purchased_quantity'] = Variable<int>(purchasedQuantity);
    if (!nullToAbsent || totalPaidKrw != null) {
      map['total_paid_krw'] = Variable<int>(totalPaidKrw);
    }
    if (!nullToAbsent || volumeMl != null) {
      map['volume_ml'] = Variable<int>(volumeMl);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  PurchaseRecordsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      id: Value(id),
      wineId: Value(wineId),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      shopName: shopName == null && nullToAbsent
          ? const Value.absent()
          : Value(shopName),
      purchasedQuantity: Value(purchasedQuantity),
      totalPaidKrw: totalPaidKrw == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPaidKrw),
      volumeMl: volumeMl == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeMl),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory PurchaseRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseRecord(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      shopName: serializer.fromJson<String?>(json['shopName']),
      purchasedQuantity: serializer.fromJson<int>(json['purchasedQuantity']),
      totalPaidKrw: serializer.fromJson<int?>(json['totalPaidKrw']),
      volumeMl: serializer.fromJson<int?>(json['volumeMl']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'shopName': serializer.toJson<String?>(shopName),
      'purchasedQuantity': serializer.toJson<int>(purchasedQuantity),
      'totalPaidKrw': serializer.toJson<int?>(totalPaidKrw),
      'volumeMl': serializer.toJson<int?>(volumeMl),
      'note': serializer.toJson<String?>(note),
    };
  }

  PurchaseRecord copyWith(
          {DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          String? id,
          String? wineId,
          Value<DateTime?> purchaseDate = const Value.absent(),
          Value<String?> shopName = const Value.absent(),
          int? purchasedQuantity,
          Value<int?> totalPaidKrw = const Value.absent(),
          Value<int?> volumeMl = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      PurchaseRecord(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        purchaseDate:
            purchaseDate.present ? purchaseDate.value : this.purchaseDate,
        shopName: shopName.present ? shopName.value : this.shopName,
        purchasedQuantity: purchasedQuantity ?? this.purchasedQuantity,
        totalPaidKrw:
            totalPaidKrw.present ? totalPaidKrw.value : this.totalPaidKrw,
        volumeMl: volumeMl.present ? volumeMl.value : this.volumeMl,
        note: note.present ? note.value : this.note,
      );
  PurchaseRecord copyWithCompanion(PurchaseRecordsCompanion data) {
    return PurchaseRecord(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      purchasedQuantity: data.purchasedQuantity.present
          ? data.purchasedQuantity.value
          : this.purchasedQuantity,
      totalPaidKrw: data.totalPaidKrw.present
          ? data.totalPaidKrw.value
          : this.totalPaidKrw,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRecord(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('shopName: $shopName, ')
          ..write('purchasedQuantity: $purchasedQuantity, ')
          ..write('totalPaidKrw: $totalPaidKrw, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, wineId,
      purchaseDate, shopName, purchasedQuantity, totalPaidKrw, volumeMl, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.purchaseDate == this.purchaseDate &&
          other.shopName == this.shopName &&
          other.purchasedQuantity == this.purchasedQuantity &&
          other.totalPaidKrw == this.totalPaidKrw &&
          other.volumeMl == this.volumeMl &&
          other.note == this.note);
}

class PurchaseRecordsCompanion extends UpdateCompanion<PurchaseRecord> {
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> id;
  final Value<String> wineId;
  final Value<DateTime?> purchaseDate;
  final Value<String?> shopName;
  final Value<int> purchasedQuantity;
  final Value<int?> totalPaidKrw;
  final Value<int?> volumeMl;
  final Value<String?> note;
  final Value<int> rowid;
  const PurchaseRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.shopName = const Value.absent(),
    this.purchasedQuantity = const Value.absent(),
    this.totalPaidKrw = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseRecordsCompanion.insert({
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String id,
    required String wineId,
    this.purchaseDate = const Value.absent(),
    this.shopName = const Value.absent(),
    required int purchasedQuantity,
    this.totalPaidKrw = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : createdAt = Value(createdAt),
        id = Value(id),
        wineId = Value(wineId),
        purchasedQuantity = Value(purchasedQuantity);
  static Insertable<PurchaseRecord> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<DateTime>? purchaseDate,
    Expression<String>? shopName,
    Expression<int>? purchasedQuantity,
    Expression<int>? totalPaidKrw,
    Expression<int>? volumeMl,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (shopName != null) 'shop_name': shopName,
      if (purchasedQuantity != null) 'purchased_quantity': purchasedQuantity,
      if (totalPaidKrw != null) 'total_paid_krw': totalPaidKrw,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseRecordsCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? id,
      Value<String>? wineId,
      Value<DateTime?>? purchaseDate,
      Value<String?>? shopName,
      Value<int>? purchasedQuantity,
      Value<int?>? totalPaidKrw,
      Value<int?>? volumeMl,
      Value<String?>? note,
      Value<int>? rowid}) {
    return PurchaseRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      shopName: shopName ?? this.shopName,
      purchasedQuantity: purchasedQuantity ?? this.purchasedQuantity,
      totalPaidKrw: totalPaidKrw ?? this.totalPaidKrw,
      volumeMl: volumeMl ?? this.volumeMl,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (purchasedQuantity.present) {
      map['purchased_quantity'] = Variable<int>(purchasedQuantity.value);
    }
    if (totalPaidKrw.present) {
      map['total_paid_krw'] = Variable<int>(totalPaidKrw.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('shopName: $shopName, ')
          ..write('purchasedQuantity: $purchasedQuantity, ')
          ..write('totalPaidKrw: $totalPaidKrw, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('note: $note, ')
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
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wine_records (id) ON DELETE RESTRICT'));
  static const VerificationMeta _purchaseIdMeta =
      const VerificationMeta('purchaseId');
  @override
  late final GeneratedColumn<String> purchaseId = GeneratedColumn<String>(
      'purchase_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES purchase_records (id) ON DELETE SET NULL'));
  static const VerificationMeta _acquisitionKindMeta =
      const VerificationMeta('acquisitionKind');
  @override
  late final GeneratedColumn<String> acquisitionKind = GeneratedColumn<String>(
      'acquisition_kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  static const VerificationMeta _acquiredAtMeta =
      const VerificationMeta('acquiredAt');
  @override
  late final GeneratedColumn<DateTime> acquiredAt = GeneratedColumn<DateTime>(
      'acquired_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _volumeMlMeta =
      const VerificationMeta('volumeMl');
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
      'volume_ml', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('inStock'));
  static const VerificationMeta _statusChangedAtMeta =
      const VerificationMeta('statusChangedAt');
  @override
  late final GeneratedColumn<DateTime> statusChangedAt =
      GeneratedColumn<DateTime>('status_changed_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        updatedAt,
        id,
        wineId,
        purchaseId,
        acquisitionKind,
        acquiredAt,
        volumeMl,
        status,
        statusChangedAt,
        imagePath,
        storageLocation
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
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
    if (data.containsKey('purchase_id')) {
      context.handle(
          _purchaseIdMeta,
          purchaseId.isAcceptableOrUnknown(
              data['purchase_id']!, _purchaseIdMeta));
    }
    if (data.containsKey('acquisition_kind')) {
      context.handle(
          _acquisitionKindMeta,
          acquisitionKind.isAcceptableOrUnknown(
              data['acquisition_kind']!, _acquisitionKindMeta));
    }
    if (data.containsKey('acquired_at')) {
      context.handle(
          _acquiredAtMeta,
          acquiredAt.isAcceptableOrUnknown(
              data['acquired_at']!, _acquiredAtMeta));
    }
    if (data.containsKey('volume_ml')) {
      context.handle(_volumeMlMeta,
          volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('status_changed_at')) {
      context.handle(
          _statusChangedAtMeta,
          statusChangedAt.isAcceptableOrUnknown(
              data['status_changed_at']!, _statusChangedAtMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BottleRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BottleRecord(
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      purchaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}purchase_id']),
      acquisitionKind: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}acquisition_kind'])!,
      acquiredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}acquired_at']),
      volumeMl: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume_ml']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      statusChangedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}status_changed_at']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      storageLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}storage_location']),
    );
  }

  @override
  $BottleRecordsTable createAlias(String alias) {
    return $BottleRecordsTable(attachedDatabase, alias);
  }
}

class BottleRecord extends DataClass implements Insertable<BottleRecord> {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String id;
  final String wineId;
  final String? purchaseId;
  final String acquisitionKind;
  final DateTime? acquiredAt;
  final int? volumeMl;
  final String status;
  final DateTime? statusChangedAt;
  final String? imagePath;
  final String? storageLocation;
  const BottleRecord(
      {required this.createdAt,
      this.updatedAt,
      required this.id,
      required this.wineId,
      this.purchaseId,
      required this.acquisitionKind,
      this.acquiredAt,
      this.volumeMl,
      required this.status,
      this.statusChangedAt,
      this.imagePath,
      this.storageLocation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<String>(purchaseId);
    }
    map['acquisition_kind'] = Variable<String>(acquisitionKind);
    if (!nullToAbsent || acquiredAt != null) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt);
    }
    if (!nullToAbsent || volumeMl != null) {
      map['volume_ml'] = Variable<int>(volumeMl);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || statusChangedAt != null) {
      map['status_changed_at'] = Variable<DateTime>(statusChangedAt);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || storageLocation != null) {
      map['storage_location'] = Variable<String>(storageLocation);
    }
    return map;
  }

  BottleRecordsCompanion toCompanion(bool nullToAbsent) {
    return BottleRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      id: Value(id),
      wineId: Value(wineId),
      purchaseId: purchaseId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseId),
      acquisitionKind: Value(acquisitionKind),
      acquiredAt: acquiredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(acquiredAt),
      volumeMl: volumeMl == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeMl),
      status: Value(status),
      statusChangedAt: statusChangedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(statusChangedAt),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      storageLocation: storageLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(storageLocation),
    );
  }

  factory BottleRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BottleRecord(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      purchaseId: serializer.fromJson<String?>(json['purchaseId']),
      acquisitionKind: serializer.fromJson<String>(json['acquisitionKind']),
      acquiredAt: serializer.fromJson<DateTime?>(json['acquiredAt']),
      volumeMl: serializer.fromJson<int?>(json['volumeMl']),
      status: serializer.fromJson<String>(json['status']),
      statusChangedAt: serializer.fromJson<DateTime?>(json['statusChangedAt']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      storageLocation: serializer.fromJson<String?>(json['storageLocation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'purchaseId': serializer.toJson<String?>(purchaseId),
      'acquisitionKind': serializer.toJson<String>(acquisitionKind),
      'acquiredAt': serializer.toJson<DateTime?>(acquiredAt),
      'volumeMl': serializer.toJson<int?>(volumeMl),
      'status': serializer.toJson<String>(status),
      'statusChangedAt': serializer.toJson<DateTime?>(statusChangedAt),
      'imagePath': serializer.toJson<String?>(imagePath),
      'storageLocation': serializer.toJson<String?>(storageLocation),
    };
  }

  BottleRecord copyWith(
          {DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          String? id,
          String? wineId,
          Value<String?> purchaseId = const Value.absent(),
          String? acquisitionKind,
          Value<DateTime?> acquiredAt = const Value.absent(),
          Value<int?> volumeMl = const Value.absent(),
          String? status,
          Value<DateTime?> statusChangedAt = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> storageLocation = const Value.absent()}) =>
      BottleRecord(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
        acquisitionKind: acquisitionKind ?? this.acquisitionKind,
        acquiredAt: acquiredAt.present ? acquiredAt.value : this.acquiredAt,
        volumeMl: volumeMl.present ? volumeMl.value : this.volumeMl,
        status: status ?? this.status,
        statusChangedAt: statusChangedAt.present
            ? statusChangedAt.value
            : this.statusChangedAt,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        storageLocation: storageLocation.present
            ? storageLocation.value
            : this.storageLocation,
      );
  BottleRecord copyWithCompanion(BottleRecordsCompanion data) {
    return BottleRecord(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      id: data.id.present ? data.id.value : this.id,
      wineId: data.wineId.present ? data.wineId.value : this.wineId,
      purchaseId:
          data.purchaseId.present ? data.purchaseId.value : this.purchaseId,
      acquisitionKind: data.acquisitionKind.present
          ? data.acquisitionKind.value
          : this.acquisitionKind,
      acquiredAt:
          data.acquiredAt.present ? data.acquiredAt.value : this.acquiredAt,
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
      status: data.status.present ? data.status.value : this.status,
      statusChangedAt: data.statusChangedAt.present
          ? data.statusChangedAt.value
          : this.statusChangedAt,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      storageLocation: data.storageLocation.present
          ? data.storageLocation.value
          : this.storageLocation,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BottleRecord(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('acquisitionKind: $acquisitionKind, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('status: $status, ')
          ..write('statusChangedAt: $statusChangedAt, ')
          ..write('imagePath: $imagePath, ')
          ..write('storageLocation: $storageLocation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      createdAt,
      updatedAt,
      id,
      wineId,
      purchaseId,
      acquisitionKind,
      acquiredAt,
      volumeMl,
      status,
      statusChangedAt,
      imagePath,
      storageLocation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BottleRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.purchaseId == this.purchaseId &&
          other.acquisitionKind == this.acquisitionKind &&
          other.acquiredAt == this.acquiredAt &&
          other.volumeMl == this.volumeMl &&
          other.status == this.status &&
          other.statusChangedAt == this.statusChangedAt &&
          other.imagePath == this.imagePath &&
          other.storageLocation == this.storageLocation);
}

class BottleRecordsCompanion extends UpdateCompanion<BottleRecord> {
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> id;
  final Value<String> wineId;
  final Value<String?> purchaseId;
  final Value<String> acquisitionKind;
  final Value<DateTime?> acquiredAt;
  final Value<int?> volumeMl;
  final Value<String> status;
  final Value<DateTime?> statusChangedAt;
  final Value<String?> imagePath;
  final Value<String?> storageLocation;
  final Value<int> rowid;
  const BottleRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.acquisitionKind = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.status = const Value.absent(),
    this.statusChangedAt = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BottleRecordsCompanion.insert({
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String id,
    required String wineId,
    this.purchaseId = const Value.absent(),
    this.acquisitionKind = const Value.absent(),
    this.acquiredAt = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.status = const Value.absent(),
    this.statusChangedAt = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.storageLocation = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : createdAt = Value(createdAt),
        id = Value(id),
        wineId = Value(wineId);
  static Insertable<BottleRecord> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<String>? purchaseId,
    Expression<String>? acquisitionKind,
    Expression<DateTime>? acquiredAt,
    Expression<int>? volumeMl,
    Expression<String>? status,
    Expression<DateTime>? statusChangedAt,
    Expression<String>? imagePath,
    Expression<String>? storageLocation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (acquisitionKind != null) 'acquisition_kind': acquisitionKind,
      if (acquiredAt != null) 'acquired_at': acquiredAt,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (status != null) 'status': status,
      if (statusChangedAt != null) 'status_changed_at': statusChangedAt,
      if (imagePath != null) 'image_path': imagePath,
      if (storageLocation != null) 'storage_location': storageLocation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BottleRecordsCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? id,
      Value<String>? wineId,
      Value<String?>? purchaseId,
      Value<String>? acquisitionKind,
      Value<DateTime?>? acquiredAt,
      Value<int?>? volumeMl,
      Value<String>? status,
      Value<DateTime?>? statusChangedAt,
      Value<String?>? imagePath,
      Value<String?>? storageLocation,
      Value<int>? rowid}) {
    return BottleRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      purchaseId: purchaseId ?? this.purchaseId,
      acquisitionKind: acquisitionKind ?? this.acquisitionKind,
      acquiredAt: acquiredAt ?? this.acquiredAt,
      volumeMl: volumeMl ?? this.volumeMl,
      status: status ?? this.status,
      statusChangedAt: statusChangedAt ?? this.statusChangedAt,
      imagePath: imagePath ?? this.imagePath,
      storageLocation: storageLocation ?? this.storageLocation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wineId.present) {
      map['wine_id'] = Variable<String>(wineId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<String>(purchaseId.value);
    }
    if (acquisitionKind.present) {
      map['acquisition_kind'] = Variable<String>(acquisitionKind.value);
    }
    if (acquiredAt.present) {
      map['acquired_at'] = Variable<DateTime>(acquiredAt.value);
    }
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (statusChangedAt.present) {
      map['status_changed_at'] = Variable<DateTime>(statusChangedAt.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (storageLocation.present) {
      map['storage_location'] = Variable<String>(storageLocation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BottleRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('acquisitionKind: $acquisitionKind, ')
          ..write('acquiredAt: $acquiredAt, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('status: $status, ')
          ..write('statusChangedAt: $statusChangedAt, ')
          ..write('imagePath: $imagePath, ')
          ..write('storageLocation: $storageLocation, ')
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
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wine_records (id) ON DELETE RESTRICT'));
  static const VerificationMeta _bottleIdMeta =
      const VerificationMeta('bottleId');
  @override
  late final GeneratedColumn<String> bottleId = GeneratedColumn<String>(
      'bottle_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES bottle_records (id) ON DELETE SET NULL'));
  static const VerificationMeta _tastedAtMeta =
      const VerificationMeta('tastedAt');
  @override
  late final GeneratedColumn<DateTime> tastedAt = GeneratedColumn<DateTime>(
      'tasted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
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
  static const VerificationMeta _buyAgainMeta =
      const VerificationMeta('buyAgain');
  @override
  late final GeneratedColumn<String> buyAgain = GeneratedColumn<String>(
      'buy_again', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        updatedAt,
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
        buyAgain
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
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
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
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
    if (data.containsKey('buy_again')) {
      context.handle(_buyAgainMeta,
          buyAgain.isAcceptableOrUnknown(data['buy_again']!, _buyAgainMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TastingNoteRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TastingNoteRecord(
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      wineId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wine_id'])!,
      bottleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bottle_id']),
      tastedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}tasted_at']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
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
      buyAgain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buy_again']),
    );
  }

  @override
  $TastingNoteRecordsTable createAlias(String alias) {
    return $TastingNoteRecordsTable(attachedDatabase, alias);
  }
}

class TastingNoteRecord extends DataClass
    implements Insertable<TastingNoteRecord> {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String id;
  final String wineId;
  final String? bottleId;
  final DateTime? tastedAt;
  final double? rating;
  final String? imagePath;
  final String? aroma;
  final String? palate;
  final String? pairing;
  final int? acidity;
  final int? tannin;
  final int? body;
  final int? sweetness;
  final String? memo;
  final String? buyAgain;
  const TastingNoteRecord(
      {required this.createdAt,
      this.updatedAt,
      required this.id,
      required this.wineId,
      this.bottleId,
      this.tastedAt,
      this.rating,
      this.imagePath,
      this.aroma,
      this.palate,
      this.pairing,
      this.acidity,
      this.tannin,
      this.body,
      this.sweetness,
      this.memo,
      this.buyAgain});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['id'] = Variable<String>(id);
    map['wine_id'] = Variable<String>(wineId);
    if (!nullToAbsent || bottleId != null) {
      map['bottle_id'] = Variable<String>(bottleId);
    }
    if (!nullToAbsent || tastedAt != null) {
      map['tasted_at'] = Variable<DateTime>(tastedAt);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
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
    if (!nullToAbsent || buyAgain != null) {
      map['buy_again'] = Variable<String>(buyAgain);
    }
    return map;
  }

  TastingNoteRecordsCompanion toCompanion(bool nullToAbsent) {
    return TastingNoteRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      id: Value(id),
      wineId: Value(wineId),
      bottleId: bottleId == null && nullToAbsent
          ? const Value.absent()
          : Value(bottleId),
      tastedAt: tastedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(tastedAt),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
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
      buyAgain: buyAgain == null && nullToAbsent
          ? const Value.absent()
          : Value(buyAgain),
    );
  }

  factory TastingNoteRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TastingNoteRecord(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      bottleId: serializer.fromJson<String?>(json['bottleId']),
      tastedAt: serializer.fromJson<DateTime?>(json['tastedAt']),
      rating: serializer.fromJson<double?>(json['rating']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      aroma: serializer.fromJson<String?>(json['aroma']),
      palate: serializer.fromJson<String?>(json['palate']),
      pairing: serializer.fromJson<String?>(json['pairing']),
      acidity: serializer.fromJson<int?>(json['acidity']),
      tannin: serializer.fromJson<int?>(json['tannin']),
      body: serializer.fromJson<int?>(json['body']),
      sweetness: serializer.fromJson<int?>(json['sweetness']),
      memo: serializer.fromJson<String?>(json['memo']),
      buyAgain: serializer.fromJson<String?>(json['buyAgain']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'bottleId': serializer.toJson<String?>(bottleId),
      'tastedAt': serializer.toJson<DateTime?>(tastedAt),
      'rating': serializer.toJson<double?>(rating),
      'imagePath': serializer.toJson<String?>(imagePath),
      'aroma': serializer.toJson<String?>(aroma),
      'palate': serializer.toJson<String?>(palate),
      'pairing': serializer.toJson<String?>(pairing),
      'acidity': serializer.toJson<int?>(acidity),
      'tannin': serializer.toJson<int?>(tannin),
      'body': serializer.toJson<int?>(body),
      'sweetness': serializer.toJson<int?>(sweetness),
      'memo': serializer.toJson<String?>(memo),
      'buyAgain': serializer.toJson<String?>(buyAgain),
    };
  }

  TastingNoteRecord copyWith(
          {DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          String? id,
          String? wineId,
          Value<String?> bottleId = const Value.absent(),
          Value<DateTime?> tastedAt = const Value.absent(),
          Value<double?> rating = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> aroma = const Value.absent(),
          Value<String?> palate = const Value.absent(),
          Value<String?> pairing = const Value.absent(),
          Value<int?> acidity = const Value.absent(),
          Value<int?> tannin = const Value.absent(),
          Value<int?> body = const Value.absent(),
          Value<int?> sweetness = const Value.absent(),
          Value<String?> memo = const Value.absent(),
          Value<String?> buyAgain = const Value.absent()}) =>
      TastingNoteRecord(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        bottleId: bottleId.present ? bottleId.value : this.bottleId,
        tastedAt: tastedAt.present ? tastedAt.value : this.tastedAt,
        rating: rating.present ? rating.value : this.rating,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        aroma: aroma.present ? aroma.value : this.aroma,
        palate: palate.present ? palate.value : this.palate,
        pairing: pairing.present ? pairing.value : this.pairing,
        acidity: acidity.present ? acidity.value : this.acidity,
        tannin: tannin.present ? tannin.value : this.tannin,
        body: body.present ? body.value : this.body,
        sweetness: sweetness.present ? sweetness.value : this.sweetness,
        memo: memo.present ? memo.value : this.memo,
        buyAgain: buyAgain.present ? buyAgain.value : this.buyAgain,
      );
  TastingNoteRecord copyWithCompanion(TastingNoteRecordsCompanion data) {
    return TastingNoteRecord(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
      buyAgain: data.buyAgain.present ? data.buyAgain.value : this.buyAgain,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TastingNoteRecord(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
          ..write('buyAgain: $buyAgain')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      createdAt,
      updatedAt,
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
      buyAgain);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TastingNoteRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
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
          other.buyAgain == this.buyAgain);
}

class TastingNoteRecordsCompanion extends UpdateCompanion<TastingNoteRecord> {
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> id;
  final Value<String> wineId;
  final Value<String?> bottleId;
  final Value<DateTime?> tastedAt;
  final Value<double?> rating;
  final Value<String?> imagePath;
  final Value<String?> aroma;
  final Value<String?> palate;
  final Value<String?> pairing;
  final Value<int?> acidity;
  final Value<int?> tannin;
  final Value<int?> body;
  final Value<int?> sweetness;
  final Value<String?> memo;
  final Value<String?> buyAgain;
  final Value<int> rowid;
  const TastingNoteRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
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
    this.buyAgain = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TastingNoteRecordsCompanion.insert({
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String id,
    required String wineId,
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
    this.buyAgain = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : createdAt = Value(createdAt),
        id = Value(id),
        wineId = Value(wineId);
  static Insertable<TastingNoteRecord> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
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
    Expression<String>? buyAgain,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
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
      if (buyAgain != null) 'buy_again': buyAgain,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TastingNoteRecordsCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? id,
      Value<String>? wineId,
      Value<String?>? bottleId,
      Value<DateTime?>? tastedAt,
      Value<double?>? rating,
      Value<String?>? imagePath,
      Value<String?>? aroma,
      Value<String?>? palate,
      Value<String?>? pairing,
      Value<int?>? acidity,
      Value<int?>? tannin,
      Value<int?>? body,
      Value<int?>? sweetness,
      Value<String?>? memo,
      Value<String?>? buyAgain,
      Value<int>? rowid}) {
    return TastingNoteRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
      buyAgain: buyAgain ?? this.buyAgain,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
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
    if (buyAgain.present) {
      map['buy_again'] = Variable<String>(buyAgain.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TastingNoteRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
          ..write('buyAgain: $buyAgain, ')
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
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wine_records (id) ON DELETE RESTRICT'));
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
  static const VerificationMeta _volumeMlMeta =
      const VerificationMeta('volumeMl');
  @override
  late final GeneratedColumn<int> volumeMl = GeneratedColumn<int>(
      'volume_ml', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        createdAt,
        updatedAt,
        id,
        wineId,
        sourceName,
        price,
        observedAt,
        url,
        note,
        isInStock,
        volumeMl
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
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
    if (data.containsKey('volume_ml')) {
      context.handle(_volumeMlMeta,
          volumeMl.isAcceptableOrUnknown(data['volume_ml']!, _volumeMlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceObservationRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceObservationRecord(
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
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
      volumeMl: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}volume_ml']),
    );
  }

  @override
  $PriceObservationRecordsTable createAlias(String alias) {
    return $PriceObservationRecordsTable(attachedDatabase, alias);
  }
}

class PriceObservationRecord extends DataClass
    implements Insertable<PriceObservationRecord> {
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String id;
  final String wineId;
  final String sourceName;
  final int price;
  final DateTime observedAt;
  final String? url;
  final String? note;
  final bool? isInStock;
  final int? volumeMl;
  const PriceObservationRecord(
      {required this.createdAt,
      this.updatedAt,
      required this.id,
      required this.wineId,
      required this.sourceName,
      required this.price,
      required this.observedAt,
      this.url,
      this.note,
      this.isInStock,
      this.volumeMl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
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
    if (!nullToAbsent || volumeMl != null) {
      map['volume_ml'] = Variable<int>(volumeMl);
    }
    return map;
  }

  PriceObservationRecordsCompanion toCompanion(bool nullToAbsent) {
    return PriceObservationRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
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
      volumeMl: volumeMl == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeMl),
    );
  }

  factory PriceObservationRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceObservationRecord(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      id: serializer.fromJson<String>(json['id']),
      wineId: serializer.fromJson<String>(json['wineId']),
      sourceName: serializer.fromJson<String>(json['sourceName']),
      price: serializer.fromJson<int>(json['price']),
      observedAt: serializer.fromJson<DateTime>(json['observedAt']),
      url: serializer.fromJson<String?>(json['url']),
      note: serializer.fromJson<String?>(json['note']),
      isInStock: serializer.fromJson<bool?>(json['isInStock']),
      volumeMl: serializer.fromJson<int?>(json['volumeMl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'id': serializer.toJson<String>(id),
      'wineId': serializer.toJson<String>(wineId),
      'sourceName': serializer.toJson<String>(sourceName),
      'price': serializer.toJson<int>(price),
      'observedAt': serializer.toJson<DateTime>(observedAt),
      'url': serializer.toJson<String?>(url),
      'note': serializer.toJson<String?>(note),
      'isInStock': serializer.toJson<bool?>(isInStock),
      'volumeMl': serializer.toJson<int?>(volumeMl),
    };
  }

  PriceObservationRecord copyWith(
          {DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          String? id,
          String? wineId,
          String? sourceName,
          int? price,
          DateTime? observedAt,
          Value<String?> url = const Value.absent(),
          Value<String?> note = const Value.absent(),
          Value<bool?> isInStock = const Value.absent(),
          Value<int?> volumeMl = const Value.absent()}) =>
      PriceObservationRecord(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        id: id ?? this.id,
        wineId: wineId ?? this.wineId,
        sourceName: sourceName ?? this.sourceName,
        price: price ?? this.price,
        observedAt: observedAt ?? this.observedAt,
        url: url.present ? url.value : this.url,
        note: note.present ? note.value : this.note,
        isInStock: isInStock.present ? isInStock.value : this.isInStock,
        volumeMl: volumeMl.present ? volumeMl.value : this.volumeMl,
      );
  PriceObservationRecord copyWithCompanion(
      PriceObservationRecordsCompanion data) {
    return PriceObservationRecord(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
      volumeMl: data.volumeMl.present ? data.volumeMl.value : this.volumeMl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservationRecord(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('sourceName: $sourceName, ')
          ..write('price: $price, ')
          ..write('observedAt: $observedAt, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('isInStock: $isInStock, ')
          ..write('volumeMl: $volumeMl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(createdAt, updatedAt, id, wineId, sourceName,
      price, observedAt, url, note, isInStock, volumeMl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceObservationRecord &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.id == this.id &&
          other.wineId == this.wineId &&
          other.sourceName == this.sourceName &&
          other.price == this.price &&
          other.observedAt == this.observedAt &&
          other.url == this.url &&
          other.note == this.note &&
          other.isInStock == this.isInStock &&
          other.volumeMl == this.volumeMl);
}

class PriceObservationRecordsCompanion
    extends UpdateCompanion<PriceObservationRecord> {
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> id;
  final Value<String> wineId;
  final Value<String> sourceName;
  final Value<int> price;
  final Value<DateTime> observedAt;
  final Value<String?> url;
  final Value<String?> note;
  final Value<bool?> isInStock;
  final Value<int?> volumeMl;
  final Value<int> rowid;
  const PriceObservationRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.wineId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.price = const Value.absent(),
    this.observedAt = const Value.absent(),
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.isInStock = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceObservationRecordsCompanion.insert({
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    required String id,
    required String wineId,
    required String sourceName,
    required int price,
    required DateTime observedAt,
    this.url = const Value.absent(),
    this.note = const Value.absent(),
    this.isInStock = const Value.absent(),
    this.volumeMl = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : createdAt = Value(createdAt),
        id = Value(id),
        wineId = Value(wineId),
        sourceName = Value(sourceName),
        price = Value(price),
        observedAt = Value(observedAt);
  static Insertable<PriceObservationRecord> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? id,
    Expression<String>? wineId,
    Expression<String>? sourceName,
    Expression<int>? price,
    Expression<DateTime>? observedAt,
    Expression<String>? url,
    Expression<String>? note,
    Expression<bool>? isInStock,
    Expression<int>? volumeMl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (id != null) 'id': id,
      if (wineId != null) 'wine_id': wineId,
      if (sourceName != null) 'source_name': sourceName,
      if (price != null) 'price': price,
      if (observedAt != null) 'observed_at': observedAt,
      if (url != null) 'url': url,
      if (note != null) 'note': note,
      if (isInStock != null) 'is_in_stock': isInStock,
      if (volumeMl != null) 'volume_ml': volumeMl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceObservationRecordsCompanion copyWith(
      {Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String>? id,
      Value<String>? wineId,
      Value<String>? sourceName,
      Value<int>? price,
      Value<DateTime>? observedAt,
      Value<String?>? url,
      Value<String?>? note,
      Value<bool?>? isInStock,
      Value<int?>? volumeMl,
      Value<int>? rowid}) {
    return PriceObservationRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      sourceName: sourceName ?? this.sourceName,
      price: price ?? this.price,
      observedAt: observedAt ?? this.observedAt,
      url: url ?? this.url,
      note: note ?? this.note,
      isInStock: isInStock ?? this.isInStock,
      volumeMl: volumeMl ?? this.volumeMl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
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
    if (volumeMl.present) {
      map['volume_ml'] = Variable<int>(volumeMl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceObservationRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('id: $id, ')
          ..write('wineId: $wineId, ')
          ..write('sourceName: $sourceName, ')
          ..write('price: $price, ')
          ..write('observedAt: $observedAt, ')
          ..write('url: $url, ')
          ..write('note: $note, ')
          ..write('isInStock: $isInStock, ')
          ..write('volumeMl: $volumeMl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingImageDeletionsTable extends PendingImageDeletions
    with TableInfo<$PendingImageDeletionsTable, PendingImageDeletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingImageDeletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requestedAtMeta =
      const VerificationMeta('requestedAt');
  @override
  late final GeneratedColumn<DateTime> requestedAt = GeneratedColumn<DateTime>(
      'requested_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [path, requestedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_image_deletions';
  @override
  VerificationContext validateIntegrity(
      Insertable<PendingImageDeletion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('requested_at')) {
      context.handle(
          _requestedAtMeta,
          requestedAt.isAcceptableOrUnknown(
              data['requested_at']!, _requestedAtMeta));
    } else if (isInserting) {
      context.missing(_requestedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  PendingImageDeletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingImageDeletion(
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      requestedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}requested_at'])!,
    );
  }

  @override
  $PendingImageDeletionsTable createAlias(String alias) {
    return $PendingImageDeletionsTable(attachedDatabase, alias);
  }
}

class PendingImageDeletion extends DataClass
    implements Insertable<PendingImageDeletion> {
  final String path;
  final DateTime requestedAt;
  const PendingImageDeletion({required this.path, required this.requestedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['path'] = Variable<String>(path);
    map['requested_at'] = Variable<DateTime>(requestedAt);
    return map;
  }

  PendingImageDeletionsCompanion toCompanion(bool nullToAbsent) {
    return PendingImageDeletionsCompanion(
      path: Value(path),
      requestedAt: Value(requestedAt),
    );
  }

  factory PendingImageDeletion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingImageDeletion(
      path: serializer.fromJson<String>(json['path']),
      requestedAt: serializer.fromJson<DateTime>(json['requestedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
      'requestedAt': serializer.toJson<DateTime>(requestedAt),
    };
  }

  PendingImageDeletion copyWith({String? path, DateTime? requestedAt}) =>
      PendingImageDeletion(
        path: path ?? this.path,
        requestedAt: requestedAt ?? this.requestedAt,
      );
  PendingImageDeletion copyWithCompanion(PendingImageDeletionsCompanion data) {
    return PendingImageDeletion(
      path: data.path.present ? data.path.value : this.path,
      requestedAt:
          data.requestedAt.present ? data.requestedAt.value : this.requestedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingImageDeletion(')
          ..write('path: $path, ')
          ..write('requestedAt: $requestedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(path, requestedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingImageDeletion &&
          other.path == this.path &&
          other.requestedAt == this.requestedAt);
}

class PendingImageDeletionsCompanion
    extends UpdateCompanion<PendingImageDeletion> {
  final Value<String> path;
  final Value<DateTime> requestedAt;
  final Value<int> rowid;
  const PendingImageDeletionsCompanion({
    this.path = const Value.absent(),
    this.requestedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingImageDeletionsCompanion.insert({
    required String path,
    required DateTime requestedAt,
    this.rowid = const Value.absent(),
  })  : path = Value(path),
        requestedAt = Value(requestedAt);
  static Insertable<PendingImageDeletion> custom({
    Expression<String>? path,
    Expression<DateTime>? requestedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
      if (requestedAt != null) 'requested_at': requestedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingImageDeletionsCompanion copyWith(
      {Value<String>? path, Value<DateTime>? requestedAt, Value<int>? rowid}) {
    return PendingImageDeletionsCompanion(
      path: path ?? this.path,
      requestedAt: requestedAt ?? this.requestedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (requestedAt.present) {
      map['requested_at'] = Variable<DateTime>(requestedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingImageDeletionsCompanion(')
          ..write('path: $path, ')
          ..write('requestedAt: $requestedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WineRecordsTable wineRecords = $WineRecordsTable(this);
  late final $PurchaseRecordsTable purchaseRecords =
      $PurchaseRecordsTable(this);
  late final $BottleRecordsTable bottleRecords = $BottleRecordsTable(this);
  late final $TastingNoteRecordsTable tastingNoteRecords =
      $TastingNoteRecordsTable(this);
  late final $PriceObservationRecordsTable priceObservationRecords =
      $PriceObservationRecordsTable(this);
  late final $PendingImageDeletionsTable pendingImageDeletions =
      $PendingImageDeletionsTable(this);
  late final Index purchaseWineIdx = Index('purchase_wine_idx',
      'CREATE INDEX purchase_wine_idx ON purchase_records (wine_id)');
  late final Index bottleWineIdx = Index('bottle_wine_idx',
      'CREATE INDEX bottle_wine_idx ON bottle_records (wine_id)');
  late final Index bottlePurchaseIdx = Index('bottle_purchase_idx',
      'CREATE INDEX bottle_purchase_idx ON bottle_records (purchase_id)');
  late final Index noteWineIdx = Index('note_wine_idx',
      'CREATE INDEX note_wine_idx ON tasting_note_records (wine_id)');
  late final Index noteBottleIdx = Index('note_bottle_idx',
      'CREATE INDEX note_bottle_idx ON tasting_note_records (bottle_id)');
  late final Index priceWineIdx = Index('price_wine_idx',
      'CREATE INDEX price_wine_idx ON price_observation_records (wine_id)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        wineRecords,
        purchaseRecords,
        bottleRecords,
        tastingNoteRecords,
        priceObservationRecords,
        pendingImageDeletions,
        purchaseWineIdx,
        bottleWineIdx,
        bottlePurchaseIdx,
        noteWineIdx,
        noteBottleIdx,
        priceWineIdx
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('purchase_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('bottle_records', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('bottle_records',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('tasting_note_records', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}

typedef $$WineRecordsTableCreateCompanionBuilder = WineRecordsCompanion
    Function({
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  required String id,
  Value<String?> name,
  Value<String?> producer,
  Value<String?> country,
  Value<String?> region,
  Value<int?> vintage,
  Value<String> vintageKind,
  Value<String?> type,
  Value<String> grapeVarietiesJson,
  Value<String?> imagePath,
  Value<bool> isWishlisted,
  Value<bool> isArchived,
  Value<int> rowid,
});
typedef $$WineRecordsTableUpdateCompanionBuilder = WineRecordsCompanion
    Function({
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String> id,
  Value<String?> name,
  Value<String?> producer,
  Value<String?> country,
  Value<String?> region,
  Value<int?> vintage,
  Value<String> vintageKind,
  Value<String?> type,
  Value<String> grapeVarietiesJson,
  Value<String?> imagePath,
  Value<bool> isWishlisted,
  Value<bool> isArchived,
  Value<int> rowid,
});

final class $$WineRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $WineRecordsTable, WineRecord> {
  $$WineRecordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PurchaseRecordsTable, List<PurchaseRecord>>
      _purchaseRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.purchaseRecords,
              aliasName: $_aliasNameGenerator(
                  db.wineRecords.id, db.purchaseRecords.wineId));

  $$PurchaseRecordsTableProcessedTableManager get purchaseRecordsRefs {
    final manager =
        $$PurchaseRecordsTableTableManager($_db, $_db.purchaseRecords)
            .filter((f) => f.wineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_purchaseRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

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
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<String> get vintageKind => $composableBuilder(
      column: $table.vintageKind, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isWishlisted => $composableBuilder(
      column: $table.isWishlisted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  Expression<bool> purchaseRecordsRefs(
      Expression<bool> Function($$PurchaseRecordsTableFilterComposer f) f) {
    final $$PurchaseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRecords,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.purchaseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

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
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<String> get vintageKind => $composableBuilder(
      column: $table.vintageKind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isWishlisted => $composableBuilder(
      column: $table.isWishlisted,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

  GeneratedColumn<String> get vintageKind => $composableBuilder(
      column: $table.vintageKind, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get grapeVarietiesJson => $composableBuilder(
      column: $table.grapeVarietiesJson, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<bool> get isWishlisted => $composableBuilder(
      column: $table.isWishlisted, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  Expression<T> purchaseRecordsRefs<T extends Object>(
      Expression<T> Function($$PurchaseRecordsTableAnnotationComposer a) f) {
    final $$PurchaseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRecords,
        getReferencedColumn: (t) => t.wineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.purchaseRecords,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

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
        {bool purchaseRecordsRefs,
        bool bottleRecordsRefs,
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> producer = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<String> vintageKind = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String> grapeVarietiesJson = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isWishlisted = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WineRecordsCompanion(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            name: name,
            producer: producer,
            country: country,
            region: region,
            vintage: vintage,
            vintageKind: vintageKind,
            type: type,
            grapeVarietiesJson: grapeVarietiesJson,
            imagePath: imagePath,
            isWishlisted: isWishlisted,
            isArchived: isArchived,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            required String id,
            Value<String?> name = const Value.absent(),
            Value<String?> producer = const Value.absent(),
            Value<String?> country = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<int?> vintage = const Value.absent(),
            Value<String> vintageKind = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String> grapeVarietiesJson = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<bool> isWishlisted = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WineRecordsCompanion.insert(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            name: name,
            producer: producer,
            country: country,
            region: region,
            vintage: vintage,
            vintageKind: vintageKind,
            type: type,
            grapeVarietiesJson: grapeVarietiesJson,
            imagePath: imagePath,
            isWishlisted: isWishlisted,
            isArchived: isArchived,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WineRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {purchaseRecordsRefs = false,
              bottleRecordsRefs = false,
              tastingNoteRecordsRefs = false,
              priceObservationRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (purchaseRecordsRefs) db.purchaseRecords,
                if (bottleRecordsRefs) db.bottleRecords,
                if (tastingNoteRecordsRefs) db.tastingNoteRecords,
                if (priceObservationRecordsRefs) db.priceObservationRecords
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseRecordsRefs)
                    await $_getPrefetchedData<WineRecord, $WineRecordsTable,
                            PurchaseRecord>(
                        currentTable: table,
                        referencedTable: $$WineRecordsTableReferences
                            ._purchaseRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WineRecordsTableReferences(db, table, p0)
                                .purchaseRecordsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.wineId == item.id),
                        typedResults: items),
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
        {bool purchaseRecordsRefs,
        bool bottleRecordsRefs,
        bool tastingNoteRecordsRefs,
        bool priceObservationRecordsRefs})>;
typedef $$PurchaseRecordsTableCreateCompanionBuilder = PurchaseRecordsCompanion
    Function({
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  required String id,
  required String wineId,
  Value<DateTime?> purchaseDate,
  Value<String?> shopName,
  required int purchasedQuantity,
  Value<int?> totalPaidKrw,
  Value<int?> volumeMl,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$PurchaseRecordsTableUpdateCompanionBuilder = PurchaseRecordsCompanion
    Function({
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String> id,
  Value<String> wineId,
  Value<DateTime?> purchaseDate,
  Value<String?> shopName,
  Value<int> purchasedQuantity,
  Value<int?> totalPaidKrw,
  Value<int?> volumeMl,
  Value<String?> note,
  Value<int> rowid,
});

final class $$PurchaseRecordsTableReferences extends BaseReferences<
    _$AppDatabase, $PurchaseRecordsTable, PurchaseRecord> {
  $$PurchaseRecordsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WineRecordsTable _wineIdTable(_$AppDatabase db) =>
      db.wineRecords.createAlias(
          $_aliasNameGenerator(db.purchaseRecords.wineId, db.wineRecords.id));

  $$WineRecordsTableProcessedTableManager get wineId {
    final $_column = $_itemColumn<String>('wine_id')!;

    final manager = $$WineRecordsTableTableManager($_db, $_db.wineRecords)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$BottleRecordsTable, List<BottleRecord>>
      _bottleRecordsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.bottleRecords,
              aliasName: $_aliasNameGenerator(
                  db.purchaseRecords.id, db.bottleRecords.purchaseId));

  $$BottleRecordsTableProcessedTableManager get bottleRecordsRefs {
    final manager = $$BottleRecordsTableTableManager($_db, $_db.bottleRecords)
        .filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bottleRecordsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PurchaseRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseRecordsTable> {
  $$PurchaseRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get purchasedQuantity => $composableBuilder(
      column: $table.purchasedQuantity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalPaidKrw => $composableBuilder(
      column: $table.totalPaidKrw, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

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

  Expression<bool> bottleRecordsRefs(
      Expression<bool> Function($$BottleRecordsTableFilterComposer f) f) {
    final $$BottleRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.purchaseId,
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
}

class $$PurchaseRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseRecordsTable> {
  $$PurchaseRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shopName => $composableBuilder(
      column: $table.shopName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get purchasedQuantity => $composableBuilder(
      column: $table.purchasedQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalPaidKrw => $composableBuilder(
      column: $table.totalPaidKrw,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

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

class $$PurchaseRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseRecordsTable> {
  $$PurchaseRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
      column: $table.purchaseDate, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<int> get purchasedQuantity => $composableBuilder(
      column: $table.purchasedQuantity, builder: (column) => column);

  GeneratedColumn<int> get totalPaidKrw => $composableBuilder(
      column: $table.totalPaidKrw, builder: (column) => column);

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

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

  Expression<T> bottleRecordsRefs<T extends Object>(
      Expression<T> Function($$BottleRecordsTableAnnotationComposer a) f) {
    final $$BottleRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.bottleRecords,
        getReferencedColumn: (t) => t.purchaseId,
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
}

class $$PurchaseRecordsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PurchaseRecordsTable,
    PurchaseRecord,
    $$PurchaseRecordsTableFilterComposer,
    $$PurchaseRecordsTableOrderingComposer,
    $$PurchaseRecordsTableAnnotationComposer,
    $$PurchaseRecordsTableCreateCompanionBuilder,
    $$PurchaseRecordsTableUpdateCompanionBuilder,
    (PurchaseRecord, $$PurchaseRecordsTableReferences),
    PurchaseRecord,
    PrefetchHooks Function({bool wineId, bool bottleRecordsRefs})> {
  $$PurchaseRecordsTableTableManager(
      _$AppDatabase db, $PurchaseRecordsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<String?> shopName = const Value.absent(),
            Value<int> purchasedQuantity = const Value.absent(),
            Value<int?> totalPaidKrw = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseRecordsCompanion(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            purchaseDate: purchaseDate,
            shopName: shopName,
            purchasedQuantity: purchasedQuantity,
            totalPaidKrw: totalPaidKrw,
            volumeMl: volumeMl,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            required String id,
            required String wineId,
            Value<DateTime?> purchaseDate = const Value.absent(),
            Value<String?> shopName = const Value.absent(),
            required int purchasedQuantity,
            Value<int?> totalPaidKrw = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseRecordsCompanion.insert(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            purchaseDate: purchaseDate,
            shopName: shopName,
            purchasedQuantity: purchasedQuantity,
            totalPaidKrw: totalPaidKrw,
            volumeMl: volumeMl,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PurchaseRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wineId = false, bottleRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bottleRecordsRefs) db.bottleRecords
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
                        $$PurchaseRecordsTableReferences._wineIdTable(db),
                    referencedColumn:
                        $$PurchaseRecordsTableReferences._wineIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bottleRecordsRefs)
                    await $_getPrefetchedData<PurchaseRecord,
                            $PurchaseRecordsTable, BottleRecord>(
                        currentTable: table,
                        referencedTable: $$PurchaseRecordsTableReferences
                            ._bottleRecordsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PurchaseRecordsTableReferences(db, table, p0)
                                .bottleRecordsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.purchaseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PurchaseRecordsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PurchaseRecordsTable,
    PurchaseRecord,
    $$PurchaseRecordsTableFilterComposer,
    $$PurchaseRecordsTableOrderingComposer,
    $$PurchaseRecordsTableAnnotationComposer,
    $$PurchaseRecordsTableCreateCompanionBuilder,
    $$PurchaseRecordsTableUpdateCompanionBuilder,
    (PurchaseRecord, $$PurchaseRecordsTableReferences),
    PurchaseRecord,
    PrefetchHooks Function({bool wineId, bool bottleRecordsRefs})>;
typedef $$BottleRecordsTableCreateCompanionBuilder = BottleRecordsCompanion
    Function({
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  required String id,
  required String wineId,
  Value<String?> purchaseId,
  Value<String> acquisitionKind,
  Value<DateTime?> acquiredAt,
  Value<int?> volumeMl,
  Value<String> status,
  Value<DateTime?> statusChangedAt,
  Value<String?> imagePath,
  Value<String?> storageLocation,
  Value<int> rowid,
});
typedef $$BottleRecordsTableUpdateCompanionBuilder = BottleRecordsCompanion
    Function({
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String> id,
  Value<String> wineId,
  Value<String?> purchaseId,
  Value<String> acquisitionKind,
  Value<DateTime?> acquiredAt,
  Value<int?> volumeMl,
  Value<String> status,
  Value<DateTime?> statusChangedAt,
  Value<String?> imagePath,
  Value<String?> storageLocation,
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

  static $PurchaseRecordsTable _purchaseIdTable(_$AppDatabase db) =>
      db.purchaseRecords.createAlias($_aliasNameGenerator(
          db.bottleRecords.purchaseId, db.purchaseRecords.id));

  $$PurchaseRecordsTableProcessedTableManager? get purchaseId {
    final $_column = $_itemColumn<String>('purchase_id');
    if ($_column == null) return null;
    final manager =
        $$PurchaseRecordsTableTableManager($_db, $_db.purchaseRecords)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
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
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get acquisitionKind => $composableBuilder(
      column: $table.acquisitionKind,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get statusChangedAt => $composableBuilder(
      column: $table.statusChangedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnFilters(column));

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

  $$PurchaseRecordsTableFilterComposer get purchaseId {
    final $$PurchaseRecordsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.purchaseId,
        referencedTable: $db.purchaseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRecordsTableFilterComposer(
              $db: $db,
              $table: $db.purchaseRecords,
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
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get acquisitionKind => $composableBuilder(
      column: $table.acquisitionKind,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get statusChangedAt => $composableBuilder(
      column: $table.statusChangedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation,
      builder: (column) => ColumnOrderings(column));

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

  $$PurchaseRecordsTableOrderingComposer get purchaseId {
    final $$PurchaseRecordsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.purchaseId,
        referencedTable: $db.purchaseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRecordsTableOrderingComposer(
              $db: $db,
              $table: $db.purchaseRecords,
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
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get acquisitionKind => $composableBuilder(
      column: $table.acquisitionKind, builder: (column) => column);

  GeneratedColumn<DateTime> get acquiredAt => $composableBuilder(
      column: $table.acquiredAt, builder: (column) => column);

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get statusChangedAt => $composableBuilder(
      column: $table.statusChangedAt, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get storageLocation => $composableBuilder(
      column: $table.storageLocation, builder: (column) => column);

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

  $$PurchaseRecordsTableAnnotationComposer get purchaseId {
    final $$PurchaseRecordsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.purchaseId,
        referencedTable: $db.purchaseRecords,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRecordsTableAnnotationComposer(
              $db: $db,
              $table: $db.purchaseRecords,
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
    PrefetchHooks Function(
        {bool wineId, bool purchaseId, bool tastingNoteRecordsRefs})> {
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String?> purchaseId = const Value.absent(),
            Value<String> acquisitionKind = const Value.absent(),
            Value<DateTime?> acquiredAt = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> statusChangedAt = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BottleRecordsCompanion(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            purchaseId: purchaseId,
            acquisitionKind: acquisitionKind,
            acquiredAt: acquiredAt,
            volumeMl: volumeMl,
            status: status,
            statusChangedAt: statusChangedAt,
            imagePath: imagePath,
            storageLocation: storageLocation,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            required String id,
            required String wineId,
            Value<String?> purchaseId = const Value.absent(),
            Value<String> acquisitionKind = const Value.absent(),
            Value<DateTime?> acquiredAt = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> statusChangedAt = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> storageLocation = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BottleRecordsCompanion.insert(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            purchaseId: purchaseId,
            acquisitionKind: acquisitionKind,
            acquiredAt: acquiredAt,
            volumeMl: volumeMl,
            status: status,
            statusChangedAt: statusChangedAt,
            imagePath: imagePath,
            storageLocation: storageLocation,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BottleRecordsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {wineId = false,
              purchaseId = false,
              tastingNoteRecordsRefs = false}) {
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
                if (purchaseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.purchaseId,
                    referencedTable:
                        $$BottleRecordsTableReferences._purchaseIdTable(db),
                    referencedColumn:
                        $$BottleRecordsTableReferences._purchaseIdTable(db).id,
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
    PrefetchHooks Function(
        {bool wineId, bool purchaseId, bool tastingNoteRecordsRefs})>;
typedef $$TastingNoteRecordsTableCreateCompanionBuilder
    = TastingNoteRecordsCompanion Function({
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  required String id,
  required String wineId,
  Value<String?> bottleId,
  Value<DateTime?> tastedAt,
  Value<double?> rating,
  Value<String?> imagePath,
  Value<String?> aroma,
  Value<String?> palate,
  Value<String?> pairing,
  Value<int?> acidity,
  Value<int?> tannin,
  Value<int?> body,
  Value<int?> sweetness,
  Value<String?> memo,
  Value<String?> buyAgain,
  Value<int> rowid,
});
typedef $$TastingNoteRecordsTableUpdateCompanionBuilder
    = TastingNoteRecordsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String> id,
  Value<String> wineId,
  Value<String?> bottleId,
  Value<DateTime?> tastedAt,
  Value<double?> rating,
  Value<String?> imagePath,
  Value<String?> aroma,
  Value<String?> palate,
  Value<String?> pairing,
  Value<int?> acidity,
  Value<int?> tannin,
  Value<int?> body,
  Value<int?> sweetness,
  Value<String?> memo,
  Value<String?> buyAgain,
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
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<String> get buyAgain => $composableBuilder(
      column: $table.buyAgain, builder: (column) => ColumnFilters(column));

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
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<String> get buyAgain => $composableBuilder(
      column: $table.buyAgain, builder: (column) => ColumnOrderings(column));

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
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

  GeneratedColumn<String> get buyAgain =>
      $composableBuilder(column: $table.buyAgain, builder: (column) => column);

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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String?> bottleId = const Value.absent(),
            Value<DateTime?> tastedAt = const Value.absent(),
            Value<double?> rating = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> aroma = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> pairing = const Value.absent(),
            Value<int?> acidity = const Value.absent(),
            Value<int?> tannin = const Value.absent(),
            Value<int?> body = const Value.absent(),
            Value<int?> sweetness = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<String?> buyAgain = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNoteRecordsCompanion(
            createdAt: createdAt,
            updatedAt: updatedAt,
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
            buyAgain: buyAgain,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            required String id,
            required String wineId,
            Value<String?> bottleId = const Value.absent(),
            Value<DateTime?> tastedAt = const Value.absent(),
            Value<double?> rating = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> aroma = const Value.absent(),
            Value<String?> palate = const Value.absent(),
            Value<String?> pairing = const Value.absent(),
            Value<int?> acidity = const Value.absent(),
            Value<int?> tannin = const Value.absent(),
            Value<int?> body = const Value.absent(),
            Value<int?> sweetness = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<String?> buyAgain = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TastingNoteRecordsCompanion.insert(
            createdAt: createdAt,
            updatedAt: updatedAt,
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
            buyAgain: buyAgain,
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
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  required String id,
  required String wineId,
  required String sourceName,
  required int price,
  required DateTime observedAt,
  Value<String?> url,
  Value<String?> note,
  Value<bool?> isInStock,
  Value<int?> volumeMl,
  Value<int> rowid,
});
typedef $$PriceObservationRecordsTableUpdateCompanionBuilder
    = PriceObservationRecordsCompanion Function({
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String> id,
  Value<String> wineId,
  Value<String> sourceName,
  Value<int> price,
  Value<DateTime> observedAt,
  Value<String?> url,
  Value<String?> note,
  Value<bool?> isInStock,
  Value<int?> volumeMl,
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
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

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

  ColumnFilters<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnFilters(column));

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
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

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

  ColumnOrderings<int> get volumeMl => $composableBuilder(
      column: $table.volumeMl, builder: (column) => ColumnOrderings(column));

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
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

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

  GeneratedColumn<int> get volumeMl =>
      $composableBuilder(column: $table.volumeMl, builder: (column) => column);

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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String> id = const Value.absent(),
            Value<String> wineId = const Value.absent(),
            Value<String> sourceName = const Value.absent(),
            Value<int> price = const Value.absent(),
            Value<DateTime> observedAt = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool?> isInStock = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceObservationRecordsCompanion(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            sourceName: sourceName,
            price: price,
            observedAt: observedAt,
            url: url,
            note: note,
            isInStock: isInStock,
            volumeMl: volumeMl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            required String id,
            required String wineId,
            required String sourceName,
            required int price,
            required DateTime observedAt,
            Value<String?> url = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool?> isInStock = const Value.absent(),
            Value<int?> volumeMl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PriceObservationRecordsCompanion.insert(
            createdAt: createdAt,
            updatedAt: updatedAt,
            id: id,
            wineId: wineId,
            sourceName: sourceName,
            price: price,
            observedAt: observedAt,
            url: url,
            note: note,
            isInStock: isInStock,
            volumeMl: volumeMl,
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
typedef $$PendingImageDeletionsTableCreateCompanionBuilder
    = PendingImageDeletionsCompanion Function({
  required String path,
  required DateTime requestedAt,
  Value<int> rowid,
});
typedef $$PendingImageDeletionsTableUpdateCompanionBuilder
    = PendingImageDeletionsCompanion Function({
  Value<String> path,
  Value<DateTime> requestedAt,
  Value<int> rowid,
});

class $$PendingImageDeletionsTableFilterComposer
    extends Composer<_$AppDatabase, $PendingImageDeletionsTable> {
  $$PendingImageDeletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => ColumnFilters(column));
}

class $$PendingImageDeletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingImageDeletionsTable> {
  $$PendingImageDeletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => ColumnOrderings(column));
}

class $$PendingImageDeletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingImageDeletionsTable> {
  $$PendingImageDeletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedAt => $composableBuilder(
      column: $table.requestedAt, builder: (column) => column);
}

class $$PendingImageDeletionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PendingImageDeletionsTable,
    PendingImageDeletion,
    $$PendingImageDeletionsTableFilterComposer,
    $$PendingImageDeletionsTableOrderingComposer,
    $$PendingImageDeletionsTableAnnotationComposer,
    $$PendingImageDeletionsTableCreateCompanionBuilder,
    $$PendingImageDeletionsTableUpdateCompanionBuilder,
    (
      PendingImageDeletion,
      BaseReferences<_$AppDatabase, $PendingImageDeletionsTable,
          PendingImageDeletion>
    ),
    PendingImageDeletion,
    PrefetchHooks Function()> {
  $$PendingImageDeletionsTableTableManager(
      _$AppDatabase db, $PendingImageDeletionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingImageDeletionsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingImageDeletionsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingImageDeletionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> path = const Value.absent(),
            Value<DateTime> requestedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PendingImageDeletionsCompanion(
            path: path,
            requestedAt: requestedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String path,
            required DateTime requestedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PendingImageDeletionsCompanion.insert(
            path: path,
            requestedAt: requestedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PendingImageDeletionsTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $PendingImageDeletionsTable,
        PendingImageDeletion,
        $$PendingImageDeletionsTableFilterComposer,
        $$PendingImageDeletionsTableOrderingComposer,
        $$PendingImageDeletionsTableAnnotationComposer,
        $$PendingImageDeletionsTableCreateCompanionBuilder,
        $$PendingImageDeletionsTableUpdateCompanionBuilder,
        (
          PendingImageDeletion,
          BaseReferences<_$AppDatabase, $PendingImageDeletionsTable,
              PendingImageDeletion>
        ),
        PendingImageDeletion,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WineRecordsTableTableManager get wineRecords =>
      $$WineRecordsTableTableManager(_db, _db.wineRecords);
  $$PurchaseRecordsTableTableManager get purchaseRecords =>
      $$PurchaseRecordsTableTableManager(_db, _db.purchaseRecords);
  $$BottleRecordsTableTableManager get bottleRecords =>
      $$BottleRecordsTableTableManager(_db, _db.bottleRecords);
  $$TastingNoteRecordsTableTableManager get tastingNoteRecords =>
      $$TastingNoteRecordsTableTableManager(_db, _db.tastingNoteRecords);
  $$PriceObservationRecordsTableTableManager get priceObservationRecords =>
      $$PriceObservationRecordsTableTableManager(
          _db, _db.priceObservationRecords);
  $$PendingImageDeletionsTableTableManager get pendingImageDeletions =>
      $$PendingImageDeletionsTableTableManager(_db, _db.pendingImageDeletions);
}
