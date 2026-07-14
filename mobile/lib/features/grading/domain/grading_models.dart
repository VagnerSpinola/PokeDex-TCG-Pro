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
abstract class CenteringInfo with _$CenteringInfo {
  const factory CenteringInfo({
    @JsonKey(name: 'left_right') required String leftRight,
    @JsonKey(name: 'top_bottom') required String topBottom,
    required double cap,
  }) = _CenteringInfo;

  factory CenteringInfo.fromJson(Map<String, dynamic> json) =>
      _$CenteringInfoFromJson(json);
}

@freezed
abstract class CornerInfo with _$CornerInfo {
  const factory CornerInfo({
    required String corner,
    @JsonKey(name: 'whitening_pct') required double whiteningPct,
    required double score,
  }) = _CornerInfo;

  factory CornerInfo.fromJson(Map<String, dynamic> json) => _$CornerInfoFromJson(json);
}

@freezed
abstract class EdgeInfo with _$EdgeInfo {
  const factory EdgeInfo({
    required String edge,
    @JsonKey(name: 'whitening_pct') required double whiteningPct,
    required bool clustered,
    required double score,
  }) = _EdgeInfo;

  factory EdgeInfo.fromJson(Map<String, dynamic> json) => _$EdgeInfoFromJson(json);
}

@freezed
abstract class SurfaceInfo with _$SurfaceInfo {
  const factory SurfaceInfo({
    @JsonKey(name: 'glare_pct') required double glarePct,
    @JsonKey(name: 'scratch_index') required double scratchIndex,
    @JsonKey(name: 'crease_detected') required bool creaseDetected,
    @JsonKey(name: 'severe_crease') required bool severeCrease,
    @JsonKey(name: 'print_line') required bool printLine,
    required double score,
  }) = _SurfaceInfo;

  factory SurfaceInfo.fromJson(Map<String, dynamic> json) => _$SurfaceInfoFromJson(json);
}

@freezed
abstract class QualityInfo with _$QualityInfo {
  const factory QualityInfo({
    required bool ok,
    required double sharpness,
    @JsonKey(name: 'glare_pct') required double glarePct,
    required List<String> issues,
  }) = _QualityInfo;

  factory QualityInfo.fromJson(Map<String, dynamic> json) => _$QualityInfoFromJson(json);
}

@freezed
abstract class GradeEstimate with _$GradeEstimate {
  const factory GradeEstimate({
    required bool experimental,
    @JsonKey(name: 'estimated_grade') required double estimatedGrade,
    @JsonKey(name: 'grade_range') required List<double> gradeRange,
    @JsonKey(name: 'sub_scores') required GradeSubScores subScores,
    required CenteringInfo centering,
    required List<CornerInfo> corners,
    required List<EdgeInfo> edges,
    required SurfaceInfo surface,
    required QualityInfo quality,
    @JsonKey(name: 'frames_analyzed') required int framesAnalyzed,
    required List<String> warnings,
    required String disclaimer,
  }) = _GradeEstimate;

  factory GradeEstimate.fromJson(Map<String, dynamic> json) =>
      _$GradeEstimateFromJson(json);
}
