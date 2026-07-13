import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tcg_pro/features/scanner/domain/scan_models.dart';

import '../../helpers.dart';

void main() {
  test('ScanResult parses API payload', () {
    final result = ScanResult.fromJson({
      'candidates': [
        {
          'card': {'id': 'sv1-25', 'name': 'Pikachu', 'set_id': 'sv1'},
          'score': 0.94,
          'confidence': 'high',
        },
      ],
      'low_confidence': false,
      'name_guess': 'Pikachu',
      'disclaimer': 'Correspondência estimada — confirme a carta.',
    });

    expect(result.candidates, hasLength(1));
    expect(result.candidates.first.card.name, 'Pikachu');
    expect(result.candidates.first.confidence, 'high');
    expect(result.lowConfidence, isFalse);
    expect(result.nameGuess, 'Pikachu');
  });

  test('ScanCandidate keeps card data intact', () {
    const candidate = ScanCandidate(card: pikachu, score: 0.9, confidence: 'medium');
    expect(candidate.card.id, 'sv1-25');
    expect(candidate.score, 0.9);
  });
}
