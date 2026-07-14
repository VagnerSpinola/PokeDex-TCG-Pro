import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tcg_pro/features/cards/domain/card_models.dart';
import 'package:pokedex_tcg_pro/features/cards/domain/price_series.dart';

PriceInfo _p(String source, String variant, String date,
        {double? market, double? mid, String currency = 'USD'}) =>
    PriceInfo(
      source: source,
      variant: variant,
      date: date,
      currency: currency,
      market: market,
      mid: mid,
    );

void main() {
  test('groups by source+variant and sorts points by date', () {
    final series = buildPriceSeries([
      _p('tcgplayer', 'holofoil', '2026-07-14', market: 60),
      _p('tcgplayer', 'holofoil', '2026-07-12', market: 55),
      _p('tcgplayer', 'normal', '2026-07-13', market: 5),
      _p('cardmarket', 'default', '2026-07-13', market: 48, currency: 'EUR'),
    ]);

    expect(series, hasLength(3));
    final holo = series.firstWhere((s) => s.variant == 'holofoil');
    expect(holo.points.map((p) => p.value), [55, 60]); // date-ascending
    expect(holo.label, 'TCGplayer · Holofoil');
    expect(holo.currencySymbol, r'$');

    final cm = series.firstWhere((s) => s.source == 'cardmarket');
    expect(cm.label, 'Cardmarket');
    expect(cm.currencySymbol, '€');
  });

  test('series with most points come first', () {
    final series = buildPriceSeries([
      _p('cardmarket', 'default', '2026-07-13', market: 1, currency: 'EUR'),
      _p('tcgplayer', 'normal', '2026-07-12', market: 2),
      _p('tcgplayer', 'normal', '2026-07-13', market: 3),
    ]);
    expect(series.first.source, 'tcgplayer');
    expect(series.first.points, hasLength(2));
  });

  test('falls back to mid and drops unusable rows', () {
    final series = buildPriceSeries([
      _p('tcgplayer', 'normal', '2026-07-13', mid: 4.5), // no market -> mid
      _p('tcgplayer', 'normal', '2026-07-14'), // no value at all -> dropped
      _p('tcgplayer', 'normal', 'not-a-date', market: 9), // bad date -> dropped
    ]);
    expect(series, hasLength(1));
    expect(series.first.points.single.value, 4.5);
  });

  test('empty history yields no series', () {
    expect(buildPriceSeries([]), isEmpty);
  });
}
