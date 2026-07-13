import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/card_models.dart';
import 'cards_notifier.dart';
import 'filter_sheet.dart';

class CardsScreen extends ConsumerStatefulWidget {
  const CardsScreen({super.key});

  @override
  ConsumerState<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends ConsumerState<CardsScreen> {
  final _scroll = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 400) {
        ref.read(cardsNotifierProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scroll.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(cardsNotifierProvider.notifier).setQuery(value.trim());
    });
  }

  Future<void> _openFilters() async {
    final current = ref.read(cardsNotifierProvider).filters;
    final result = await showModalBottomSheet<CardFilters>(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterSheet(initial: current),
    );
    if (result != null) {
      await ref.read(cardsNotifierProvider.notifier).setFilters(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cardsNotifierProvider);
    final hasActiveFilters = state.filters.setId != null ||
        state.filters.rarity != null ||
        state.filters.supertype != null ||
        state.filters.type != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cartas'),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: hasActiveFilters,
              child: const Icon(Icons.filter_list),
            ),
            onPressed: _openFilters,
            tooltip: 'Filtros',
          ),
          IconButton(
            icon: const Icon(Icons.collections_bookmark),
            onPressed: () => context.go('/collection'),
            tooltip: 'Minha coleção',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: Icon(Icons.search),
                isDense: true,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
        ),
      ),
      body: switch (state) {
        CardsState(loading: true, cards: []) =>
          const Center(child: CircularProgressIndicator()),
        CardsState(error: final e?, cards: []) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(e),
                TextButton(
                  onPressed: () =>
                      ref.read(cardsNotifierProvider.notifier).loadFirstPage(),
                  child: const Text('Tentar de novo'),
                ),
              ],
            ),
          ),
        CardsState(cards: []) => const Center(child: Text('Nenhuma carta encontrada')),
        _ => RefreshIndicator(
            onRefresh: () => ref.read(cardsNotifierProvider.notifier).loadFirstPage(),
            child: GridView.builder(
              controller: _scroll,
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                childAspectRatio: 0.72,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: state.cards.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, i) {
                if (i >= state.cards.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _CardTile(card: state.cards[i]);
              },
            ),
          ),
      },
    );
  }
}

class _CardTile extends StatelessWidget {
  const _CardTile({required this.card});

  final TcgCard card;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/cards/${card.id}'),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: card.imageSmallUrl != null
                ? CachedNetworkImage(
                    imageUrl: card.imageSmallUrl!,
                    fit: BoxFit.contain,
                    placeholder: (_, _) =>
                        const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    errorWidget: (_, _, _) => const Icon(Icons.image_not_supported),
                  )
                : const ColoredBox(
                    color: Color(0x11000000),
                    child: Icon(Icons.image_not_supported),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              card.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
