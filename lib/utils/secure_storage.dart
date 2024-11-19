import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static SecureStorage? _instance;

  SecureStorage._();

  static SecureStorage instance() {
    return _instance ??= SecureStorage._();
  }

  final storage = const FlutterSecureStorage();

  save(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> read(String key) async {
    String? value = await storage.read(key: key);
    return value ?? "";
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
