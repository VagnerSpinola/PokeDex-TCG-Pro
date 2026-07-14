// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) =>
    _CollectionItem(
      id: (json['id'] as num).toInt(),
      cardId: json['card_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      condition: json['condition'] as String,
      notes: json['notes'] as String?,
      card: TcgCard.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionItemToJson(_CollectionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'card_id': instance.cardId,
      'quantity': instance.quantity,
      'condition': instance.condition,
      'notes': instance.notes,
      'card': instance.card,
    };

_SetCount _$SetCountFromJson(Map<String, dynamic> json) => _SetCount(
  setId: json['set_id'] as String,
  setName: json['set_name'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$SetCountToJson(_SetCount instance) => <String, dynamic>{
  'set_id': instance.setId,
  'set_name': instance.setName,
  'count': instance.count,
};

_CollectionStats _$CollectionStatsFromJson(Map<String, dynamic> json) =>
    _CollectionStats(
      totalCards: (json['total_cards'] as num).toInt(),
      uniqueCards: (json['unique_cards'] as num).toInt(),
      sets: (json['sets'] as List<dynamic>)
          .map((e) => SetCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      valueUsd: (json['value_usd'] as num?)?.toDouble(),
      valueEur: (json['value_eur'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CollectionStatsToJson(_CollectionStats instance) =>
    <String, dynamic>{
      'total_cards': instance.totalCards,
      'unique_cards': instance.uniqueCards,
      'sets': instance.sets,
      'value_usd': instance.valueUsd,
      'value_eur': instance.valueEur,
    };
