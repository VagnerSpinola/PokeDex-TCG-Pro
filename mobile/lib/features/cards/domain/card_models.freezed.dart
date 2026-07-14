// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SetInfo {

 String get id; String get name; String? get series;@JsonKey(name: 'printed_total') int? get printedTotal; int? get total;@JsonKey(name: 'release_date') String? get releaseDate;@JsonKey(name: 'symbol_url') String? get symbolUrl;@JsonKey(name: 'logo_url') String? get logoUrl;
/// Create a copy of SetInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetInfoCopyWith<SetInfo> get copyWith => _$SetInfoCopyWithImpl<SetInfo>(this as SetInfo, _$identity);

  /// Serializes this SetInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.series, series) || other.series == series)&&(identical(other.printedTotal, printedTotal) || other.printedTotal == printedTotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.symbolUrl, symbolUrl) || other.symbolUrl == symbolUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,series,printedTotal,total,releaseDate,symbolUrl,logoUrl);

@override
String toString() {
  return 'SetInfo(id: $id, name: $name, series: $series, printedTotal: $printedTotal, total: $total, releaseDate: $releaseDate, symbolUrl: $symbolUrl, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $SetInfoCopyWith<$Res>  {
  factory $SetInfoCopyWith(SetInfo value, $Res Function(SetInfo) _then) = _$SetInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? series,@JsonKey(name: 'printed_total') int? printedTotal, int? total,@JsonKey(name: 'release_date') String? releaseDate,@JsonKey(name: 'symbol_url') String? symbolUrl,@JsonKey(name: 'logo_url') String? logoUrl
});




}
/// @nodoc
class _$SetInfoCopyWithImpl<$Res>
    implements $SetInfoCopyWith<$Res> {
  _$SetInfoCopyWithImpl(this._self, this._then);

  final SetInfo _self;
  final $Res Function(SetInfo) _then;

/// Create a copy of SetInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? series = freezed,Object? printedTotal = freezed,Object? total = freezed,Object? releaseDate = freezed,Object? symbolUrl = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,printedTotal: freezed == printedTotal ? _self.printedTotal : printedTotal // ignore: cast_nullable_to_non_nullable
as int?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,symbolUrl: freezed == symbolUrl ? _self.symbolUrl : symbolUrl // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SetInfo].
extension SetInfoPatterns on SetInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetInfo value)  $default,){
final _that = this;
switch (_that) {
case _SetInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SetInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? series, @JsonKey(name: 'printed_total')  int? printedTotal,  int? total, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'symbol_url')  String? symbolUrl, @JsonKey(name: 'logo_url')  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetInfo() when $default != null:
return $default(_that.id,_that.name,_that.series,_that.printedTotal,_that.total,_that.releaseDate,_that.symbolUrl,_that.logoUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? series, @JsonKey(name: 'printed_total')  int? printedTotal,  int? total, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'symbol_url')  String? symbolUrl, @JsonKey(name: 'logo_url')  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _SetInfo():
return $default(_that.id,_that.name,_that.series,_that.printedTotal,_that.total,_that.releaseDate,_that.symbolUrl,_that.logoUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? series, @JsonKey(name: 'printed_total')  int? printedTotal,  int? total, @JsonKey(name: 'release_date')  String? releaseDate, @JsonKey(name: 'symbol_url')  String? symbolUrl, @JsonKey(name: 'logo_url')  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _SetInfo() when $default != null:
return $default(_that.id,_that.name,_that.series,_that.printedTotal,_that.total,_that.releaseDate,_that.symbolUrl,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetInfo implements SetInfo {
  const _SetInfo({required this.id, required this.name, this.series, @JsonKey(name: 'printed_total') this.printedTotal, this.total, @JsonKey(name: 'release_date') this.releaseDate, @JsonKey(name: 'symbol_url') this.symbolUrl, @JsonKey(name: 'logo_url') this.logoUrl});
  factory _SetInfo.fromJson(Map<String, dynamic> json) => _$SetInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? series;
@override@JsonKey(name: 'printed_total') final  int? printedTotal;
@override final  int? total;
@override@JsonKey(name: 'release_date') final  String? releaseDate;
@override@JsonKey(name: 'symbol_url') final  String? symbolUrl;
@override@JsonKey(name: 'logo_url') final  String? logoUrl;

/// Create a copy of SetInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetInfoCopyWith<_SetInfo> get copyWith => __$SetInfoCopyWithImpl<_SetInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.series, series) || other.series == series)&&(identical(other.printedTotal, printedTotal) || other.printedTotal == printedTotal)&&(identical(other.total, total) || other.total == total)&&(identical(other.releaseDate, releaseDate) || other.releaseDate == releaseDate)&&(identical(other.symbolUrl, symbolUrl) || other.symbolUrl == symbolUrl)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,series,printedTotal,total,releaseDate,symbolUrl,logoUrl);

@override
String toString() {
  return 'SetInfo(id: $id, name: $name, series: $series, printedTotal: $printedTotal, total: $total, releaseDate: $releaseDate, symbolUrl: $symbolUrl, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$SetInfoCopyWith<$Res> implements $SetInfoCopyWith<$Res> {
  factory _$SetInfoCopyWith(_SetInfo value, $Res Function(_SetInfo) _then) = __$SetInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? series,@JsonKey(name: 'printed_total') int? printedTotal, int? total,@JsonKey(name: 'release_date') String? releaseDate,@JsonKey(name: 'symbol_url') String? symbolUrl,@JsonKey(name: 'logo_url') String? logoUrl
});




}
/// @nodoc
class __$SetInfoCopyWithImpl<$Res>
    implements _$SetInfoCopyWith<$Res> {
  __$SetInfoCopyWithImpl(this._self, this._then);

  final _SetInfo _self;
  final $Res Function(_SetInfo) _then;

/// Create a copy of SetInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? series = freezed,Object? printedTotal = freezed,Object? total = freezed,Object? releaseDate = freezed,Object? symbolUrl = freezed,Object? logoUrl = freezed,}) {
  return _then(_SetInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,series: freezed == series ? _self.series : series // ignore: cast_nullable_to_non_nullable
as String?,printedTotal: freezed == printedTotal ? _self.printedTotal : printedTotal // ignore: cast_nullable_to_non_nullable
as int?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int?,releaseDate: freezed == releaseDate ? _self.releaseDate : releaseDate // ignore: cast_nullable_to_non_nullable
as String?,symbolUrl: freezed == symbolUrl ? _self.symbolUrl : symbolUrl // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PriceInfo {

 String get source; String get variant; String get date; String get currency; double? get low; double? get mid; double? get high; double? get market;
/// Create a copy of PriceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceInfoCopyWith<PriceInfo> get copyWith => _$PriceInfoCopyWithImpl<PriceInfo>(this as PriceInfo, _$identity);

  /// Serializes this PriceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceInfo&&(identical(other.source, source) || other.source == source)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.date, date) || other.date == date)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.market, market) || other.market == market));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,variant,date,currency,low,mid,high,market);

@override
String toString() {
  return 'PriceInfo(source: $source, variant: $variant, date: $date, currency: $currency, low: $low, mid: $mid, high: $high, market: $market)';
}


}

/// @nodoc
abstract mixin class $PriceInfoCopyWith<$Res>  {
  factory $PriceInfoCopyWith(PriceInfo value, $Res Function(PriceInfo) _then) = _$PriceInfoCopyWithImpl;
@useResult
$Res call({
 String source, String variant, String date, String currency, double? low, double? mid, double? high, double? market
});




}
/// @nodoc
class _$PriceInfoCopyWithImpl<$Res>
    implements $PriceInfoCopyWith<$Res> {
  _$PriceInfoCopyWithImpl(this._self, this._then);

  final PriceInfo _self;
  final $Res Function(PriceInfo) _then;

/// Create a copy of PriceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? variant = null,Object? date = null,Object? currency = null,Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? market = freezed,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,market: freezed == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceInfo].
extension PriceInfoPatterns on PriceInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceInfo value)  $default,){
final _that = this;
switch (_that) {
case _PriceInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PriceInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String source,  String variant,  String date,  String currency,  double? low,  double? mid,  double? high,  double? market)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceInfo() when $default != null:
return $default(_that.source,_that.variant,_that.date,_that.currency,_that.low,_that.mid,_that.high,_that.market);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String source,  String variant,  String date,  String currency,  double? low,  double? mid,  double? high,  double? market)  $default,) {final _that = this;
switch (_that) {
case _PriceInfo():
return $default(_that.source,_that.variant,_that.date,_that.currency,_that.low,_that.mid,_that.high,_that.market);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String source,  String variant,  String date,  String currency,  double? low,  double? mid,  double? high,  double? market)?  $default,) {final _that = this;
switch (_that) {
case _PriceInfo() when $default != null:
return $default(_that.source,_that.variant,_that.date,_that.currency,_that.low,_that.mid,_that.high,_that.market);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceInfo implements PriceInfo {
  const _PriceInfo({required this.source, required this.variant, required this.date, required this.currency, this.low, this.mid, this.high, this.market});
  factory _PriceInfo.fromJson(Map<String, dynamic> json) => _$PriceInfoFromJson(json);

@override final  String source;
@override final  String variant;
@override final  String date;
@override final  String currency;
@override final  double? low;
@override final  double? mid;
@override final  double? high;
@override final  double? market;

/// Create a copy of PriceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceInfoCopyWith<_PriceInfo> get copyWith => __$PriceInfoCopyWithImpl<_PriceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceInfo&&(identical(other.source, source) || other.source == source)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.date, date) || other.date == date)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.low, low) || other.low == low)&&(identical(other.mid, mid) || other.mid == mid)&&(identical(other.high, high) || other.high == high)&&(identical(other.market, market) || other.market == market));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,variant,date,currency,low,mid,high,market);

@override
String toString() {
  return 'PriceInfo(source: $source, variant: $variant, date: $date, currency: $currency, low: $low, mid: $mid, high: $high, market: $market)';
}


}

/// @nodoc
abstract mixin class _$PriceInfoCopyWith<$Res> implements $PriceInfoCopyWith<$Res> {
  factory _$PriceInfoCopyWith(_PriceInfo value, $Res Function(_PriceInfo) _then) = __$PriceInfoCopyWithImpl;
@override @useResult
$Res call({
 String source, String variant, String date, String currency, double? low, double? mid, double? high, double? market
});




}
/// @nodoc
class __$PriceInfoCopyWithImpl<$Res>
    implements _$PriceInfoCopyWith<$Res> {
  __$PriceInfoCopyWithImpl(this._self, this._then);

  final _PriceInfo _self;
  final $Res Function(_PriceInfo) _then;

/// Create a copy of PriceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? variant = null,Object? date = null,Object? currency = null,Object? low = freezed,Object? mid = freezed,Object? high = freezed,Object? market = freezed,}) {
  return _then(_PriceInfo(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,low: freezed == low ? _self.low : low // ignore: cast_nullable_to_non_nullable
as double?,mid: freezed == mid ? _self.mid : mid // ignore: cast_nullable_to_non_nullable
as double?,high: freezed == high ? _self.high : high // ignore: cast_nullable_to_non_nullable
as double?,market: freezed == market ? _self.market : market // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$TcgCard {

 String get id; String get name;@JsonKey(name: 'set_id') String get setId; String? get number; String? get supertype; List<String>? get subtypes; List<String>? get types; String? get rarity; int? get hp; String? get artist;@JsonKey(name: 'image_small_url') String? get imageSmallUrl;@JsonKey(name: 'image_large_url') String? get imageLargeUrl;@JsonKey(name: 'flavor_text') String? get flavorText; SetInfo? get set;// Latest market snapshot per source/variant; only present on the detail
// endpoint and empty until the price sync has run.
 List<PriceInfo> get prices;
/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TcgCardCopyWith<TcgCard> get copyWith => _$TcgCardCopyWithImpl<TcgCard>(this as TcgCard, _$identity);

  /// Serializes this TcgCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TcgCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.number, number) || other.number == number)&&(identical(other.supertype, supertype) || other.supertype == supertype)&&const DeepCollectionEquality().equals(other.subtypes, subtypes)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.imageSmallUrl, imageSmallUrl) || other.imageSmallUrl == imageSmallUrl)&&(identical(other.imageLargeUrl, imageLargeUrl) || other.imageLargeUrl == imageLargeUrl)&&(identical(other.flavorText, flavorText) || other.flavorText == flavorText)&&(identical(other.set, set) || other.set == set)&&const DeepCollectionEquality().equals(other.prices, prices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,setId,number,supertype,const DeepCollectionEquality().hash(subtypes),const DeepCollectionEquality().hash(types),rarity,hp,artist,imageSmallUrl,imageLargeUrl,flavorText,set,const DeepCollectionEquality().hash(prices));

@override
String toString() {
  return 'TcgCard(id: $id, name: $name, setId: $setId, number: $number, supertype: $supertype, subtypes: $subtypes, types: $types, rarity: $rarity, hp: $hp, artist: $artist, imageSmallUrl: $imageSmallUrl, imageLargeUrl: $imageLargeUrl, flavorText: $flavorText, set: $set, prices: $prices)';
}


}

/// @nodoc
abstract mixin class $TcgCardCopyWith<$Res>  {
  factory $TcgCardCopyWith(TcgCard value, $Res Function(TcgCard) _then) = _$TcgCardCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'set_id') String setId, String? number, String? supertype, List<String>? subtypes, List<String>? types, String? rarity, int? hp, String? artist,@JsonKey(name: 'image_small_url') String? imageSmallUrl,@JsonKey(name: 'image_large_url') String? imageLargeUrl,@JsonKey(name: 'flavor_text') String? flavorText, SetInfo? set, List<PriceInfo> prices
});


$SetInfoCopyWith<$Res>? get set;

}
/// @nodoc
class _$TcgCardCopyWithImpl<$Res>
    implements $TcgCardCopyWith<$Res> {
  _$TcgCardCopyWithImpl(this._self, this._then);

  final TcgCard _self;
  final $Res Function(TcgCard) _then;

/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? setId = null,Object? number = freezed,Object? supertype = freezed,Object? subtypes = freezed,Object? types = freezed,Object? rarity = freezed,Object? hp = freezed,Object? artist = freezed,Object? imageSmallUrl = freezed,Object? imageLargeUrl = freezed,Object? flavorText = freezed,Object? set = freezed,Object? prices = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,setId: null == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,supertype: freezed == supertype ? _self.supertype : supertype // ignore: cast_nullable_to_non_nullable
as String?,subtypes: freezed == subtypes ? _self.subtypes : subtypes // ignore: cast_nullable_to_non_nullable
as List<String>?,types: freezed == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>?,rarity: freezed == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String?,hp: freezed == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,imageSmallUrl: freezed == imageSmallUrl ? _self.imageSmallUrl : imageSmallUrl // ignore: cast_nullable_to_non_nullable
as String?,imageLargeUrl: freezed == imageLargeUrl ? _self.imageLargeUrl : imageLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,flavorText: freezed == flavorText ? _self.flavorText : flavorText // ignore: cast_nullable_to_non_nullable
as String?,set: freezed == set ? _self.set : set // ignore: cast_nullable_to_non_nullable
as SetInfo?,prices: null == prices ? _self.prices : prices // ignore: cast_nullable_to_non_nullable
as List<PriceInfo>,
  ));
}
/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SetInfoCopyWith<$Res>? get set {
    if (_self.set == null) {
    return null;
  }

  return $SetInfoCopyWith<$Res>(_self.set!, (value) {
    return _then(_self.copyWith(set: value));
  });
}
}


