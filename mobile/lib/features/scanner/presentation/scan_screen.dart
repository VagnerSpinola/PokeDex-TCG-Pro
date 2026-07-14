import 'dart:io' show Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../cards/presentation/cards_notifier.dart';
import '../../collection/presentation/add_to_collection_sheet.dart';
import '../data/scan_repository.dart';
import '../domain/scan_models.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _picker = ImagePicker();
  ScanResult? _result;
  bool _scanning = false;
  String? _error;

  Future<void> _pick(ImageSource source) async {
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      imageQuality: 85,
    );
    if (file == null) return;
    setState(() {
      _scanning = true;
      _result = null;
      _error = null;
    });
    try {
      final bytes = await file.readAsBytes();
      final result =
          await ref.read(scanRepositoryProvider).scanPhoto(bytes, file.name);
      if (!mounted) return;
      setState(() => _result = result);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Não foi possível escanear — tente novamente');
    } finally {
      if (mounted) setState(() => _scanning = false);
    }
  }

  void _manualSearch() {
    final guess = _result?.nameGuess;
    if (guess != null) {
      ref.read(cardsNotifierProvider.notifier).setQuery(guess);
    }
    context.go('/cards');
  }

  bool get _cameraAvailable =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear carta')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              if (_cameraAvailable) ...[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _scanning ? null : () => _pick(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Câmera'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _scanning ? null : () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galeria'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_scanning)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_error!, textAlign: TextAlign.center),
            ),
          if (_result != null) ..._buildResult(context, _result!),
        ],
      ),
    );
  }

  List<Widget> _buildResult(BuildContext context, ScanResult result) {
    final theme = Theme.of(context);
    return [
      if (result.lowConfidence)
        Card(
          color: theme.colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: theme.colorScheme.onErrorContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Não temos certeza do resultado — confira com atenção ou use a busca manual.',
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                ),
              ],
            ),
          ),
        ),
      const SizedBox(height: 8),
      if (result.candidates.isEmpty)
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text('Nenhuma carta parecida encontrada.', textAlign: TextAlign.center),
        )
      else ...[
        Text('É alguma destas?', style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final c in result.candidates) _CandidateTile(candidate: c),
      ],
      const SizedBox(height: 8),
      OutlinedButton.icon(
        onPressed: _manualSearch,
        icon: const Icon(Icons.search),
        label: Text(
          result.nameGuess != null
              ? 'Não é nenhuma — buscar "${result.nameGuess}"'
              : 'Não é nenhuma — buscar manualmente',
        ),
      ),
      const SizedBox(height: 8),
      Text(
        result.disclaimer,
        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.outline),
        textAlign: TextAlign.center,
      ),
    ];
  }
}

class _CandidateTile extends StatelessWidget {
  const _CandidateTile({required this.candidate});

  final ScanCandidate candidate;

  static const _labels = {'high': 'Alta', 'medium': 'Média', 'low': 'Baixa'};

  Color _badgeColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (candidate.confidence) {
      'high' => scheme.primaryContainer,
      'medium' => scheme.tertiaryContainer,
      _ => scheme.errorContainer,
    };
  }

  @override
  Widget build(BuildContext context) {
    final card = candidate.card;
    return Card(
      child: ListTile(
        leading: card.imageSmallUrl != null
            ? CachedNetworkImage(imageUrl: card.imageSmallUrl!, width: 40)
            : const Icon(Icons.style),
        title: Text(card.name),
        subtitle: Text(
          '${card.setId} · ${card.rarity ?? ''} · similaridade '
          '${(candidate.score * 100).toStringAsFixed(0)}% · '
          '${_labels[candidate.confidence] ?? candidate.confidence}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline, size: 28),
          tooltip: 'Adicionar à coleção',
          color: _badgeColor(context) == Theme.of(context).colorScheme.errorContainer
              ? Theme.of(context).colorScheme.error
              : null,
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => AddToCollectionSheet(card: card),
          ),
        ),
        onTap: () => context.push('/cards/${card.id}'),
      ),
    );
  }
}
