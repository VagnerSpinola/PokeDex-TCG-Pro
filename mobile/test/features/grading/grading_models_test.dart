import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tcg_pro/features/grading/domain/grading_models.dart';

void main() {
  test('GradeEstimate parses API payload with mandatory disclaimer', () {
    final estimate = GradeEstimate.fromJson({
      'experimental': true,
      'estimated_grade': 7.5,
      'sub_scores': {'centering': 8.0, 'corners': 6.5, 'edges': 9.0, 'surface': 8.5},
      'warnings': ['Foto possivelmente desfocada'],
      'disclaimer': 'Estimativa experimental — NÃO é uma avaliação oficial.',
    });

    expect(estimate.experimental, isTrue);
    expect(estimate.estimatedGrade, 7.5);
    expect(estimate.subScores.corners, 6.5);
    expect(estimate.warnings, hasLength(1));
    expect(estimate.disclaimer, contains('NÃO é uma avaliação oficial'));
  });
}
