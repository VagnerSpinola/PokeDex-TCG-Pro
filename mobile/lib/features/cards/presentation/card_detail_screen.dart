import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../collection/presentation/add_to_collection_sheet.dart';
import '../data/cards_repository.dart';
import '../domain/card_models.dart';

class CardDetailScreen extends ConsumerWidget {
  const CardDetailScreen({super.key, required this.cardId});

  final String cardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardDetailProvider(cardId));

    return Scaffold(
      appBar: AppBar(
        title: Text(card.value?.name ?? 'Carta'),
        // Fallback for deep links/web reloads where there is nothing to pop.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar',
          onPressed: () => context.canPop() ? context.pop() : context.go('/cards'),
        ),
      ),
      body: card.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Erro ao carregar a carta'),
              TextButton(
                onPressed: () => ref.invalidate(cardDetailProvider(cardId)),
                child: const Text('Tentar de novo'),
              ),
            ],
          ),
        ),
        data: (c) => _CardDetail(card: c),
      ),
      floatingActionButton: card.value == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => AddToCollectionSheet(card: card.value!),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar à coleção'),
            ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  const _CardDetail({required this.card});

  final TcgCard card;

  @override
  Widget build(BuildContext context) {
    final image = card.imageLargeUrl ?? card.imageSmallUrl;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (image != null)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 420),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (_, _) => const SizedBox(
                  height: 420,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, _, _) => const Icon(Icons.image_not_supported, size: 64),
              ),
            ),
          ),
        const SizedBox(height: 16),
        Text(card.name, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            if (card.set != null) Chip(label: Text(card.set!.name)),
            if (card.number != null) Chip(label: Text('#${card.number}')),
            if (card.rarity != null) Chip(label: Text(card.rarity!)),
            if (card.supertype != null) Chip(label: Text(card.supertype!)),
            for (final t in card.types ?? const <String>[]) Chip(label: Text(t)),
            if (card.hp != null) Chip(label: Text('HP ${card.hp}')),
          ],
        ),
        if (card.artist != null) ...[
          const SizedBox(height: 12),
          Text('Ilustração: ${card.artist}', style: Theme.of(context).textTheme.bodyMedium),
        ],
        if (card.flavorText != null) ...[
          const SizedBox(height: 12),
          Text(
            card.flavorText!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
        const SizedBox(height: 80),
      ],
    );
  }
}
