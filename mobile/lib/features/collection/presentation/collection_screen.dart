import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/collection_repository.dart';
import '../domain/collection_models.dart';
import 'collection_notifier.dart';
import 'edit_item_sheet.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(collectionNotifierProvider);
    final stats = ref.watch(collectionStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha coleção'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/cards'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(collectionStatsProvider);
          await ref.read(collectionNotifierProvider.notifier).load();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (state.fromCache)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.cloud_off, size: 20),
                      SizedBox(width: 8),
                      Expanded(child: Text('Sem conexão — mostrando cópia local')),
                    ],
                  ),
                ),
              ),
            stats.when(
              data: (s) => _StatsCard(stats: s),
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 8),
            if (state.loading && state.items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.error != null && state.items.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Text(state.error!),
                    TextButton(
                      onPressed: () => ref.read(collectionNotifierProvider.notifier).load(),
                      child: const Text('Tentar de novo'),
                    ),
                  ],
                ),
              )
            else if (state.items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text('Sua coleção está vazia.\nAdicione cartas pela busca!',
                      textAlign: TextAlign.center),
                ),
              )
            else
              for (final item in state.items) _CollectionTile(item: item),
          ],
        ),
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.stats});

  final CollectionStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _Stat(label: 'Cartas', value: '${stats.totalCards}'),
            _Stat(label: 'Únicas', value: '${stats.uniqueCards}'),
            _Stat(label: 'Sets', value: '${stats.sets.length}'),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineSmall),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _CollectionTile extends ConsumerWidget {
  const _CollectionTile({required this.item});

  final CollectionItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: item.card.imageSmallUrl != null
            ? CachedNetworkImage(imageUrl: item.card.imageSmallUrl!, width: 40)
            : const Icon(Icons.style),
        title: Text(item.card.name),
        subtitle: Text(
          '${item.quantity}x · ${cardConditionLabels[item.condition] ?? item.condition}'
          '${item.notes != null ? ' · ${item.notes}' : ''}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () => context.push('/cards/${item.cardId}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Editar',
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => EditItemSheet(item: item),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Remover',
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Remover da coleção?'),
                    content: Text('${item.card.name} (${item.quantity}x)'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancelar'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Remover'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await ref.read(collectionNotifierProvider.notifier).removeItem(item.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
