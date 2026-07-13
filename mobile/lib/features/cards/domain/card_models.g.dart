// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SetInfo _$SetInfoFromJson(Map<String, dynamic> json) => _SetInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  series: json['series'] as String?,
  printedTotal: (json['printed_total'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  releaseDate: json['release_date'] as String?,
  symbolUrl: json['symbol_url'] as String?,
  logoUrl: json['logo_url'] as String?,
);

Map<String, dynamic> _$SetInfoToJson(_SetInfo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'series': instance.series,
  'printed_total': instance.printedTotal,
  'total': instance.total,
  'release_date': instance.releaseDate,
  'symbol_url': instance.symbolUrl,
  'logo_url': instance.logoUrl,
};

_PriceInfo _$PriceInfoFromJson(Map<String, dynamic> json) => _PriceInfo(
  source: json['source'] as String,
  variant: json['variant'] as String,
  date: json['date'] as String,
  currency: json['currency'] as String,
  low: (json['low'] as num?)?.toDouble(),
  mid: (json['mid'] as num?)?.toDouble(),
  high: (json['high'] as num?)?.toDouble(),
  market: (json['market'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PriceInfoToJson(_PriceInfo instance) =>
    <String, dynamic>{
      'source': instance.source,
      'variant': instance.variant,
      'date': instance.date,
      'currency': instance.currency,
      'low': instance.low,
      'mid': instance.mid,
      'high': instance.high,
      'market': instance.market,
    };

_TcgCard _$TcgCardFromJson(Map<String, dynamic> json) => _TcgCard(
  id: json['id'] as String,
  name: json['name'] as String,
  setId: json['set_id'] as String,
  number: json['number'] as String?,
  supertype: json['supertype'] as String?,
  subtypes: (json['subtypes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
  rarity: json['rarity'] as String?,
  hp: (json['hp'] as num?)?.toInt(),
  artist: json['artist'] as String?,
  imageSmallUrl: json['image_small_url'] as String?,
  imageLargeUrl: json['image_large_url'] as String?,
  flavorText: json['flavor_text'] as String?,
  set: json['set'] == null
      ? null
      : SetInfo.fromJson(json['set'] as Map<String, dynamic>),
  prices:
      (json['prices'] as List<dynamic>?)
          ?.map((e) => PriceInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TcgCardToJson(_TcgCard instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'set_id': instance.setId,
  'number': instance.number,
  'supertype': instance.supertype,
  'subtypes': instance.subtypes,
  'types': instance.types,
  'rarity': instance.rarity,
  'hp': instance.hp,
  'artist': instance.artist,
  'image_small_url': instance.imageSmallUrl,
  'image_large_url': instance.imageLargeUrl,
  'flavor_text': instance.flavorText,
  'set': instance.set,
  'prices': instance.prices,
};

_PaginatedCards _$PaginatedCardsFromJson(Map<String, dynamic> json) =>
    _PaginatedCards(
      items: (json['items'] as List<dynamic>)
          .map((e) => TcgCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$PaginatedCardsToJson(_PaginatedCards instance) =>
    <String, dynamic>{
      'items': instance.items,
      'page': instance.page,
      'page_size': instance.pageSize,
      'total': instance.total,
    };
