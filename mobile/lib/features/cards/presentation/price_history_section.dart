import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../data/cards_repository.dart';
import '../domain/price_series.dart';

const _periods = [30, 90, 365];

class PriceHistorySection extends ConsumerStatefulWidget {
  const PriceHistorySection({super.key, required this.cardId});

  final String cardId;

  @override
  ConsumerState<PriceHistorySection> createState() => _PriceHistorySectionState();
}

class _PriceHistorySectionState extends ConsumerState<PriceHistorySection> {
  int _days = 90;
  int _seriesIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final history =
        ref.watch(priceHistoryProvider((cardId: widget.cardId, days: _days)));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Histórico de preços', style: theme.textTheme.titleMedium),
                ),
                SegmentedButton<int>(
                  segments: [
                    for (final d in _periods)
                      ButtonSegment(value: d, label: Text('${d}d')),
                  ],
                  selected: {_days},
                  onSelectionChanged: (s) => setState(() => _days = s.first),
                  showSelectedIcon: false,
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 11)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            history.when(
              loading: () => const SizedBox(
                height: 160,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, _) => const SizedBox(
                height: 80,
                child: Center(child: Text('Não foi possível carregar o histórico')),
              ),
              data: (rows) {
                final series = buildPriceSeries(rows);
                if (series.isEmpty) {
                  return const _EmptyHistory();
                }
                final selected =
                    series[_seriesIndex.clamp(0, series.length - 1)];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (var i = 0; i < series.length; i++)
                          ChoiceChip(
                            label: Text(series[i].label,
                                style: const TextStyle(fontSize: 11)),
                            selected: i == _seriesIndex.clamp(0, series.length - 1),
                            onSelected: (_) => setState(() => _seriesIndex = i),
                            selectedColor: const Color(0x3346E3FF),
                            showCheckmark: false,
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _SeriesChart(series: selected),
                    if (selected.points.length < 3)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Histórico em construção — novos pontos entram a cada '
                          'sincronização diária de preços.',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 80,
      child: Center(
        child: Text(
          'Sem histórico neste período — os pontos entram a cada\n'
          'sincronização diária de preços.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}

class _SeriesChart extends StatelessWidget {
  const _SeriesChart({required this.series});

  final PriceSeries series;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final points = series.points;
    final spots = [
      for (final p in points)
        FlSpot(p.date.millisecondsSinceEpoch.toDouble(), p.value),
    ];

    final values = points.map((p) => p.value).toList();
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final pad = (maxY - minY) == 0 ? (maxY == 0 ? 1 : maxY * 0.2) : (maxY - minY) * 0.25;

    String fmtDate(double ms) {
      final d = DateTime.fromMillisecondsSinceEpoch(ms.toInt());
      return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
    }

    return SizedBox(
      height: 180,
      child: LineChart(
        LineChartData(
          minY: (minY - pad).clamp(0, double.infinity),
          maxY: maxY + pad,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (_) =>
                const FlLine(color: Color(0x14FFFFFF), strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 52,
                getTitlesWidget: (v, _) => Text(
                  '${series.currencySymbol}${v.toStringAsFixed(v >= 100 ? 0 : 1)}',
                  style: const TextStyle(fontSize: 9, color: inkDim),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                getTitlesWidget: (v, meta) {
                  if (v == meta.min || v == meta.max) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(fmtDate(v),
                          style: const TextStyle(fontSize: 9, color: inkDim)),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touched) => [
                for (final t in touched)
                  LineTooltipItem(
                    '${fmtDate(t.x)}\n${series.currencySymbol}${t.y.toStringAsFixed(2)}',
                    TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: points.length > 2,
              curveSmoothness: 0.25,
              barWidth: 2.5,
              gradient: const LinearGradient(colors: [holoCyan, holoViolet]),
              dotData: FlDotData(show: points.length <= 12),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [holoCyan.withValues(alpha: 0.18), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
