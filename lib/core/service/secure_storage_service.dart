import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SecureStorageService implements HydratedStorage {
  static final storage = FlutterSecureStorage();

  Future<Map<String, String>> allValues() async {
    return await storage.readAll();
  }

  @override
  Future<void> clear() async {
    return await storage.deleteAll();
  }

  @override
  Future<void> write(String key, value) async {
    await storage.write(key: key, value: value);
  }

  @override
  read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> close() async {
    return Future.value();
  }
}
