import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cards/domain/card_models.dart';
import '../domain/collection_models.dart';
import 'collection_notifier.dart';

class AddToCollectionSheet extends ConsumerStatefulWidget {
  const AddToCollectionSheet({super.key, required this.card});

  final TcgCard card;

  @override
  ConsumerState<AddToCollectionSheet> createState() => _AddToCollectionSheetState();
}

class _AddToCollectionSheetState extends ConsumerState<AddToCollectionSheet> {
  int _quantity = 1;
  String _condition = 'near_mint';
  final _notes = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final ok = await ref.read(collectionNotifierProvider.notifier).add(
          cardId: widget.card.id,
          quantity: _quantity,
          condition: _condition,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok
            ? '${widget.card.name} adicionada à coleção'
            : 'Não foi possível adicionar — tente novamente'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Text('Adicionar ${widget.card.name}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Quantidade'),
              const Spacer(),
              IconButton(
                onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$_quantity', style: Theme.of(context).textTheme.titleMedium),
              IconButton(
                onPressed: () => setState(() => _quantity++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _condition,
            decoration: const InputDecoration(labelText: 'Condição'),
            items: [
              for (final c in cardConditions)
                DropdownMenuItem(value: c, child: Text(cardConditionLabels[c]!)),
            ],
            onChanged: (v) => setState(() => _condition = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notas (opcional)'),
            maxLength: 1000,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
