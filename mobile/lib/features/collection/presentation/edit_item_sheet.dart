import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/collection_models.dart';
import 'collection_notifier.dart';

class EditItemSheet extends ConsumerStatefulWidget {
  const EditItemSheet({super.key, required this.item});

  final CollectionItem item;

  @override
  ConsumerState<EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends ConsumerState<EditItemSheet> {
  late int _quantity = widget.item.quantity;
  late String _condition = widget.item.condition;
  late final _notes = TextEditingController(text: widget.item.notes ?? '');
  bool _submitting = false;

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    final ok = await ref.read(collectionNotifierProvider.notifier).updateItem(
          widget.item.id,
          quantity: _quantity,
          condition: _condition,
          notes: _notes.text.trim(),
        );
    if (!mounted) return;
    Navigator.pop(context);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível salvar — tente novamente')),
      );
    }
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
          Text('Editar ${widget.item.card.name}',
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
            decoration: const InputDecoration(labelText: 'Notas'),
            maxLength: 1000,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
