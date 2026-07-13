import 'package:freezed_annotation/freezed_annotation.dart';

part 'grading_models.freezed.dart';
part 'grading_models.g.dart';

@freezed
abstract class GradeSubScores with _$GradeSubScores {
  const factory GradeSubScores({
    required double centering,
    required double corners,
    required double edges,
    required double surface,
  }) = _GradeSubScores;

  factory GradeSubScores.fromJson(Map<String, dynamic> json) =>
      _$GradeSubScoresFromJson(json);
}

@freezed
abstract class GradeEstimate with _$GradeEstimate {
  const factory GradeEstimate({
    required bool experimental,
    @JsonKey(name: 'estimated_grade') required double estimatedGrade,
    @JsonKey(name: 'sub_scores') required GradeSubScores subScores,
    required List<String> warnings,
    required String disclaimer,
  }) = _GradeEstimate;

  factory GradeEstimate.fromJson(Map<String, dynamic> json) =>
      _$GradeEstimateFromJson(json);
}
