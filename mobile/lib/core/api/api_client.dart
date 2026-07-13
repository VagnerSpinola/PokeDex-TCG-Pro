import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/token_storage.dart';

/// Backend base URL. Android emulators reach the host machine via 10.0.2.2.
/// Override at build time with --dart-define=API_BASE_URL=...
String defaultBaseUrl() {
  const fromEnv = String.fromEnvironment('API_BASE_URL');
  if (fromEnv.isNotEmpty) return fromEnv;
  if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:8000';
  return 'http://localhost:8000';
}

/// Adds the access token to requests; on a 401, tries one refresh and retries.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._storage, this._dio);

  final TokenStorage _storage;
  final Dio _dio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _storage.accessToken;
    if (token != null && !options.path.startsWith('/auth/')) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final refresh = _storage.refreshToken;
    final is401 = err.response?.statusCode == 401;
    final isAuthCall = err.requestOptions.path.startsWith('/auth/');
    if (!is401 || isAuthCall || refresh == null) {
      return handler.next(err);
    }
    try {
      final resp = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refresh_token': refresh},
      );
      final data = resp.data!;
      await _storage.save(
        access: data['access_token'] as String,
        refresh: data['refresh_token'] as String,
      );
      final retried = await _dio.fetch<dynamic>(
        err.requestOptions..headers['Authorization'] = 'Bearer ${data['access_token']}',
      );
      return handler.resolve(retried);
    } on DioException {
      await _storage.clear();
      return handler.next(err);
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: defaultBaseUrl(),
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  dio.interceptors.add(AuthInterceptor(ref.watch(tokenStorageProvider), dio));
  return dio;
});