/// Adds pattern-matching-related methods to [TcgCard].
extension TcgCardPatterns on TcgCard {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TcgCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TcgCard() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TcgCard value)  $default,){
final _that = this;
switch (_that) {
case _TcgCard():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TcgCard value)?  $default,){
final _that = this;
switch (_that) {
case _TcgCard() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'set_id')  String setId,  String? number,  String? supertype,  List<String>? subtypes,  List<String>? types,  String? rarity,  int? hp,  String? artist, @JsonKey(name: 'image_small_url')  String? imageSmallUrl, @JsonKey(name: 'image_large_url')  String? imageLargeUrl, @JsonKey(name: 'flavor_text')  String? flavorText,  SetInfo? set,  List<PriceInfo> prices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TcgCard() when $default != null:
return $default(_that.id,_that.name,_that.setId,_that.number,_that.supertype,_that.subtypes,_that.types,_that.rarity,_that.hp,_that.artist,_that.imageSmallUrl,_that.imageLargeUrl,_that.flavorText,_that.set,_that.prices);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'set_id')  String setId,  String? number,  String? supertype,  List<String>? subtypes,  List<String>? types,  String? rarity,  int? hp,  String? artist, @JsonKey(name: 'image_small_url')  String? imageSmallUrl, @JsonKey(name: 'image_large_url')  String? imageLargeUrl, @JsonKey(name: 'flavor_text')  String? flavorText,  SetInfo? set,  List<PriceInfo> prices)  $default,) {final _that = this;
switch (_that) {
case _TcgCard():
return $default(_that.id,_that.name,_that.setId,_that.number,_that.supertype,_that.subtypes,_that.types,_that.rarity,_that.hp,_that.artist,_that.imageSmallUrl,_that.imageLargeUrl,_that.flavorText,_that.set,_that.prices);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'set_id')  String setId,  String? number,  String? supertype,  List<String>? subtypes,  List<String>? types,  String? rarity,  int? hp,  String? artist, @JsonKey(name: 'image_small_url')  String? imageSmallUrl, @JsonKey(name: 'image_large_url')  String? imageLargeUrl, @JsonKey(name: 'flavor_text')  String? flavorText,  SetInfo? set,  List<PriceInfo> prices)?  $default,) {final _that = this;
switch (_that) {
case _TcgCard() when $default != null:
return $default(_that.id,_that.name,_that.setId,_that.number,_that.supertype,_that.subtypes,_that.types,_that.rarity,_that.hp,_that.artist,_that.imageSmallUrl,_that.imageLargeUrl,_that.flavorText,_that.set,_that.prices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TcgCard implements TcgCard {
  const _TcgCard({required this.id, required this.name, @JsonKey(name: 'set_id') required this.setId, this.number, this.supertype, final  List<String>? subtypes, final  List<String>? types, this.rarity, this.hp, this.artist, @JsonKey(name: 'image_small_url') this.imageSmallUrl, @JsonKey(name: 'image_large_url') this.imageLargeUrl, @JsonKey(name: 'flavor_text') this.flavorText, this.set, final  List<PriceInfo> prices = const []}): _subtypes = subtypes,_types = types,_prices = prices;
  factory _TcgCard.fromJson(Map<String, dynamic> json) => _$TcgCardFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'set_id') final  String setId;
@override final  String? number;
@override final  String? supertype;
 final  List<String>? _subtypes;
@override List<String>? get subtypes {
  final value = _subtypes;
  if (value == null) return null;
  if (_subtypes is EqualUnmodifiableListView) return _subtypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _types;
@override List<String>? get types {
  final value = _types;
  if (value == null) return null;
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? rarity;
@override final  int? hp;
@override final  String? artist;
@override@JsonKey(name: 'image_small_url') final  String? imageSmallUrl;
@override@JsonKey(name: 'image_large_url') final  String? imageLargeUrl;
@override@JsonKey(name: 'flavor_text') final  String? flavorText;
@override final  SetInfo? set;
// Latest market snapshot per source/variant; only present on the detail
// endpoint and empty until the price sync has run.
 final  List<PriceInfo> _prices;
// Latest market snapshot per source/variant; only present on the detail
// endpoint and empty until the price sync has run.
@override@JsonKey() List<PriceInfo> get prices {
  if (_prices is EqualUnmodifiableListView) return _prices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prices);
}


/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TcgCardCopyWith<_TcgCard> get copyWith => __$TcgCardCopyWithImpl<_TcgCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TcgCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TcgCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.number, number) || other.number == number)&&(identical(other.supertype, supertype) || other.supertype == supertype)&&const DeepCollectionEquality().equals(other._subtypes, _subtypes)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.rarity, rarity) || other.rarity == rarity)&&(identical(other.hp, hp) || other.hp == hp)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.imageSmallUrl, imageSmallUrl) || other.imageSmallUrl == imageSmallUrl)&&(identical(other.imageLargeUrl, imageLargeUrl) || other.imageLargeUrl == imageLargeUrl)&&(identical(other.flavorText, flavorText) || other.flavorText == flavorText)&&(identical(other.set, set) || other.set == set)&&const DeepCollectionEquality().equals(other._prices, _prices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,setId,number,supertype,const DeepCollectionEquality().hash(_subtypes),const DeepCollectionEquality().hash(_types),rarity,hp,artist,imageSmallUrl,imageLargeUrl,flavorText,set,const DeepCollectionEquality().hash(_prices));

