import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

/// Persists the JWT pair in a Hive box.
///
/// Phase-1 simplification: the box is not encrypted (an encrypted box would
/// require flutter_secure_storage for key management — flagged in docs).
class TokenStorage {
  TokenStorage(this._box);

  static const boxName = 'auth';
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  final Box<String> _box;

  String? get accessToken => _box.get(_accessKey);
  String? get refreshToken => _box.get(_refreshKey);
  bool get hasSession => refreshToken != null;

  Future<void> save({required String access, required String refresh}) async {
    await _box.put(_accessKey, access);
    await _box.put(_refreshKey, refresh);
  }

  Future<void> clear() async {
    await _box.delete(_accessKey);
    await _box.delete(_refreshKey);
  }
}

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(Hive.box<String>(TokenStorage.boxName)),
);
