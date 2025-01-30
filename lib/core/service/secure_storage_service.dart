import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final storage = FlutterSecureStorage();

  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<Map<String, String>> allValues() async {
    return await storage.readAll();
  }
}
