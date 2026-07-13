import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/auth/data/auth_repository.dart';
import 'package:pokedex_tcg_pro/features/cards/data/cards_repository.dart';
import 'package:pokedex_tcg_pro/features/cards/domain/card_models.dart';
import 'package:pokedex_tcg_pro/features/cards/presentation/cards_screen.dart';

import '../../helpers.dart';

void main() {
  late MockCardsRepository cardsRepo;
  late MockAuthRepository authRepo;

  setUpAll(registerCommonFallbacks);

  setUp(() {
    cardsRepo = MockCardsRepository();
    authRepo = MockAuthRepository();
    when(() => authRepo.hasSession).thenReturn(false);
  });

  Widget wrap() => ProviderScope(
        overrides: [
          cardsRepositoryProvider.overrideWithValue(cardsRepo),
          authRepositoryProvider.overrideWithValue(authRepo),
        ],
        child: const MaterialApp(home: CardsScreen()),
      );

  testWidgets('renders cards returned by the repository', (tester) async {
    when(() => cardsRepo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async =>
          const PaginatedCards(items: [pikachu, miraidon], page: 1, pageSize: 20, total: 2),
    );

    await tester.pumpWidget(wrap());
    await tester.pump(); // microtask -> loadFirstPage
    await tester.pump(); // state update

    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.text('Miraidon ex'), findsOneWidget);
  });

  testWidgets('shows empty state when nothing matches', (tester) async {
    when(() => cardsRepo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [], page: 1, pageSize: 20, total: 0),
    );

    await tester.pumpWidget(wrap());
    await tester.pump();
    await tester.pump();

    expect(find.text('Nenhuma carta encontrada'), findsOneWidget);
  });

  testWidgets('shows retry on error', (tester) async {
    when(() => cardsRepo.listCards(page: 1, filters: any(named: 'filters')))
        .thenThrow(Exception('offline'));

    await tester.pumpWidget(wrap());
    await tester.pump();
    await tester.pump();

    expect(find.text('Tentar de novo'), findsOneWidget);
  });
}
