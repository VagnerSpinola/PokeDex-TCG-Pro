import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_tcg_pro/features/grading/domain/grading_models.dart';

void main() {
  test('GradeEstimate parses the v2 API payload', () {
    final estimate = GradeEstimate.fromJson({
      'experimental': true,
      'estimated_grade': 7.5,
      'grade_range': [7.0, 8.5],
      'sub_scores': {'centering': 8.0, 'corners': 7.5, 'edges': 9.0, 'surface': 8.5},
      'centering': {'left_right': '57/43', 'top_bottom': '60/40', 'cap': 9.0},
      'corners': [
        {'corner': 'top_left', 'whitening_pct': 0.02, 'score': 9.5},
        {'corner': 'top_right', 'whitening_pct': 0.0, 'score': 10.0},
        {'corner': 'bottom_left', 'whitening_pct': 0.15, 'score': 7.0},
        {'corner': 'bottom_right', 'whitening_pct': 0.01, 'score': 9.8},
      ],
      'edges': [
        {'edge': 'top', 'whitening_pct': 0.01, 'clustered': false, 'score': 9.8},
        {'edge': 'bottom', 'whitening_pct': 0.05, 'clustered': true, 'score': 7.5},
        {'edge': 'left', 'whitening_pct': 0.0, 'clustered': false, 'score': 10.0},
        {'edge': 'right', 'whitening_pct': 0.0, 'clustered': false, 'score': 10.0},
      ],
      'surface': {
        'glare_pct': 0.01,
        'scratch_index': 0.002,
        'crease_detected': false,
        'severe_crease': false,
        'print_line': true,
        'score': 9.0,
      },
      'quality': {'ok': true, 'sharpness': 250.0, 'glare_pct': 0.01, 'issues': []},
      'frames_analyzed': 5,
      'warnings': ['Consenso de 5 quadros do vídeo'],
      'disclaimer': 'Estimativa experimental — NÃO é uma avaliação oficial.',
    });

    expect(estimate.estimatedGrade, 7.5);
    expect(estimate.gradeRange, [7.0, 8.5]);
    expect(estimate.centering.leftRight, '57/43');
    expect(estimate.centering.cap, 9.0);
    expect(estimate.corners, hasLength(4));
    expect(estimate.corners[2].score, 7.0);
    expect(estimate.edges[1].clustered, isTrue);
    expect(estimate.surface.printLine, isTrue);
    expect(estimate.quality.ok, isTrue);
    expect(estimate.framesAnalyzed, 5);
    expect(estimate.disclaimer, contains('NÃO é uma avaliação oficial'));
  });
}
