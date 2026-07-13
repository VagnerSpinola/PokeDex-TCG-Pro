import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/user.dart';

class AuthRepository {
  AuthRepository(this._dio, this._storage);

  final Dio _dio;
  final TokenStorage _storage;

  Future<void> register({required String email, required String password}) async {
    await _dio.post<void>('/auth/register', data: {'email': email, 'password': password});
  }

  Future<void> login({required String email, required String password}) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final data = resp.data!;
    await _storage.save(
      access: data['access_token'] as String,
      refresh: data['refresh_token'] as String,
    );
  }

  Future<User> me() async {
    final resp = await _dio.get<Map<String, dynamic>>('/auth/me');
    return User.fromJson(resp.data!);
  }

  Future<void> logout() => _storage.clear();

  bool get hasSession => _storage.hasSession;
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(dioProvider), ref.watch(tokenStorageProvider)),
);
