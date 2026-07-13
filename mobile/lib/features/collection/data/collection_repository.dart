import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../domain/collection_models.dart';
import 'collection_local_store.dart';

class CollectionRepository {
  CollectionRepository(this._dio, this._local);

  final Dio _dio;
  final CollectionLocalStore? _local;

  /// Fetches the full collection (paging through the API). On network failure,
  /// falls back to the sqflite mirror; on success, refreshes the mirror.
  Future<(List<CollectionItem>, bool fromCache)> fetchAll() async {
    try {
      final items = <CollectionItem>[];
      var page = 1;
      while (true) {
        final resp = await _dio.get<Map<String, dynamic>>(
          '/collection',
          queryParameters: {'page': page, 'page_size': 100},
        );
        final data = resp.data!;
        items.addAll(
          (data['items'] as List).map((e) => CollectionItem.fromJson(e as Map<String, dynamic>)),
        );
        if (items.length >= (data['total'] as int)) break;
        page += 1;
      }
      await _local?.replaceAll(items);
      return (items, false);
    } on DioException {
      final cached = await _local?.readAll();
      if (cached != null && cached.isNotEmpty) return (cached, true);
      rethrow;
    }
  }

  Future<CollectionItem> add({
    required String cardId,
    required int quantity,
    required String condition,
    String? notes,
  }) async {
    final resp = await _dio.post<Map<String, dynamic>>('/collection', data: {
      'card_id': cardId,
      'quantity': quantity,
      'condition': condition,
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    });
    return CollectionItem.fromJson(resp.data!);
  }

  Future<CollectionItem> update(
    int itemId, {
    int? quantity,
    String? condition,
    String? notes,
  }) async {
    final resp = await _dio.patch<Map<String, dynamic>>('/collection/$itemId', data: {
      'quantity': ?quantity,
      'condition': ?condition,
      'notes': ?notes,
    });
    return CollectionItem.fromJson(resp.data!);
  }

  Future<void> remove(int itemId) => _dio.delete<void>('/collection/$itemId');

  Future<CollectionStats> stats() async {
    final resp = await _dio.get<Map<String, dynamic>>('/collection/stats');
    return CollectionStats.fromJson(resp.data!);
  }
}

/// Overridden in main() with a real sqflite store; null keeps tests hermetic.
final collectionLocalStoreProvider = Provider<CollectionLocalStore?>((ref) => null);

final collectionRepositoryProvider = Provider<CollectionRepository>(
  (ref) => CollectionRepository(
    ref.watch(dioProvider),
    ref.watch(collectionLocalStoreProvider),
  ),
);

final collectionStatsProvider = FutureProvider<CollectionStats>(
  (ref) => ref.watch(collectionRepositoryProvider).stats(),
);
