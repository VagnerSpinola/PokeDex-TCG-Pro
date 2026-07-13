import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_models.freezed.dart';
part 'card_models.g.dart';

@freezed
abstract class SetInfo with _$SetInfo {
  const factory SetInfo({
    required String id,
    required String name,
    String? series,
    @JsonKey(name: 'printed_total') int? printedTotal,
    int? total,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'symbol_url') String? symbolUrl,
    @JsonKey(name: 'logo_url') String? logoUrl,
  }) = _SetInfo;

  factory SetInfo.fromJson(Map<String, dynamic> json) => _$SetInfoFromJson(json);
}

@freezed
abstract class PriceInfo with _$PriceInfo {
  const factory PriceInfo({
    required String source,
    required String variant,
    required String date,
    required String currency,
    double? low,
    double? mid,
    double? high,
    double? market,
  }) = _PriceInfo;

  factory PriceInfo.fromJson(Map<String, dynamic> json) => _$PriceInfoFromJson(json);
}

@freezed
abstract class TcgCard with _$TcgCard {
  const factory TcgCard({
    required String id,
    required String name,
    @JsonKey(name: 'set_id') required String setId,
    String? number,
    String? supertype,
    List<String>? subtypes,
    List<String>? types,
    String? rarity,
    int? hp,
    String? artist,
    @JsonKey(name: 'image_small_url') String? imageSmallUrl,
    @JsonKey(name: 'image_large_url') String? imageLargeUrl,
    @JsonKey(name: 'flavor_text') String? flavorText,
    SetInfo? set,
    // Latest market snapshot per source/variant; only present on the detail
    // endpoint and empty until the price sync has run.
    @Default([]) List<PriceInfo> prices,
  }) = _TcgCard;

  factory TcgCard.fromJson(Map<String, dynamic> json) => _$TcgCardFromJson(json);
}

@freezed
abstract class PaginatedCards with _$PaginatedCards {
  const factory PaginatedCards({
    required List<TcgCard> items,
    required int page,
    @JsonKey(name: 'page_size') required int pageSize,
    required int total,
  }) = _PaginatedCards;

  factory PaginatedCards.fromJson(Map<String, dynamic> json) => _$PaginatedCardsFromJson(json);
}

@freezed
abstract class CardFilters with _$CardFilters {
  const factory CardFilters({
    @Default('') String query,
    String? setId,
    String? rarity,
    String? supertype,
    String? type,
  }) = _CardFilters;
}
