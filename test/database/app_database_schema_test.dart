import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.inMemory();
  });

  tearDown(() async {
    await database.close();
  });

  test('fresh database matches the generated Drift schema', () async {
    await database.validateDatabaseSchema();

    final version =
        await database.customSelect('PRAGMA user_version').getSingle();
    expect(version.read<int>('user_version'), database.schemaVersion);
  });

  test('foreign-key enforcement is enabled when the database opens', () async {
    final result =
        await database.customSelect('PRAGMA foreign_keys').getSingle();

    expect(result.read<int>('foreign_keys'), 1);
  });
}
