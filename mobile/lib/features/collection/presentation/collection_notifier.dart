import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/collection_repository.dart';
import '../domain/collection_models.dart';

class CollectionState {
  const CollectionState({
    this.items = const [],
    this.loading = false,
    this.fromCache = false,
    this.error,
  });

  final List<CollectionItem> items;
  final bool loading;
  final bool fromCache;
  final String? error;

  CollectionState copyWith({
    List<CollectionItem>? items,
    bool? loading,
    bool? fromCache,
    String? error,
  }) {
    return CollectionState(
      items: items ?? this.items,
      loading: loading ?? this.loading,
      fromCache: fromCache ?? this.fromCache,
      error: error,
    );
  }
}

class CollectionNotifier extends Notifier<CollectionState> {
  @override
  CollectionState build() {
    Future.microtask(load);
    return const CollectionState(loading: true);
  }

  CollectionRepository get _repo => ref.read(collectionRepositoryProvider);

  Future<void> load() async {
    state = state.copyWith(loading: true, error: null);
    try {
      final (items, fromCache) = await _repo.fetchAll();
      state = state.copyWith(items: items, loading: false, fromCache: fromCache);
    } catch (_) {
      state = state.copyWith(loading: false, error: 'Erro ao carregar coleção');
    }
  }

  Future<bool> add({
    required String cardId,
    required int quantity,
    required String condition,
    String? notes,
  }) async {
    try {
      await _repo.add(cardId: cardId, quantity: quantity, condition: condition, notes: notes);
      ref.invalidate(collectionStatsProvider);
      await load();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> updateItem(int itemId, {int? quantity, String? condition, String? notes}) async {
    try {
      await _repo.update(itemId, quantity: quantity, condition: condition, notes: notes);
      ref.invalidate(collectionStatsProvider);
      await load();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> removeItem(int itemId) async {
    try {
      await _repo.remove(itemId);
      ref.invalidate(collectionStatsProvider);
      await load();
      return true;
    } catch (_) {
      return false;
    }
  }
}

final collectionNotifierProvider =
    NotifierProvider<CollectionNotifier, CollectionState>(CollectionNotifier.new);
