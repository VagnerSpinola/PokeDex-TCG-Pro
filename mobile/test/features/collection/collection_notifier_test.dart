import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/collection/data/collection_repository.dart';
import 'package:pokedex_tcg_pro/features/collection/presentation/collection_notifier.dart';

import '../../helpers.dart';

void main() {
  late MockCollectionRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = MockCollectionRepository();
    container = ProviderContainer(
      overrides: [collectionRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('loads items on build', () async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], false));

    container.read(collectionNotifierProvider);
    await settle();

    final state = container.read(collectionNotifierProvider);
    expect(state.items, [pikachuItem]);
    expect(state.fromCache, isFalse);
  });

  test('flags offline copy when repository falls back to cache', () async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], true));

    container.read(collectionNotifierProvider);
    await settle();

    expect(container.read(collectionNotifierProvider).fromCache, isTrue);
  });

  test('add() posts and reloads', () async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], false));
    when(
      () => repo.add(
        cardId: any(named: 'cardId'),
        quantity: any(named: 'quantity'),
        condition: any(named: 'condition'),
        notes: any(named: 'notes'),
      ),
    ).thenAnswer((_) async => pikachuItem);

    container.read(collectionNotifierProvider);
    await settle();

    final ok = await container
        .read(collectionNotifierProvider.notifier)
        .add(cardId: 'sv1-25', quantity: 1, condition: 'near_mint');

    expect(ok, isTrue);
    verify(() => repo.add(
          cardId: 'sv1-25',
          quantity: 1,
          condition: 'near_mint',
          notes: null,
        )).called(1);
    verify(() => repo.fetchAll()).called(2); // build + reload after add
  });

  test('removeItem() returns false on failure', () async {
    when(() => repo.fetchAll()).thenAnswer((_) async => ([pikachuItem], false));
    when(() => repo.remove(any())).thenThrow(Exception('offline'));

    container.read(collectionNotifierProvider);
    await settle();

    final ok = await container.read(collectionNotifierProvider.notifier).removeItem(1);
    expect(ok, isFalse);
  });
}
