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

_GradeEstimate _$GradeEstimateFromJson(Map<String, dynamic> json) =>
    _GradeEstimate(
      experimental: json['experimental'] as bool,
      estimatedGrade: (json['estimated_grade'] as num).toDouble(),
      subScores: GradeSubScores.fromJson(
        json['sub_scores'] as Map<String, dynamic>,
      ),
      warnings: (json['warnings'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      disclaimer: json['disclaimer'] as String,
    );

Map<String, dynamic> _$GradeEstimateToJson(_GradeEstimate instance) =>
    <String, dynamic>{
      'experimental': instance.experimental,
      'estimated_grade': instance.estimatedGrade,
      'sub_scores': instance.subScores,
      'warnings': instance.warnings,
      'disclaimer': instance.disclaimer,
    };
