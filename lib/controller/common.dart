import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';
import 'package:path/path.dart' as path;

late final Store store;
Future<String> getStoragePath() async {
  return path.join((await getApplicationDocumentsDirectory()).path, "memoir");
}

Future<String> getImageStoragePath() async {
  return path.joinAll(
      [(await getApplicationDocumentsDirectory()).path, "memoir", "images"]);
}

Future<Store> initializeStore() async {
  Directory storageDirectory = Directory(await getStoragePath());
  Directory imageDirectory = Directory(await getImageStoragePath());
  await storageDirectory.create();
  await imageDirectory.create();
  store = openStore(
    directory: await getStoragePath(),
  );
  return store;
}

Future<File> saveImage(XFile image) async {
  String location = await getImageStoragePath();
  return await File(image.path)
      .copy('$location/${DateTime.now().millisecondsSinceEpoch}_${image.name}');
}

Future<bool> deleteImage(String path) async {
  try {
    await File(path).delete();
    return true;
  } catch (_) {
    return false;
  }
}
