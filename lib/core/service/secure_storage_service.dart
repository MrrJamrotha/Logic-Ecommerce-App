import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final storage = FlutterSecureStorage();

  Future<Map<String, String>> allValues() async {
    return await storage.readAll();
  }

  Future<void> clear() async {
    return await storage.deleteAll();
  }

  Future<void> write(String key, value) async {
    await storage.write(key: key, value: value);
  }

  read(String key) async {
    return await storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }
}
