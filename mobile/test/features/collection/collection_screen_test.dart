import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/collection/data/collection_repository.dart';
import 'package:pokedex_tcg_pro/features/collection/domain/collection_models.dart';
import 'package:pokedex_tcg_pro/features/collection/presentation/collection_screen.dart';

import '../../helpers.dart';

void main() {
  late MockCollectionRepository repo;

  setUp(() {
    repo = MockCollectionRepository();
  });

  Widget wrap() => ProviderScope(
        overrides: [collectionRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(home: CollectionScreen()),
      );

  testWidgets('renders items and stats', (tester) async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], false));
    when(() => repo.stats()).thenAnswer(
      (_) async => const CollectionStats(
        totalCards: 2,
        uniqueCards: 1,
        sets: [SetCount(setId: 'sv1', setName: 'Scarlet & Violet', count: 2)],
      ),
    );

    await tester.pumpWidget(wrap());
    await tester.pump();
    await tester.pump();

    expect(find.text('Pikachu'), findsOneWidget);
    expect(find.textContaining('2x'), findsOneWidget);
    expect(find.text('Cartas'), findsOneWidget); // stats card
  });

  testWidgets('shows offline banner when data came from local mirror', (tester) async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], true));
    when(() => repo.stats()).thenThrow(Exception('offline'));

    await tester.pumpWidget(wrap());
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Sem conexão'), findsOneWidget);
  });

  testWidgets('shows empty state', (tester) async {
    when(() => repo.fetchAll()).thenAnswer((_) async => (<CollectionItem>[], false));
    when(() => repo.stats()).thenAnswer((_) async => emptyStats);

    await tester.pumpWidget(wrap());
    await tester.pump();
    await tester.pump();

    expect(find.textContaining('Sua coleção está vazia'), findsOneWidget);
  });
}
