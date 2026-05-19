import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class LocalImageStore {
  LocalImageStore({Uuid uuid = const Uuid()}) : _uuid = uuid;

  final Uuid _uuid;

  Future<String> copyIntoAppStorage(
    String sourcePath, {
    required String prefix,
  }) async {
    final documents = await getApplicationDocumentsDirectory();
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
