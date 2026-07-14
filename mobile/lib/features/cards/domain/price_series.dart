import 'card_models.dart';

/// One plottable line: a (source, variant) pair with its dated market values.
class PriceSeries {
  const PriceSeries({
    required this.source,
    required this.variant,
    required this.currency,
    required this.points,
  });

  final String source;
  final String variant;
  final String currency;

  /// Sorted by date ascending; value = market price (mid as fallback).
  final List<({DateTime date, double value})> points;

  static const _sourceLabels = {'tcgplayer': 'TCGplayer', 'cardmarket': 'Cardmarket'};

  String get label {
    final src = _sourceLabels[source] ?? source;
    if (variant == 'default') return src;
    final words = variant.replaceAllMapped(
        RegExp('([a-z0-9])([A-Z])'), (m) => '${m[1]} ${m[2]}');
    return '$src · ${words[0].toUpperCase()}${words.substring(1)}';
  }

  String get currencySymbol => currency == 'EUR' ? '€' : r'$';
}

/// Groups raw history rows into plottable series, dropping entries without a
/// usable value. Series are ordered by most data points first.
List<PriceSeries> buildPriceSeries(List<PriceInfo> history) {
  final grouped = <(String, String), List<PriceInfo>>{};
  for (final p in history) {
    grouped.putIfAbsent((p.source, p.variant), () => []).add(p);
  }

  final series = <PriceSeries>[];
  for (final entry in grouped.entries) {
    final parsed = <({DateTime date, double value})>[];
    for (final p in entry.value) {
      final value = p.market ?? p.mid;
      final date = DateTime.tryParse(p.date);
      if (value == null || date == null) continue;
      parsed.add((date: date, value: value));
    }
    if (parsed.isEmpty) continue;
    parsed.sort((a, b) => a.date.compareTo(b.date));
    series.add(PriceSeries(
      source: entry.key.$1,
      variant: entry.key.$2,
      currency: entry.value.first.currency,
      points: parsed,
    ));
  }
  series.sort((a, b) => b.points.length.compareTo(a.points.length));
  return series;
}
