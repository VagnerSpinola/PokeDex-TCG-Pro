// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grading_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GradeSubScores _$GradeSubScoresFromJson(Map<String, dynamic> json) =>
    _GradeSubScores(
      centering: (json['centering'] as num).toDouble(),
      corners: (json['corners'] as num).toDouble(),
      edges: (json['edges'] as num).toDouble(),
      surface: (json['surface'] as num).toDouble(),
    );

Map<String, dynamic> _$GradeSubScoresToJson(_GradeSubScores instance) =>
    <String, dynamic>{
      'centering': instance.centering,
      'corners': instance.corners,
      'edges': instance.edges,
      'surface': instance.surface,
    };

_CenteringInfo _$CenteringInfoFromJson(Map<String, dynamic> json) =>
    _CenteringInfo(
      leftRight: json['left_right'] as String,
      topBottom: json['top_bottom'] as String,
      cap: (json['cap'] as num).toDouble(),
    );

Map<String, dynamic> _$CenteringInfoToJson(_CenteringInfo instance) =>
    <String, dynamic>{
      'left_right': instance.leftRight,
      'top_bottom': instance.topBottom,
      'cap': instance.cap,
    };

_CornerInfo _$CornerInfoFromJson(Map<String, dynamic> json) => _CornerInfo(
  corner: json['corner'] as String,
  whiteningPct: (json['whitening_pct'] as num).toDouble(),
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$CornerInfoToJson(_CornerInfo instance) =>
    <String, dynamic>{
      'corner': instance.corner,
      'whitening_pct': instance.whiteningPct,
      'score': instance.score,
    };

_EdgeInfo _$EdgeInfoFromJson(Map<String, dynamic> json) => _EdgeInfo(
  edge: json['edge'] as String,
  whiteningPct: (json['whitening_pct'] as num).toDouble(),
  clustered: json['clustered'] as bool,
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$EdgeInfoToJson(_EdgeInfo instance) => <String, dynamic>{
  'edge': instance.edge,
  'whitening_pct': instance.whiteningPct,
  'clustered': instance.clustered,
  'score': instance.score,
};

_SurfaceInfo _$SurfaceInfoFromJson(Map<String, dynamic> json) => _SurfaceInfo(
  glarePct: (json['glare_pct'] as num).toDouble(),
  scratchIndex: (json['scratch_index'] as num).toDouble(),
  creaseDetected: json['crease_detected'] as bool,
  severeCrease: json['severe_crease'] as bool,
  printLine: json['print_line'] as bool,
  score: (json['score'] as num).toDouble(),
);

Map<String, dynamic> _$SurfaceInfoToJson(_SurfaceInfo instance) =>
    <String, dynamic>{
      'glare_pct': instance.glarePct,
      'scratch_index': instance.scratchIndex,
      'crease_detected': instance.creaseDetected,
      'severe_crease': instance.severeCrease,
      'print_line': instance.printLine,
      'score': instance.score,
    };

_QualityInfo _$QualityInfoFromJson(Map<String, dynamic> json) => _QualityInfo(
  ok: json['ok'] as bool,
  sharpness: (json['sharpness'] as num).toDouble(),
  glarePct: (json['glare_pct'] as num).toDouble(),
  issues: (json['issues'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$QualityInfoToJson(_QualityInfo instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'sharpness': instance.sharpness,
      'glare_pct': instance.glarePct,
      'issues': instance.issues,
    };

_GradeEstimate _$GradeEstimateFromJson(Map<String, dynamic> json) =>
    _GradeEstimate(
      experimental: json['experimental'] as bool,
      estimatedGrade: (json['estimated_grade'] as num).toDouble(),
      gradeRange: (json['grade_range'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      subScores: GradeSubScores.fromJson(
        json['sub_scores'] as Map<String, dynamic>,
      ),
      centering: CenteringInfo.fromJson(
        json['centering'] as Map<String, dynamic>,
      ),
      corners: (json['corners'] as List<dynamic>)
          .map((e) => CornerInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List<dynamic>)
          .map((e) => EdgeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      surface: SurfaceInfo.fromJson(json['surface'] as Map<String, dynamic>),
      quality: QualityInfo.fromJson(json['quality'] as Map<String, dynamic>),
      framesAnalyzed: (json['frames_analyzed'] as num).toInt(),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      disclaimer: json['disclaimer'] as String,
    );

Map<String, dynamic> _$GradeEstimateToJson(_GradeEstimate instance) =>
    <String, dynamic>{
      'experimental': instance.experimental,
      'estimated_grade': instance.estimatedGrade,
      'grade_range': instance.gradeRange,
      'sub_scores': instance.subScores,
      'centering': instance.centering,
      'corners': instance.corners,
      'edges': instance.edges,
      'surface': instance.surface,
      'quality': instance.quality,
      'frames_analyzed': instance.framesAnalyzed,
      'warnings': instance.warnings,
      'disclaimer': instance.disclaimer,
    };
