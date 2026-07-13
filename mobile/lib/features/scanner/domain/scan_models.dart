import 'package:freezed_annotation/freezed_annotation.dart';

import '../../cards/domain/card_models.dart';

part 'scan_models.freezed.dart';
part 'scan_models.g.dart';

@freezed
abstract class ScanCandidate with _$ScanCandidate {
  const factory ScanCandidate({
    required TcgCard card,
    required double score,
    required String confidence, // high | medium | low
  }) = _ScanCandidate;

  factory ScanCandidate.fromJson(Map<String, dynamic> json) =>
      _$ScanCandidateFromJson(json);
}

@freezed
abstract class ScanResult with _$ScanResult {
  const factory ScanResult({
    required List<ScanCandidate> candidates,
    @JsonKey(name: 'low_confidence') required bool lowConfidence,
    @JsonKey(name: 'name_guess') String? nameGuess,
    required String disclaimer,
  }) = _ScanResult;

  factory ScanResult.fromJson(Map<String, dynamic> json) => _$ScanResultFromJson(json);
}
