import 'package:freezed_annotation/freezed_annotation.dart';

import '../../cards/domain/card_models.dart';

part 'collection_models.freezed.dart';
part 'collection_models.g.dart';

@freezed
abstract class CollectionItem with _$CollectionItem {
  const factory CollectionItem({
    required int id,
    @JsonKey(name: 'card_id') required String cardId,
    required int quantity,
    required String condition,
    String? notes,
    required TcgCard card,
  }) = _CollectionItem;

  factory CollectionItem.fromJson(Map<String, dynamic> json) => _$CollectionItemFromJson(json);
}

@freezed
abstract class SetCount with _$SetCount {
  const factory SetCount({
    @JsonKey(name: 'set_id') required String setId,
    @JsonKey(name: 'set_name') required String setName,
    required int count,
  }) = _SetCount;

  factory SetCount.fromJson(Map<String, dynamic> json) => _$SetCountFromJson(json);
}

@freezed
abstract class CollectionStats with _$CollectionStats {
  const factory CollectionStats({
    @JsonKey(name: 'total_cards') required int totalCards,
    @JsonKey(name: 'unique_cards') required int uniqueCards,
    required List<SetCount> sets,
  }) = _CollectionStats;

  factory CollectionStats.fromJson(Map<String, dynamic> json) =>
      _$CollectionStatsFromJson(json);
}

/// Card conditions accepted by the API (mirrors backend CardCondition enum).
const cardConditions = ['mint', 'near_mint', 'excellent', 'good', 'played', 'poor'];

const cardConditionLabels = {
  'mint': 'Mint',
  'near_mint': 'Near Mint',
  'excellent': 'Excelente',
  'good': 'Boa',
  'played': 'Jogada',
  'poor': 'Ruim',
};
