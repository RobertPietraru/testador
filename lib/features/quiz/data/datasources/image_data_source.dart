// import 'dart:io';

import 'dart:io';

import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ImageDataSource {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String _cacheDirectoryName = 'image_cache';

  Future<String> cacheImage(File image, {String? id}) async {
    final cacheDir = await getApplicationDocumentsDirectory();
    final cachePath = path.join(cacheDir.path, _cacheDirectoryName);

    if (!(await Directory(cachePath).exists())) {
      await Directory(cachePath).create();
    }

    final finalId = id ?? const Uuid().v1();
    final fileName = finalId + path.extension(image.path);
    final cacheFilePath = path.join(cachePath, fileName);

    await image.copy(cacheFilePath);
    return finalId;
  }

  Future<String> uploadImageToDB(
    File image,
  ) async {
    final fileName = path.basename(image.path);
    final storageRef = _storage.ref().child(fileName);
    final uploadTask = storageRef.putFile(image);

    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    return path.basenameWithoutExtension(image.path);
  }

  Future<File?> getImageFromRemoteDB(String id) async {
    try {
      final storageRef = _storage.ref().child(id);
      final tempDir = await getApplicationDocumentsDirectory();
      final tempPath =
          path.join(tempDir.path, _cacheDirectoryName, storageRef.name);

      await storageRef.writeToFile(File(tempPath));

      return File(tempPath);
    } catch (e) {
      return null;
    }
  }

  Future<File?> getImageFromCache(String id) async {
    final cacheDir = await getApplicationDocumentsDirectory();
    final cachePath = path.join(cacheDir.path, _cacheDirectoryName);
    final cacheFilePath = path.join(cachePath, '$id.jpg');

    final cachedFile = File(cacheFilePath);
    if (await cachedFile.exists()) {
      return cachedFile;
    } else {
      return null;
    }
  }

  Future<bool> removeImageFromDB(String id) async {
    try {
      final storageRef = _storage.ref().child('$id.jpg');
      await storageRef.delete();

      return true;
    } catch (e) {
      print('Error removing image from remote DB: $e');
      return false;
    }
  }

  Future<bool> removeImageFromCache(String id) async {
    final cacheDir = await getApplicationDocumentsDirectory();
    final cachePath = path.join(cacheDir.path, _cacheDirectoryName);
    final fileName = '$id.jpg';
    final cacheFilePath = path.join(cachePath, fileName);

    final cachedFile = File(cacheFilePath);
    if (await cachedFile.exists()) {
      await cachedFile.delete();
      return true;
    } else {
      return false;
    }
  }

  Future<File?> getImageById(String id) async {
    final cacheImage = await getImageFromCache(id);

    if (cacheImage != null) {
      return cacheImage;
    }

    return await getImageFromRemoteDB(id);
  }
}
