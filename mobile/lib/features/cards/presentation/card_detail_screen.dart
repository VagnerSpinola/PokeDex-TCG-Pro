import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/holo.dart';
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
          : HoloButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => AddToCollectionSheet(card: card.value!),
              ),
              icon: Icons.add,
              label: 'Adicionar à coleção',
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
              // The "opening a booster" moment: rare cards shimmer.
              child: HoloShimmer(
                enabled: isHoloRarity(card.rarity),
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
          ),
        const SizedBox(height: 16),
        Text(
          card.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.3),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            if (card.set != null) Chip(label: Text(card.set!.name)),
            if (card.number != null) Chip(label: Text('#${card.number}')),
            if (card.rarity != null)
              isHoloRarity(card.rarity)
                  ? Chip(
                      label: HoloText(card.rarity!,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    )
                  : Chip(label: Text(card.rarity!)),
            if (card.supertype != null) Chip(label: Text(card.supertype!)),
            // Energy types carry their game color — information, not decor.
            for (final t in card.types ?? const <String>[]) _EnergyChip(type: t),
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
        if (card.prices.isNotEmpty) ...[
          const SizedBox(height: 16),
          _PricesSection(prices: card.prices),
        ],
        const SizedBox(height: 80),
      ],
    );
  }
}

class _PricesSection extends StatelessWidget {
  const _PricesSection({required this.prices});

  final List<PriceInfo> prices;

  static const _sourceLabels = {'tcgplayer': 'TCGplayer', 'cardmarket': 'Cardmarket'};

  String _variantLabel(String variant) {
    if (variant == 'default') return '';
    // camelCase -> words: reverseHolofoil -> Reverse Holofoil
    final words = variant.replaceAllMapped(
        RegExp('([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}');
    return words[0].toUpperCase() + words.substring(1);
  }

  String _money(String currency, double? value) {
    if (value == null) return '—';
    final symbol = currency == 'EUR' ? '€' : r'$';
    return '$symbol${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preço médio de mercado', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            for (final p in prices) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      [
                        _sourceLabels[p.source] ?? p.source,
                        if (_variantLabel(p.variant).isNotEmpty) _variantLabel(p.variant),
                      ].join(' · '),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  HoloText(
                    _money(p.currency, p.market ?? p.mid),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'baixo ${_money(p.currency, p.low)} · médio ${_money(p.currency, p.mid)}'
                  '${p.high != null ? ' · alto ${_money(p.currency, p.high)}' : ''}'
                  ' · em ${p.date}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
            Text(
              'Fonte: TCGplayer/Cardmarket via Pokémon TCG API — valores de referência, '
              'não são cotação oficial.',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnergyChip extends StatelessWidget {
  const _EnergyChip({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final color = energyColors[type];
    if (color == null) return Chip(label: Text(type));
    return Chip(
      label: Text(
        type,
        style: const TextStyle(
          color: Color(0xFF17171F),
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
      backgroundColor: color,
      side: BorderSide.none,
    );
  }
}
