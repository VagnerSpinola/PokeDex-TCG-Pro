import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/cards/data/cards_repository.dart';
import 'package:pokedex_tcg_pro/features/cards/domain/card_models.dart';
import 'package:pokedex_tcg_pro/features/cards/presentation/cards_notifier.dart';

import '../../helpers.dart';

void main() {
  late MockCardsRepository repo;
  late ProviderContainer container;

  setUpAll(registerCommonFallbacks);

  setUp(() {
    repo = MockCardsRepository();
    container = ProviderContainer(
      overrides: [cardsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('loads first page on build', () async {
    when(() => repo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [pikachu], page: 1, pageSize: 20, total: 1),
    );

    container.read(cardsNotifierProvider);
    await settle();

    final state = container.read(cardsNotifierProvider);
    expect(state.cards, [pikachu]);
    expect(state.total, 1);
    expect(state.hasMore, isFalse);
  });

  test('loadMore appends next page', () async {
    when(() => repo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [pikachu], page: 1, pageSize: 1, total: 2),
    );
    when(() => repo.listCards(page: 2, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [miraidon], page: 2, pageSize: 1, total: 2),
    );

    container.read(cardsNotifierProvider);
    await settle();
    expect(container.read(cardsNotifierProvider).hasMore, isTrue);

    await container.read(cardsNotifierProvider.notifier).loadMore();
    final state = container.read(cardsNotifierProvider);
    expect(state.cards, [pikachu, miraidon]);
    expect(state.hasMore, isFalse);
  });

  test('setQuery resets to first page with query filter', () async {
    when(() => repo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [pikachu], page: 1, pageSize: 20, total: 1),
    );

    container.read(cardsNotifierProvider);
    await settle();
    await container.read(cardsNotifierProvider.notifier).setQuery('pika');

    final captured = verify(
      () => repo.listCards(page: 1, filters: captureAny(named: 'filters')),
    ).captured;
    expect((captured.last as CardFilters).query, 'pika');
  });

  test('setFilters forwards multi-select sets and rarities', () async {
    when(() => repo.listCards(page: 1, filters: any(named: 'filters'))).thenAnswer(
      (_) async => const PaginatedCards(items: [], page: 1, pageSize: 20, total: 0),
    );

    container.read(cardsNotifierProvider);
    await settle();
    await container.read(cardsNotifierProvider.notifier).setFilters(
          const CardFilters(setIds: ['sv1', 'base1'], rarities: ['Rare', 'Ultra Rare']),
        );

    final captured = verify(
      () => repo.listCards(page: 1, filters: captureAny(named: 'filters')),
    ).captured;
    final filters = captured.last as CardFilters;
    expect(filters.setIds, ['sv1', 'base1']);
    expect(filters.rarities, ['Rare', 'Ultra Rare']);
    expect(filters.activeCount, 2);
  });

  test('exposes error when repository fails', () async {
    when(() => repo.listCards(page: 1, filters: any(named: 'filters')))
        .thenThrow(Exception('boom'));

    container.read(cardsNotifierProvider);
    await settle();

    final state = container.read(cardsNotifierProvider);
    expect(state.error, isNotNull);
    expect(state.loading, isFalse);
  });
}
