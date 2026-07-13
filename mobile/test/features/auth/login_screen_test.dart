import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/auth/data/auth_repository.dart';
import 'package:pokedex_tcg_pro/features/auth/domain/user.dart';
import 'package:pokedex_tcg_pro/features/auth/presentation/login_screen.dart';

import '../../helpers.dart';

void main() {
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
    when(() => repo.hasSession).thenReturn(false);
  });

  Widget wrap() => ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(home: LoginScreen()),
      );

  testWidgets('validates empty/invalid fields', (tester) async {
    await tester.pumpWidget(wrap());

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('Informe um email válido'), findsOneWidget);
    expect(find.text('Mínimo de 8 caracteres'), findsOneWidget);
    verifyNever(() => repo.login(
        email: any(named: 'email'), password: any(named: 'password')));
  });

  testWidgets('submits valid credentials', (tester) async {
    when(() => repo.login(email: any(named: 'email'), password: any(named: 'password')))
        .thenAnswer((_) async {});
    when(() => repo.me()).thenAnswer(
      (_) async =>
          const User(id: 1, email: 'ash@example.com', role: 'user', isVerified: false),
    );

    await tester.pumpWidget(wrap());
    await tester.enterText(find.byType(TextFormField).at(0), 'ash@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'pikachu-123');
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    verify(() => repo.login(email: 'ash@example.com', password: 'pikachu-123')).called(1);
  });
}
