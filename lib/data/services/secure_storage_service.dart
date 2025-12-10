import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyToken = 'auth_token';

  static Future<void> saveToken(String token) async =>
      _storage.write(key: _keyToken, value: token);

  static Future<String?> getToken() async =>
      _storage.read(key: _keyToken);

  static Future<void> deleteToken() async =>
      _storage.delete(key: _keyToken);
}
