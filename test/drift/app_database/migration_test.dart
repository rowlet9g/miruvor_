import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/database/app_database.dart';

import 'generated/schema.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  test('latest stored snapshot matches the current database schema', () async {
    final latestVersion = GeneratedHelper.versions.last;
    final connection = await verifier.startAt(latestVersion);
    final database = AppDatabase(connection);

    await verifier.migrateAndValidate(database, database.schemaVersion);
    await database.close();
  });

  group('version-to-version migrations', () {
    const versions = GeneratedHelper.versions;
    for (final (index, fromVersion) in versions.indexed) {
      for (final toVersion in versions.skip(index + 1)) {
        test('migrates from v$fromVersion to v$toVersion', () async {
          final connection = await verifier.startAt(fromVersion);
          final database = AppDatabase(connection);

          await verifier.migrateAndValidate(database, toVersion);
          await database.close();
        });
      }
    }
  });
}
