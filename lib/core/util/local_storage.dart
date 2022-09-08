import 'package:localstorage/localstorage.dart';

class LocalStorageService {
  final LocalStorage storage = LocalStorage('amazing_tv');

  Future<void> saveToLocal(String key, dynamic value) async {
    await storage.ready;
    await storage.setItem(key, value);
  }

  Future<dynamic> getFromLocal(String key) async {
    await storage.ready;
    return storage.getItem(key);
  }

  void clearStorage() {
    storage.clear();
  }
}
