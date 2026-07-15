import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../data/cards_repository.dart';
import '../domain/card_models.dart';

const _rarityOptions = [
  'Common',
  'Uncommon',
  'Rare',
  'Rare Holo',
  'Rare Holo V',
  'Rare Ultra',
  'Ultra Rare',
  'Double Rare',
  'Illustration Rare',
  'Special Illustration Rare',
  'Secret Rare',
  'Promo',
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
  late final Set<String> _setIds = {...widget.initial.setIds};
  late final Set<String> _rarities = {...widget.initial.rarities};
  late String? _supertype = widget.initial.supertype;
  late String? _type = widget.initial.type;

  Future<void> _pickSets(List<SetInfo> allSets) async {
    final picked = await showDialog<Set<String>>(
      context: context,
      builder: (_) => _SetPickerDialog(allSets: allSets, initial: _setIds),
    );
    if (picked != null) {
      setState(() {
        _setIds
          ..clear()
          ..addAll(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sets = ref.watch(setsProvider);
    final theme = Theme.of(context);

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
          Text('Filtros', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Sets', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          sets.when(
            data: (list) {
              final byId = {for (final s in list) s.id: s.name};
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => _pickSets(list),
                    icon: const Icon(Icons.library_add_check_outlined, size: 18),
                    label: Text(
                      _setIds.isEmpty
                          ? 'Escolher sets...'
                          : '${_setIds.length} set${_setIds.length > 1 ? 's' : ''} selecionado${_setIds.length > 1 ? 's' : ''}',
                    ),
                  ),
                  if (_setIds.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final id in _setIds)
                            InputChip(
                              label: Text(
                                byId[id] ?? id,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 11),
                              ),
                              onDeleted: () => setState(() => _setIds.remove(id)),
                            ),
                        ],
                      ),
                    ),
                ],
              );
            },
            loading: () => const LinearProgressIndicator(),
            error: (_, _) => const Text('Não foi possível carregar os sets'),
          ),
          const SizedBox(height: 16),
          Text('Raridade', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final r in _rarityOptions)
                FilterChip(
                  label: Text(r, style: const TextStyle(fontSize: 12)),
                  selected: _rarities.contains(r),
                  onSelected: (on) => setState(() {
                    if (on) {
                      _rarities.add(r);
                    } else {
                      _rarities.remove(r);
                    }
                  }),
                  selectedColor: const Color(0x33B06BFF),
                  checkmarkColor: holoCyan,
                ),
            ],
          ),
          const SizedBox(height: 16),
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
          Text('Tipo de energia', style: theme.textTheme.labelLarge),
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
                  // Limpar zera filtros, mas mantém busca e ordenação.
                  onPressed: () => Navigator.pop(
                    context,
                    CardFilters(query: widget.initial.query, sort: widget.initial.sort),
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
                      setIds: _setIds.toList(),
                      rarities: _rarities.toList(),
                      supertype: _supertype,
                      type: _type,
                      sort: widget.initial.sort,
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

/// Searchable multi-select over the 173 sets.
class _SetPickerDialog extends StatefulWidget {
  const _SetPickerDialog({required this.allSets, required this.initial});

  final List<SetInfo> allSets;
  final Set<String> initial;

  @override
  State<_SetPickerDialog> createState() => _SetPickerDialogState();
}

class _SetPickerDialogState extends State<_SetPickerDialog> {
  late final Set<String> _selected = {...widget.initial};
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final visible = _query.isEmpty
        ? widget.allSets
        : widget.allSets
            .where((s) => s.name.toLowerCase().contains(_query.toLowerCase()))
            .toList();

    return AlertDialog(
      title: Text('Sets${_selected.isEmpty ? '' : ' (${_selected.length})'}'),
      contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      content: SizedBox(
        width: 400,
        height: 420,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Buscar set...',
                prefixIcon: Icon(Icons.search, size: 20),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v.trim()),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: visible.isEmpty
                  ? const Center(child: Text('Nenhum set encontrado'))
                  : ListView.builder(
                      itemCount: visible.length,
                      itemBuilder: (context, i) {
                        final s = visible[i];
                        return CheckboxListTile(
                          dense: true,
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(s.name, style: const TextStyle(fontSize: 13)),
                          subtitle: s.series != null
                              ? Text(s.series!, style: const TextStyle(fontSize: 11))
                              : null,
                          value: _selected.contains(s.id),
                          onChanged: (on) => setState(() {
                            if (on == true) {
                              _selected.add(s.id);
                            } else {
                              _selected.remove(s.id);
                            }
                          }),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        if (_selected.isNotEmpty)
          TextButton(
            onPressed: () => setState(_selected.clear),
            child: const Text('Limpar'),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _selected),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
