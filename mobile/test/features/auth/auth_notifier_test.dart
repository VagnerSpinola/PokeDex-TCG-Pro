import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/auth/data/auth_repository.dart';
import 'package:pokedex_tcg_pro/features/auth/domain/user.dart';
import 'package:pokedex_tcg_pro/features/auth/presentation/auth_notifier.dart';

import '../../helpers.dart';

const _user = User(id: 1, email: 'ash@example.com', role: 'user', isVerified: false);

DioException _dioError(int status, {Object? body}) {
  final req = RequestOptions(path: '/auth/login');
  return DioException(
    requestOptions: req,
    response: Response(requestOptions: req, statusCode: status, data: body),
  );
}

void main() {
  late MockAuthRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = MockAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('no persisted session -> logged out', () async {
    when(() => repo.hasSession).thenReturn(false);

    container.read(authNotifierProvider);
    await settle();

    expect(container.read(authNotifierProvider), isA<AuthLoggedOut>());
  });

  test('persisted session restores user', () async {
    when(() => repo.hasSession).thenReturn(true);
    when(() => repo.me()).thenAnswer((_) async => _user);

    container.read(authNotifierProvider);
    await settle();

    final state = container.read(authNotifierProvider);
    expect(state, isA<AuthLoggedIn>());
    expect((state as AuthLoggedIn).user.email, 'ash@example.com');
  });

  test('login success -> logged in', () async {
    when(() => repo.hasSession).thenReturn(false);
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async {});
    when(() => repo.me()).thenAnswer((_) async => _user);

    container.read(authNotifierProvider);
    await settle();
    final ok = await container
        .read(authNotifierProvider.notifier)
        .login('ash@example.com', 'pikachu-123');

    expect(ok, isTrue);
    expect(container.read(authNotifierProvider), isA<AuthLoggedIn>());
  });

  test('login failure surfaces API detail message', () async {
    when(() => repo.hasSession).thenReturn(false);
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenThrow(_dioError(401, body: {'detail': 'Invalid email or password'}));

    container.read(authNotifierProvider);
    await settle();
    final ok = await container
        .read(authNotifierProvider.notifier)
        .login('ash@example.com', 'wrong');

    expect(ok, isFalse);
    final state = container.read(authNotifierProvider);
    expect((state as AuthLoggedOut).error, 'Invalid email or password');
  });

  test('logout clears session', () async {
    when(() => repo.hasSession).thenReturn(true);
    when(() => repo.me()).thenAnswer((_) async => _user);
    when(() => repo.logout()).thenAnswer((_) async {});

    container.read(authNotifierProvider);
    await settle();
    await container.read(authNotifierProvider.notifier).logout();

    expect(container.read(authNotifierProvider), isA<AuthLoggedOut>());
    verify(() => repo.logout()).called(1);
  });
}
