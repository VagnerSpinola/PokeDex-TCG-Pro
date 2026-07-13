import 'package:mocktail/mocktail.dart';
import 'package:pokedex_tcg_pro/features/auth/data/auth_repository.dart';
import 'package:pokedex_tcg_pro/features/cards/data/cards_repository.dart';
import 'package:pokedex_tcg_pro/features/cards/domain/card_models.dart';
import 'package:pokedex_tcg_pro/features/collection/data/collection_repository.dart';
import 'package:pokedex_tcg_pro/features/collection/domain/collection_models.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCardsRepository extends Mock implements CardsRepository {}

class MockCollectionRepository extends Mock implements CollectionRepository {}

const pikachu = TcgCard(id: 'sv1-25', name: 'Pikachu', setId: 'sv1', rarity: 'Common');
const miraidon = TcgCard(id: 'sv1-198', name: 'Miraidon ex', setId: 'sv1', rarity: 'Ultra Rare');

const pikachuItem = CollectionItem(
  id: 1,
  cardId: 'sv1-25',
  quantity: 2,
  condition: 'near_mint',
  card: pikachu,
);

const emptyStats = CollectionStats(totalCards: 2, uniqueCards: 1, sets: []);

void registerCommonFallbacks() {
  registerFallbackValue(const CardFilters());
}