@override
String toString() {
  return 'TcgCard(id: $id, name: $name, setId: $setId, number: $number, supertype: $supertype, subtypes: $subtypes, types: $types, rarity: $rarity, hp: $hp, artist: $artist, imageSmallUrl: $imageSmallUrl, imageLargeUrl: $imageLargeUrl, flavorText: $flavorText, set: $set, prices: $prices)';
}


}

/// @nodoc
abstract mixin class _$TcgCardCopyWith<$Res> implements $TcgCardCopyWith<$Res> {
  factory _$TcgCardCopyWith(_TcgCard value, $Res Function(_TcgCard) _then) = __$TcgCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'set_id') String setId, String? number, String? supertype, List<String>? subtypes, List<String>? types, String? rarity, int? hp, String? artist,@JsonKey(name: 'image_small_url') String? imageSmallUrl,@JsonKey(name: 'image_large_url') String? imageLargeUrl,@JsonKey(name: 'flavor_text') String? flavorText, SetInfo? set, List<PriceInfo> prices
});


@override $SetInfoCopyWith<$Res>? get set;

}
/// @nodoc
class __$TcgCardCopyWithImpl<$Res>
    implements _$TcgCardCopyWith<$Res> {
  __$TcgCardCopyWithImpl(this._self, this._then);

  final _TcgCard _self;
  final $Res Function(_TcgCard) _then;

/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? setId = null,Object? number = freezed,Object? supertype = freezed,Object? subtypes = freezed,Object? types = freezed,Object? rarity = freezed,Object? hp = freezed,Object? artist = freezed,Object? imageSmallUrl = freezed,Object? imageLargeUrl = freezed,Object? flavorText = freezed,Object? set = freezed,Object? prices = null,}) {
  return _then(_TcgCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,setId: null == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String,number: freezed == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String?,supertype: freezed == supertype ? _self.supertype : supertype // ignore: cast_nullable_to_non_nullable
as String?,subtypes: freezed == subtypes ? _self._subtypes : subtypes // ignore: cast_nullable_to_non_nullable
as List<String>?,types: freezed == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>?,rarity: freezed == rarity ? _self.rarity : rarity // ignore: cast_nullable_to_non_nullable
as String?,hp: freezed == hp ? _self.hp : hp // ignore: cast_nullable_to_non_nullable
as int?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,imageSmallUrl: freezed == imageSmallUrl ? _self.imageSmallUrl : imageSmallUrl // ignore: cast_nullable_to_non_nullable
as String?,imageLargeUrl: freezed == imageLargeUrl ? _self.imageLargeUrl : imageLargeUrl // ignore: cast_nullable_to_non_nullable
as String?,flavorText: freezed == flavorText ? _self.flavorText : flavorText // ignore: cast_nullable_to_non_nullable
as String?,set: freezed == set ? _self.set : set // ignore: cast_nullable_to_non_nullable
as SetInfo?,prices: null == prices ? _self._prices : prices // ignore: cast_nullable_to_non_nullable
as List<PriceInfo>,
  ));
}

