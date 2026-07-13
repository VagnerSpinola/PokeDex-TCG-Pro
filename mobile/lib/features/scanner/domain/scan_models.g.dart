// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanCandidate _$ScanCandidateFromJson(Map<String, dynamic> json) =>
    _ScanCandidate(
      card: TcgCard.fromJson(json['card'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
      confidence: json['confidence'] as String,
    );

Map<String, dynamic> _$ScanCandidateToJson(_ScanCandidate instance) =>
    <String, dynamic>{
      'card': instance.card,
      'score': instance.score,
      'confidence': instance.confidence,
    };

_ScanResult _$ScanResultFromJson(Map<String, dynamic> json) => _ScanResult(
  candidates: (json['candidates'] as List<dynamic>)
      .map((e) => ScanCandidate.fromJson(e as Map<String, dynamic>))
      .toList(),
  lowConfidence: json['low_confidence'] as bool,
  nameGuess: json['name_guess'] as String?,
  disclaimer: json['disclaimer'] as String,
);

Map<String, dynamic> _$ScanResultToJson(_ScanResult instance) =>
    <String, dynamic>{
      'candidates': instance.candidates,
      'low_confidence': instance.lowConfidence,
      'name_guess': instance.nameGuess,
      'disclaimer': instance.disclaimer,
    };
