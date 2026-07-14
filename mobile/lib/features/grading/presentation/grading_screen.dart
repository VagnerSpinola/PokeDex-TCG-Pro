import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/holo.dart';
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

  Future<void> _run(Future<GradeEstimate> Function() task) async {
    setState(() {
      _working = true;
      _estimate = null;
      _error = null;
    });
    try {
      final estimate = await task();
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

  Future<void> _pickPhoto(ImageSource source) async {
    final file = await _picker.pickImage(source: source, maxWidth: 2000, imageQuality: 95);
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await _run(() => ref.read(gradingRepositoryProvider).gradePhoto(bytes, file.name));
  }

  Future<void> _pickVideo() async {
    final file = await _picker.pickVideo(
      source: _cameraAvailable ? ImageSource.camera : ImageSource.gallery,
      maxDuration: const Duration(seconds: 15),
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    await _run(() => ref.read(gradingRepositoryProvider).gradeVideo(bytes, file.name));
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
            'Análise nos padrões publicados da PSA: centralização, cantos, bordas e '
            'superfície. Foto: carta inteira, fundo contrastante, luz difusa em 45° '
            'dos dois lados, sem flash. Vídeo (melhor): 3–10s inclinando a carta '
            'lentamente sob a luz, em 1080p.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (_cameraAvailable) ...[
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _working ? null : () => _pickPhoto(ImageSource.camera),
                    icon: const Icon(Icons.photo_camera, size: 18),
                    label: const Text('Foto'),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _working ? null : () => _pickPhoto(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library, size: 18),
                  label: const Text('Galeria'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: _working ? null : _pickVideo,
                  icon: const Icon(Icons.videocam, size: 18),
                  label: const Text('Vídeo'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_working)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 12),
                    Text('Analisando pixel a pixel...'),
                  ],
                ),
              ),
            ),
          if (_error != null)
            Card(
              color: theme.colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(_error!,
                    style: TextStyle(color: theme.colorScheme.onErrorContainer)),
              ),
            ),
          if (_estimate != null) ..._buildResult(theme, _estimate!),
        ],
      ),
    );
  }

  List<Widget> _buildResult(ThemeData theme, GradeEstimate e) {
    return [
      if (!e.quality.ok)
        Card(
          color: theme.colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Qualidade da captura insuficiente — refaça:',
                    style: TextStyle(
                        color: theme.colorScheme.onErrorContainer,
                        fontWeight: FontWeight.w700)),
                for (final issue in e.quality.issues)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('• $issue',
                        style: TextStyle(color: theme.colorScheme.onErrorContainer)),
                  ),
              ],
            ),
          ),
        ),
      const SizedBox(height: 8),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text('Nota estimada (estilo PSA)', style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              HoloText(
                e.estimatedGrade.toStringAsFixed(1),
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w800),
              ),
              Text(
                'faixa ${e.gradeRange.first.toStringAsFixed(1)} – '
                '${e.gradeRange.last.toStringAsFixed(1)} · estimativa, não é nota oficial',
                style: theme.textTheme.bodySmall,
              ),
              if (e.framesAnalyzed > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('consenso de ${e.framesAnalyzed} quadros do vídeo',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: holoCyan, fontWeight: FontWeight.w600)),
                ),
              const SizedBox(height: 16),
              _ScoreBar(label: 'Centralização', value: e.subScores.centering),
              _ScoreBar(label: 'Cantos', value: e.subScores.corners),
              _ScoreBar(label: 'Bordas', value: e.subScores.edges),
              _ScoreBar(label: 'Superfície', value: e.subScores.surface),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Medições', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Text(
                'Centralização: ${e.centering.leftRight} (esq/dir) · '
                '${e.centering.topBottom} (topo/base) — teto PSA '
                '${e.centering.cap.toStringAsFixed(0)} pela tabela oficial',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              _CornerGrid(corners: e.corners),
              if (e.surface.creaseDetected ||
                  e.surface.printLine ||
                  e.surface.severeCrease) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  children: [
                    if (e.surface.severeCrease)
                      const _DefectChip('Vinco severo')
                    else if (e.surface.creaseDetected)
                      const _DefectChip('Possível vinco'),
                    if (e.surface.printLine) const _DefectChip('Possível print line'),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      for (final w in e.warnings)
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
            e.disclaimer,
            style: TextStyle(color: theme.colorScheme.onErrorContainer),
          ),
        ),
      ),
    ];
  }
}

class _DefectChip extends StatelessWidget {
  const _DefectChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Chip(
      label: Text(label,
          style: TextStyle(color: scheme.onErrorContainer, fontSize: 11)),
      backgroundColor: scheme.errorContainer,
      side: BorderSide.none,
    );
  }
}

class _CornerGrid extends StatelessWidget {
  const _CornerGrid({required this.corners});

  final List<CornerInfo> corners;

  static const _labels = {
    'top_left': 'Sup. esq.',
    'top_right': 'Sup. dir.',
    'bottom_left': 'Inf. esq.',
    'bottom_right': 'Inf. dir.',
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final c in corners)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0x14FFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: c.score >= 8
                    ? const Color(0x3346E3FF)
                    : theme.colorScheme.error.withValues(alpha: 0.5),
              ),
            ),
            child: Text(
              '${_labels[c.corner] ?? c.corner}: ${c.score.toStringAsFixed(1)}',
              style: theme.textTheme.bodySmall,
            ),
          ),
      ],
    );
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
