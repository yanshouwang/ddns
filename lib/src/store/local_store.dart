part of '../store.dart';

class LocalStore {
  final String storePath;

  LocalStore(this.storePath);

  Future<String?> read(String path) async {
    final file = File(path);
    final exists = await file.exists();
    if (exists) {
      return file.readAsString();
    } else {
      return null;
    }
  }

  Future<void> write(String path, String text) async {
    final file = File(path);
    final exists = await file.exists();
    if (exists) {
      await file.delete();
    }
    await file.create(recursive: true);
    await file.writeAsString(text);
  }
}
