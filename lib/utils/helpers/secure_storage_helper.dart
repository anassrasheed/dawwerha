import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  Future<String> read({required String key}) async {
    try {
      final storage = new FlutterSecureStorage();
      String? value = await storage.read(key: key);

      if (value == null) {
        value = '';
      }

      return value;
    } catch (e) {}

    return '';
  }

  Future<void> save({required String key, required String value}) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.write(key: key, value: value);
    } catch (e) {}
  }

  Future<void> deleteAll() async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {}
  }

  Future<void> delete({required String key}) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.delete(key: key);
    } catch (e) {
      print(e);
    }
  }
}
