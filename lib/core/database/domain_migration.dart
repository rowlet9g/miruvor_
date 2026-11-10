part of 'app_database.dart';

extension _DomainMigration on AppDatabase {
  Future<void> _upgrade(Migrator m, int from, int to) async {
    if (from != 1 || to != 2) throw StateError('지원하지 않는 데이터 버전: $from → $to');
    String? recoveryPath;
    try {
      final databases = await customSelect('PRAGMA database_list').get();
      final file = databases
          .firstWhere((r) => r.read<String>('name') == 'main')
          .read<String>('file');
      if (file.isNotEmpty) {
        recoveryPath =
            '$file.v1-backup-${DateTime.now().microsecondsSinceEpoch}.sqlite';
        // VACUUM INTO creates a consistent SQLite snapshot, including WAL data.
        // It must run outside the migration transaction.
        await customStatement('VACUUM INTO ?', [recoveryPath]);
      }
      await customStatement('PRAGMA foreign_keys = OFF');
      await transaction(() async {
        await _validateV1();
        await m.runMigrationSteps(
            from: from, to: to, steps: migrationSteps(from1To2: _migrateV1));
        final violations = await customSelect('PRAGMA foreign_key_check').get();
        if (violations.isNotEmpty) throw StateError('이전 후 외래 키 불일치');
        await _installDomainConstraints();
      });
    } catch (error) {
      throw StateError('데이터 이전을 중단했습니다. 기존 기록은 유지됩니다.'
          '${recoveryPath == null ? '' : ' 복구 사본: $recoveryPath'} 원인: $error');
    } finally {
      await customStatement('PRAGMA foreign_keys = ON');
    }
  }

  Future<void> _validateV1() async {
    final foreignKeys = await customSelect('PRAGMA foreign_key_check').get();
    if (foreignKeys.isNotEmpty) {
      throw StateError('기존 외래 키 불일치: ${foreignKeys.first.data}');
    }
    final checks = <String, String>{
      '와인 이름 또는 종류': """SELECT id FROM wine_records
        WHERE length(trim(name)) = 0 OR type NOT IN ('red','white','rose','sparkling','fortified','dessert','other')""",
      '구매 금액': 'SELECT id FROM bottle_records WHERE purchase_price < 0',
      '참고 가격': 'SELECT id FROM price_observation_records WHERE price < 0',
      '시음 평점':
          'SELECT id FROM tasting_note_records WHERE rating < 0 OR rating > 5',
      '시음 세부 평가': '''SELECT id FROM tasting_note_records
        WHERE acidity NOT BETWEEN 1 AND 5 OR tannin NOT BETWEEN 1 AND 5
        OR body NOT BETWEEN 1 AND 5 OR sweetness NOT BETWEEN 1 AND 5''',
      '시음과 병의 와인': '''SELECT n.id FROM tasting_note_records n
        JOIN bottle_records b ON n.bottle_id = b.id WHERE n.wine_id <> b.wine_id''',
    };
    for (final check in checks.entries) {
      final rows = await customSelect(check.value).get();
      if (rows.isNotEmpty) {
        throw StateError(
            '${check.key} 정정 필요: ${rows.first.read<String>('id')}');
      }
    }
    for (final row in await customSelect(
            'SELECT id, grape_varieties_json FROM wine_records')
        .get()) {
      final value = jsonDecode(row.read<String>('grape_varieties_json'));
      if (value is! List || value.any((v) => v is! String)) {
        throw StateError('품종 목록 정정 필요: ${row.read<String>('id')}');
      }
    }
  }

  Future<void> _migrateV1(Migrator m, Schema2 schema) async {
    final wineRecords = schema.wineRecords;
    final purchaseRecords = schema.purchaseRecords;
    final bottleRecords = schema.bottleRecords;
    final tastingNoteRecords = schema.tastingNoteRecords;
    final priceObservationRecords = schema.priceObservationRecords;
    await m.alterTable(TableMigration(wineRecords, newColumns: [
      wineRecords.vintageKind,
      wineRecords.imagePath,
      wineRecords.isWishlisted,
      wineRecords.isArchived
    ], columnTransformer: {
      wineRecords.name: const CustomExpression("NULLIF(name, '')"),
      wineRecords.producer: const CustomExpression("NULLIF(producer, '')"),
      wineRecords.country: const CustomExpression("NULLIF(country, '')"),
      wineRecords.region: const CustomExpression("NULLIF(region, '')"),
      wineRecords.vintageKind: const CustomExpression(
          "CASE WHEN vintage IS NULL THEN 'unknown' ELSE 'year' END"),
    }));
    await m.createTable(purchaseRecords);
    await customStatement("""
      INSERT INTO purchase_records
        (id, wine_id, purchase_date, shop_name, purchased_quantity, total_paid_krw, created_at, updated_at)
      SELECT 'legacy-purchase:' || id, wine_id, purchase_date, shop_name, 1, purchase_price, created_at, updated_at
      FROM bottle_records
    """);
    await m.alterTable(TableMigration(bottleRecords, newColumns: [
      bottleRecords.purchaseId,
      bottleRecords.acquisitionKind,
      bottleRecords.acquiredAt,
      bottleRecords.volumeMl,
      bottleRecords.status,
      bottleRecords.statusChangedAt
    ], columnTransformer: {
      bottleRecords.purchaseId:
          const CustomExpression("'legacy-purchase:' || id"),
      bottleRecords.acquisitionKind: const Constant('purchase'),
      bottleRecords.status: const CustomExpression(
          "CASE WHEN is_consumed = 1 THEN 'consumed' ELSE 'inStock' END"),
    }));
    await m.alterTable(TableMigration(tastingNoteRecords,
        newColumns: [tastingNoteRecords.buyAgain]));
    await m.alterTable(TableMigration(priceObservationRecords, newColumns: [
      priceObservationRecords.volumeMl,
      priceObservationRecords.updatedAt
    ]));
    await m.createTable(schema.pendingImageDeletions);
    for (final index in schema.entities.whereType<Index>()) {
      await m.createIndex(index);
    }
  }
}
