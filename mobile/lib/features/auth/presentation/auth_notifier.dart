import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';
import '../domain/user.dart';

sealed class AuthState {
  const AuthState();
}

class AuthUnknown extends AuthState {
  const AuthUnknown();
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut({this.error});

  final String? error;
}

class AuthLoggedIn extends AuthState {
  const AuthLoggedIn(this.user);

  final User user;
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Resolve the persisted session lazily after startup.
    Future.microtask(restoreSession);
    return const AuthUnknown();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> restoreSession() async {
    if (!_repo.hasSession) {
      state = const AuthLoggedOut();
      return;
    }
    try {
      state = AuthLoggedIn(await _repo.me());
    } on DioException {
      await _repo.logout();
      state = const AuthLoggedOut();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      await _repo.login(email: email, password: password);
      state = AuthLoggedIn(await _repo.me());
      return true;
    } on DioException catch (e) {
      state = AuthLoggedOut(error: _message(e, 'Falha no login'));
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await _repo.register(email: email, password: password);
      return login(email, password);
    } on DioException catch (e) {
      state = AuthLoggedOut(error: _message(e, 'Falha no registro'));
      return false;
    }
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthLoggedOut();
  }

  String _message(DioException e, String fallback) {
    final detail = e.response?.data;
    if (detail is Map && detail['detail'] is String) return detail['detail'] as String;
    return fallback;
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
