import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/cards_repository.dart';
import '../domain/card_models.dart';

class CardsState {
  const CardsState({
    this.cards = const [],
    this.filters = const CardFilters(),
    this.page = 1,
    this.total = 0,
    this.loading = false,
    this.error,
  });

  final List<TcgCard> cards;
  final CardFilters filters;
  final int page;
  final int total;
  final bool loading;
  final String? error;

  bool get hasMore => cards.length < total;

  CardsState copyWith({
    List<TcgCard>? cards,
    CardFilters? filters,
    int? page,
    int? total,
    bool? loading,
    String? error,
  }) {
    return CardsState(
      cards: cards ?? this.cards,
      filters: filters ?? this.filters,
      page: page ?? this.page,
      total: total ?? this.total,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}

class CardsNotifier extends Notifier<CardsState> {
  @override
  CardsState build() {
    Future.microtask(loadFirstPage);
    return const CardsState(loading: true);
  }

  CardsRepository get _repo => ref.read(cardsRepositoryProvider);

  Future<void> loadFirstPage() async {
    state = state.copyWith(loading: true, cards: [], page: 1, error: null);
    try {
      final result = await _repo.listCards(page: 1, filters: state.filters);
      state = state.copyWith(cards: result.items, total: result.total, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: 'Erro ao carregar cartas');
    }
  }

  Future<void> loadMore() async {
    if (state.loading || !state.hasMore) return;
    state = state.copyWith(loading: true);
    try {
      final next = state.page + 1;
      final result = await _repo.listCards(page: next, filters: state.filters);
      state = state.copyWith(
        cards: [...state.cards, ...result.items],
        page: next,
        total: result.total,
        loading: false,
      );
    } catch (e) {
      state = state.copyWith(loading: false, error: 'Erro ao carregar mais cartas');
    }
  }

  Future<void> setQuery(String query) async {
    state = state.copyWith(filters: state.filters.copyWith(query: query));
    await loadFirstPage();
  }

  Future<void> setFilters(CardFilters filters) async {
    state = state.copyWith(filters: filters);
    await loadFirstPage();
  }
}

final cardsNotifierProvider = NotifierProvider<CardsNotifier, CardsState>(CardsNotifier.new);
