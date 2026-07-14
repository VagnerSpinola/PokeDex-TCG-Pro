import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../core/api/api_client.dart';
import '../domain/card_models.dart';

/// Short-TTL response cache (AGENTS.md guardrail: cache, don't mirror).
class _TtlCache {
  _TtlCache(this._box, this.ttl);

  final Box<String> _box;
  final Duration ttl;

  Map<String, dynamic>? get(String key) {
    final raw = _box.get(key);
    if (raw == null) return null;
    final entry = jsonDecode(raw) as Map<String, dynamic>;
    final storedAt = DateTime.parse(entry['at'] as String);
    if (DateTime.now().difference(storedAt) > ttl) {
      _box.delete(key);
      return null;
    }
    return entry['data'] as Map<String, dynamic>;
  }

  Future<void> put(String key, Map<String, dynamic> data) =>
      _box.put(key, jsonEncode({'at': DateTime.now().toIso8601String(), 'data': data}));
}

class CardsRepository {
  CardsRepository(this._dio, Box<String> cacheBox)
      : _cache = _TtlCache(cacheBox, const Duration(minutes: 30));

  static const cacheBoxName = 'cards_cache';

  // Bump when the API response shape changes (e.g. prices added) so stale
  // cached entries from an older schema are ignored.
  static const _cacheVersion = 'v2';

  final Dio _dio;
  final _TtlCache _cache;

  Future<PaginatedCards> listCards({required int page, CardFilters filters = const CardFilters()}) async {
    final params = <String, dynamic>{
      'page': page,
      'page_size': 20,
      if (filters.query.isNotEmpty) 'q': filters.query,
      // Lists serialize as repeated params (set_id=a&set_id=b) — Dio's
      // default ListFormat.multi matches what FastAPI expects.
      if (filters.setIds.isNotEmpty) 'set_id': filters.setIds,
      if (filters.rarities.isNotEmpty) 'rarity': filters.rarities,
      if (filters.supertype != null) 'supertype': filters.supertype,
      if (filters.type != null) 'type': filters.type,
    };
    final cacheKey = '$_cacheVersion:cards:${jsonEncode(params)}';
    final cached = _cache.get(cacheKey);
    if (cached != null) return PaginatedCards.fromJson(cached);

    final resp = await _dio.get<Map<String, dynamic>>('/cards', queryParameters: params);
    await _cache.put(cacheKey, resp.data!);
    return PaginatedCards.fromJson(resp.data!);
  }

  Future<TcgCard> getCard(String id) async {
    final cacheKey = '$_cacheVersion:card:$id';
    final cached = _cache.get(cacheKey);
    if (cached != null) return TcgCard.fromJson(cached);

    final resp = await _dio.get<Map<String, dynamic>>('/cards/$id');
    await _cache.put(cacheKey, resp.data!);
    return TcgCard.fromJson(resp.data!);
  }

  Future<List<SetInfo>> listSets() async {
    final cacheKey = '$_cacheVersion:sets';
    final cached = _cache.get(cacheKey);
    if (cached != null) {
      return (cached['items'] as List)
          .map((e) => SetInfo.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    final resp = await _dio.get<List<dynamic>>('/sets');
    await _cache.put(cacheKey, {'items': resp.data!});
    return resp.data!.map((e) => SetInfo.fromJson(e as Map<String, dynamic>)).toList();
  }
}

final cardsRepositoryProvider = Provider<CardsRepository>(
  (ref) => CardsRepository(ref.watch(dioProvider), Hive.box<String>(CardsRepository.cacheBoxName)),
);

final setsProvider = FutureProvider<List<SetInfo>>(
  (ref) => ref.watch(cardsRepositoryProvider).listSets(),
);

final cardDetailProvider = FutureProvider.family<TcgCard, String>(
  (ref, id) => ref.watch(cardsRepositoryProvider).getCard(id),
);
