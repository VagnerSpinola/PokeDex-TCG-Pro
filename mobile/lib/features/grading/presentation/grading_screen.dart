import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../data/grading_repository.dart';
import '../domain/grading_models.dart';

class GradingScreen extends ConsumerStatefulWidget {
  const GradingScreen({super.key});

  @override
  ConsumerState<GradingScreen> createState() => _GradingScreenState();
}

class _GradingScreenState extends ConsumerState<GradingScreen> {
  final _picker = ImagePicker();
  GradeEstimate? _estimate;
  bool _working = false;
  String? _error;

  bool get _cameraAvailable => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<void> _pick(ImageSource source) async {
    final file = await _picker.pickImage(source: source, maxWidth: 1600, imageQuality: 92);
    if (file == null) return;
    setState(() {
      _working = true;
      _estimate = null;
      _error = null;
    });
    try {
      final bytes = await file.readAsBytes();
      final estimate =
          await ref.read(gradingRepositoryProvider).gradePhoto(bytes, file.name);
      if (!mounted) return;
      setState(() => _estimate = estimate);
    } on DioException catch (e) {
      if (!mounted) return;
      final detail = e.response?.data;
      setState(() => _error = detail is Map && detail['detail'] is String
          ? detail['detail'] as String
          : 'Não foi possível avaliar — tente novamente');
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = 'Não foi possível avaliar — tente novamente');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliação de condição'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              label: const Text('EXPERIMENTAL'),
              backgroundColor: theme.colorScheme.errorContainer,
              labelStyle: TextStyle(
                color: theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Envie uma foto da carta inteira, sobre um fundo contrastante e sem reflexo.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (_cameraAvailable) ...[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _working ? null : () => _pick(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Câmera'),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _working ? null : () => _pick(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galeria'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_working)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_error!, textAlign: TextAlign.center),
            ),
          if (_estimate != null) ..._buildResult(theme, _estimate!),
        ],
      ),
    );
  }

  List<Widget> _buildResult(ThemeData theme, GradeEstimate estimate) {
    return [
      Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Nota estimada', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                estimate.estimatedGrade.toStringAsFixed(1),
                style: theme.textTheme.displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('de 10 — estimativa, não é nota oficial',
                  style: theme.textTheme.bodySmall),
              const SizedBox(height: 16),
              _ScoreBar(label: 'Centralização', value: estimate.subScores.centering),
              _ScoreBar(label: 'Cantos', value: estimate.subScores.corners),
              _ScoreBar(label: 'Bordas', value: estimate.subScores.edges),
              _ScoreBar(label: 'Superfície', value: estimate.subScores.surface),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      for (final w in estimate.warnings)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 16),
              const SizedBox(width: 6),
              Expanded(child: Text(w, style: theme.textTheme.bodySmall)),
            ],
          ),
        ),
      const SizedBox(height: 8),
      Card(
        color: theme.colorScheme.errorContainer,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            estimate.disclaimer,
            style: TextStyle(color: theme.colorScheme.onErrorContainer),
          ),
        ),
      ),
    ];
  }
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(label, style: theme.textTheme.bodyMedium)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(value: value / 10, minHeight: 8),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(width: 32, child: Text(value.toStringAsFixed(1))),
        ],
      ),
    );
  }
}
