import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../data/cards_repository.dart';
import '../domain/card_models.dart';

const _rarities = [
  'Common',
  'Uncommon',
  'Rare',
  'Rare Holo',
  'Rare Holo V',
  'Ultra Rare',
  'Secret Rare',
];

const _supertypes = ['Pokémon', 'Trainer', 'Energy'];

const _types = [
  'Colorless', 'Darkness', 'Dragon', 'Fairy', 'Fighting',
  'Fire', 'Grass', 'Lightning', 'Metal', 'Psychic', 'Water',
];

class FilterSheet extends ConsumerStatefulWidget {
  const FilterSheet({super.key, required this.initial});

  final CardFilters initial;

  @override
  ConsumerState<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends ConsumerState<FilterSheet> {
  late String? _setId = widget.initial.setId;
  late String? _rarity = widget.initial.rarity;
  late String? _supertype = widget.initial.supertype;
  late String? _type = widget.initial.type;

  @override
  Widget build(BuildContext context) {
    final sets = ref.watch(setsProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Filtros', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          sets.when(
            data: (list) => DropdownButtonFormField<String?>(
              initialValue: _setId,
              decoration: const InputDecoration(labelText: 'Set'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Todos')),
                for (final s in list)
                  DropdownMenuItem(value: s.id, child: Text(s.name, overflow: TextOverflow.ellipsis)),
              ],
              onChanged: (v) => setState(() => _setId = v),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const Text('Não foi possível carregar os sets'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _rarity,
            decoration: const InputDecoration(labelText: 'Raridade'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Todas')),
              for (final r in _rarities) DropdownMenuItem(value: r, child: Text(r)),
            ],
            onChanged: (v) => setState(() => _rarity = v),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String?>(
            initialValue: _supertype,
            decoration: const InputDecoration(labelText: 'Categoria'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Todas')),
              for (final s in _supertypes) DropdownMenuItem(value: s, child: Text(s)),
            ],
            onChanged: (v) => setState(() => _supertype = v),
          ),
          const SizedBox(height: 16),
          Text('Tipo de energia', style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 8),
          // Energy filters as tappable "energy cards" — each type wears its
          // game color (Energia Viva signature).
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final t in _types)
                ChoiceChip(
                  label: Text(t),
                  selected: _type == t,
                  onSelected: (on) => setState(() => _type = on ? t : null),
                  selectedColor: energyColors[t],
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: _type == t ? const Color(0xFF17171F) : null,
                  ),
                  showCheckmark: false,
                  side: _type == t
                      ? BorderSide.none
                      : BorderSide(
                          color: (energyColors[t] ?? Colors.white).withValues(alpha: 0.55),
                        ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(
                    context,
                    CardFilters(query: widget.initial.query),
                  ),
                  child: const Text('Limpar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.pop(
                    context,
                    CardFilters(
                      query: widget.initial.query,
                      setId: _setId,
                      rarity: _rarity,
                      supertype: _supertype,
                      type: _type,
                    ),
                  ),
                  child: const Text('Aplicar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
