import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:miruvor/core/database/app_database.dart';
import 'package:miruvor/core/media/local_image_store.dart';
import 'package:miruvor/core/models/wine_type.dart';
import 'package:miruvor/core/store/miruvor_store.dart';

void main() {
  group('LocalImageStore', () {
    late Directory testRoot;
    late Directory documents;
    late LocalImageStore imageStore;

    setUp(() async {
      testRoot = await Directory.systemTemp.createTemp('miruvor-images-');
      documents = Directory('${testRoot.path}/documents');
      await documents.create();
      imageStore = LocalImageStore(
        documentsDirectory: () async => documents,
      );
    });

    tearDown(() async {
      if (await testRoot.exists()) {
        await testRoot.delete(recursive: true);
      }
    });

    test('copies and deletes files owned by the managed image directory',
        () async {
      final source = File('${testRoot.path}/source.png');
      await source.writeAsBytes([1, 2, 3]);

      final managedPath = await imageStore.copyIntoAppStorage(
        source.path,
        prefix: 'bottle',
      );
      expect(await File(managedPath).exists(), isTrue);

      await imageStore.deleteManagedFile(managedPath);

      expect(await File(managedPath).exists(), isFalse);
    });

    test('does not delete files outside the managed image directory', () async {
      final outsideFile = File('${testRoot.path}/outside.jpg');
      await outsideFile.writeAsBytes([1, 2, 3]);

      await imageStore.deleteManagedFile(outsideFile.path);

      expect(await outsideFile.exists(), isTrue);
    });
  });

  group('MiruvorStore image lifecycle', () {
    late _RecordingImageStore imageStore;
    late MiruvorStore store;

    setUp(() {
      imageStore = _RecordingImageStore();
      store = MiruvorStore(
        database: AppDatabase.inMemory(),
        imageStore: imageStore,
      );
    });

    tearDown(() {
      store.dispose();
    });

    test('replacing a bottle image deletes the previous image', () async {
      final item = await _addWine(store, imagePath: 'managed/bottle-old.jpg');

      await store.updateWinePurchase(
        wineId: item.wine.id,
        bottleId: item.bottle.id,
        purchaseDate: item.bottle.purchaseDate,
        name: item.wine.name,
        producer: item.wine.producer,
        country: item.wine.country,
        type: item.wine.type,
        purchasePrice: item.bottle.purchasePrice,
        imagePath: 'managed/bottle-new.jpg',
      );

      expect(imageStore.deletedPaths, ['managed/bottle-old.jpg']);
      expect(
        (await store.findBottle(item.bottle.id))?.imagePath,
        'managed/bottle-new.jpg',
      );
    });

    test('deleting a wine deletes its bottle and tasting images', () async {
      final item = await _addWine(store, imagePath: 'managed/bottle.jpg');
      await store.addTastingNote(
        wineId: item.wine.id,
        bottleId: item.bottle.id,
        tastedAt: DateTime(2026, 8, 11),
        rating: 4,
        imagePath: 'managed/tasting.jpg',
      );

      await store.deleteWinePurchase(
        wineId: item.wine.id,
        bottleId: item.bottle.id,
      );

      expect(
        imageStore.deletedPaths,
        containsAll(['managed/bottle.jpg', 'managed/tasting.jpg']),
      );
      expect(await store.findBottle(item.bottle.id), isNull);
      expect(await store.findWine(item.wine.id), isNull);
    });

    test('updating and deleting a tasting note cleans both images', () async {
      final item = await _addWine(store);
      await store.addTastingNote(
        wineId: item.wine.id,
        bottleId: item.bottle.id,
        tastedAt: DateTime(2026, 8, 11),
        rating: 4,
        imagePath: 'managed/note-old.jpg',
      );
      final note = (await store.notesForWine(item.wine.id)).single;

      await store.updateTastingNote(
        id: note.id,
        wineId: note.wineId,
        bottleId: note.bottleId,
        tastedAt: note.tastedAt,
        rating: note.rating,
        imagePath: 'managed/note-new.jpg',
      );
      await store.deleteTastingNote(note.id);

      expect(
        imageStore.deletedPaths,
        ['managed/note-old.jpg', 'managed/note-new.jpg'],
      );
      expect(await store.findTastingNote(note.id), isNull);
    });
  });
}

Future<WineWithBottle> _addWine(
  MiruvorStore store, {
  String? imagePath,
}) async {
  await store.addWinePurchase(
    name: 'Test Wine',
    producer: 'Test Producer',
    country: 'KR',
    type: WineType.red,
    purchaseDate: DateTime(2026, 8, 10),
    purchasePrice: 30000,
    imagePath: imagePath,
  );
  return (await store.database.watchCellarSnapshotOnce()).single;
}

class _RecordingImageStore implements ImageStore {
  final deletedPaths = <String>[];

  @override
  Future<String> copyIntoAppStorage(
    String sourcePath, {
    required String prefix,
  }) async {
    return 'managed/$prefix.jpg';
  }

  @override
  Future<void> deleteManagedFile(String? filePath) async {
    if (filePath != null) {
      deletedPaths.add(filePath);
    }
  }
}