/// Create a copy of TcgCard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SetInfoCopyWith<$Res>? get set {
    if (_self.set == null) {
    return null;
  }

  return $SetInfoCopyWith<$Res>(_self.set!, (value) {
    return _then(_self.copyWith(set: value));
  });
}
}


/// @nodoc
mixin _$PaginatedCards {

 List<TcgCard> get items; int get page;@JsonKey(name: 'page_size') int get pageSize; int get total;
/// Create a copy of PaginatedCards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedCardsCopyWith<PaginatedCards> get copyWith => _$PaginatedCardsCopyWithImpl<PaginatedCards>(this as PaginatedCards, _$identity);

  /// Serializes this PaginatedCards to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedCards&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),page,pageSize,total);

@override
String toString() {
  return 'PaginatedCards(items: $items, page: $page, pageSize: $pageSize, total: $total)';
}


}

/// @nodoc
abstract mixin class $PaginatedCardsCopyWith<$Res>  {
  factory $PaginatedCardsCopyWith(PaginatedCards value, $Res Function(PaginatedCards) _then) = _$PaginatedCardsCopyWithImpl;
@useResult
$Res call({
 List<TcgCard> items, int page,@JsonKey(name: 'page_size') int pageSize, int total
});




}
/// @nodoc
class _$PaginatedCardsCopyWithImpl<$Res>
    implements $PaginatedCardsCopyWith<$Res> {
  _$PaginatedCardsCopyWithImpl(this._self, this._then);

  final PaginatedCards _self;
  final $Res Function(PaginatedCards) _then;

/// Create a copy of PaginatedCards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? total = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<TcgCard>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedCards].
extension PaginatedCardsPatterns on PaginatedCards {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedCards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedCards() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedCards value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedCards():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedCards value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedCards() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TcgCard> items,  int page, @JsonKey(name: 'page_size')  int pageSize,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedCards() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TcgCard> items,  int page, @JsonKey(name: 'page_size')  int pageSize,  int total)  $default,) {final _that = this;
switch (_that) {
case _PaginatedCards():
return $default(_that.items,_that.page,_that.pageSize,_that.total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TcgCard> items,  int page, @JsonKey(name: 'page_size')  int pageSize,  int total)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedCards() when $default != null:
return $default(_that.items,_that.page,_that.pageSize,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedCards implements PaginatedCards {
  const _PaginatedCards({required final  List<TcgCard> items, required this.page, @JsonKey(name: 'page_size') required this.pageSize, required this.total}): _items = items;
  factory _PaginatedCards.fromJson(Map<String, dynamic> json) => _$PaginatedCardsFromJson(json);

 final  List<TcgCard> _items;
@override List<TcgCard> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override@JsonKey(name: 'page_size') final  int pageSize;
@override final  int total;

/// Create a copy of PaginatedCards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedCardsCopyWith<_PaginatedCards> get copyWith => __$PaginatedCardsCopyWithImpl<_PaginatedCards>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedCardsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedCards&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,pageSize,total);

@override
String toString() {
  return 'PaginatedCards(items: $items, page: $page, pageSize: $pageSize, total: $total)';
}


}

/// @nodoc
abstract mixin class _$PaginatedCardsCopyWith<$Res> implements $PaginatedCardsCopyWith<$Res> {
  factory _$PaginatedCardsCopyWith(_PaginatedCards value, $Res Function(_PaginatedCards) _then) = __$PaginatedCardsCopyWithImpl;
@override @useResult
$Res call({
 List<TcgCard> items, int page,@JsonKey(name: 'page_size') int pageSize, int total
});




}
/// @nodoc
class __$PaginatedCardsCopyWithImpl<$Res>
    implements _$PaginatedCardsCopyWith<$Res> {
  __$PaginatedCardsCopyWithImpl(this._self, this._then);

  final _PaginatedCards _self;
  final $Res Function(_PaginatedCards) _then;

/// Create a copy of PaginatedCards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? pageSize = null,Object? total = null,}) {
  return _then(_PaginatedCards(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<TcgCard>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$CardFilters {

 String get query;// Multi-select: empty list = no filter.
 List<String> get setIds; List<String> get rarities; String? get supertype; String? get type;
/// Create a copy of CardFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardFiltersCopyWith<CardFilters> get copyWith => _$CardFiltersCopyWithImpl<CardFilters>(this as CardFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardFilters&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.setIds, setIds)&&const DeepCollectionEquality().equals(other.rarities, rarities)&&(identical(other.supertype, supertype) || other.supertype == supertype)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(setIds),const DeepCollectionEquality().hash(rarities),supertype,type);

@override
String toString() {
  return 'CardFilters(query: $query, setIds: $setIds, rarities: $rarities, supertype: $supertype, type: $type)';
}


}

/// @nodoc
abstract mixin class $CardFiltersCopyWith<$Res>  {
  factory $CardFiltersCopyWith(CardFilters value, $Res Function(CardFilters) _then) = _$CardFiltersCopyWithImpl;
@useResult
$Res call({
 String query, List<String> setIds, List<String> rarities, String? supertype, String? type
});




}
/// @nodoc
class _$CardFiltersCopyWithImpl<$Res>
    implements $CardFiltersCopyWith<$Res> {
  _$CardFiltersCopyWithImpl(this._self, this._then);

  final CardFilters _self;
  final $Res Function(CardFilters) _then;

/// Create a copy of CardFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? setIds = null,Object? rarities = null,Object? supertype = freezed,Object? type = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,setIds: null == setIds ? _self.setIds : setIds // ignore: cast_nullable_to_non_nullable
as List<String>,rarities: null == rarities ? _self.rarities : rarities // ignore: cast_nullable_to_non_nullable
as List<String>,supertype: freezed == supertype ? _self.supertype : supertype // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CardFilters].
extension CardFiltersPatterns on CardFilters {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardFilters() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardFilters value)  $default,){
final _that = this;
switch (_that) {
case _CardFilters():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardFilters value)?  $default,){
final _that = this;
switch (_that) {
case _CardFilters() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<String> setIds,  List<String> rarities,  String? supertype,  String? type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardFilters() when $default != null:
return $default(_that.query,_that.setIds,_that.rarities,_that.supertype,_that.type);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<String> setIds,  List<String> rarities,  String? supertype,  String? type)  $default,) {final _that = this;
switch (_that) {
case _CardFilters():
return $default(_that.query,_that.setIds,_that.rarities,_that.supertype,_that.type);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<String> setIds,  List<String> rarities,  String? supertype,  String? type)?  $default,) {final _that = this;
switch (_that) {
case _CardFilters() when $default != null:
return $default(_that.query,_that.setIds,_that.rarities,_that.supertype,_that.type);case _:
  return null;

}
}

}

/// @nodoc


class _CardFilters extends CardFilters {
  const _CardFilters({this.query = '', final  List<String> setIds = const [], final  List<String> rarities = const [], this.supertype, this.type}): _setIds = setIds,_rarities = rarities,super._();
  

@override@JsonKey() final  String query;
// Multi-select: empty list = no filter.
 final  List<String> _setIds;
// Multi-select: empty list = no filter.
@override@JsonKey() List<String> get setIds {
  if (_setIds is EqualUnmodifiableListView) return _setIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_setIds);
}

 final  List<String> _rarities;
@override@JsonKey() List<String> get rarities {
  if (_rarities is EqualUnmodifiableListView) return _rarities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rarities);
}

@override final  String? supertype;
@override final  String? type;

/// Create a copy of CardFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardFiltersCopyWith<_CardFilters> get copyWith => __$CardFiltersCopyWithImpl<_CardFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardFilters&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._setIds, _setIds)&&const DeepCollectionEquality().equals(other._rarities, _rarities)&&(identical(other.supertype, supertype) || other.supertype == supertype)&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_setIds),const DeepCollectionEquality().hash(_rarities),supertype,type);

@override
String toString() {
  return 'CardFilters(query: $query, setIds: $setIds, rarities: $rarities, supertype: $supertype, type: $type)';
}


}

/// @nodoc
abstract mixin class _$CardFiltersCopyWith<$Res> implements $CardFiltersCopyWith<$Res> {
  factory _$CardFiltersCopyWith(_CardFilters value, $Res Function(_CardFilters) _then) = __$CardFiltersCopyWithImpl;
@override @useResult
$Res call({
 String query, List<String> setIds, List<String> rarities, String? supertype, String? type
});




}
/// @nodoc
class __$CardFiltersCopyWithImpl<$Res>
    implements _$CardFiltersCopyWith<$Res> {
  __$CardFiltersCopyWithImpl(this._self, this._then);

  final _CardFilters _self;
  final $Res Function(_CardFilters) _then;

/// Create a copy of CardFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? setIds = null,Object? rarities = null,Object? supertype = freezed,Object? type = freezed,}) {
  return _then(_CardFilters(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,setIds: null == setIds ? _self._setIds : setIds // ignore: cast_nullable_to_non_nullable
as List<String>,rarities: null == rarities ? _self._rarities : rarities // ignore: cast_nullable_to_non_nullable
as List<String>,supertype: freezed == supertype ? _self.supertype : supertype // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
