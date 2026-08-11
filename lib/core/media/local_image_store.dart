import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract interface class ImageStore {
  Future<String> copyIntoAppStorage(
    String sourcePath, {
    required String prefix,
  });

  Future<void> deleteManagedFile(String? filePath);
}

class LocalImageStore implements ImageStore {
  LocalImageStore({
    Uuid uuid = const Uuid(),
    Future<Directory> Function()? documentsDirectory,
  })  : _uuid = uuid,
        _documentsDirectory =
            documentsDirectory ?? getApplicationDocumentsDirectory;

  final Uuid _uuid;
  final Future<Directory> Function() _documentsDirectory;

  @override
  Future<String> copyIntoAppStorage(
    String sourcePath, {
    required String prefix,
  }) async {
    final documents = await _documentsDirectory();
    final imageDir = Directory(p.join(documents.path, 'images'));
    await imageDir.create(recursive: true);

    final extension = _safeExtension(sourcePath);
    final destinationPath = p.join(
      imageDir.path,
      '$prefix-${_uuid.v4()}$extension',
    );

    final copied = await File(sourcePath).copy(destinationPath);
    return copied.path;
  }

  @override
  Future<void> deleteManagedFile(String? filePath) async {
    if (filePath == null || filePath.trim().isEmpty) {
      return;
    }

    final documents = await _documentsDirectory();
    final imageRoot = p.normalize(p.absolute(p.join(documents.path, 'images')));
    final candidate = p.normalize(p.absolute(filePath));

    if (!p.isWithin(imageRoot, candidate)) {
      return;
    }

    final file = File(candidate);
    if (await file.exists()) {
      await file.delete();
    }
  }

  String _safeExtension(String sourcePath) {
    final extension = p.extension(sourcePath).toLowerCase();
    if (extension == '.jpg' ||
        extension == '.jpeg' ||
        extension == '.png' ||
        extension == '.heic' ||
        extension == '.webp') {
      return extension;
    }

    return '.jpg';
  }
}
