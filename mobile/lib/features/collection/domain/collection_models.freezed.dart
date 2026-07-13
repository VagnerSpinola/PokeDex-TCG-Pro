// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionItem {

 int get id;@JsonKey(name: 'card_id') String get cardId; int get quantity; String get condition; String? get notes; TcgCard get card;
/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionItemCopyWith<CollectionItem> get copyWith => _$CollectionItemCopyWithImpl<CollectionItem>(this as CollectionItem, _$identity);

  /// Serializes this CollectionItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.card, card) || other.card == card));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardId,quantity,condition,notes,card);

@override
String toString() {
  return 'CollectionItem(id: $id, cardId: $cardId, quantity: $quantity, condition: $condition, notes: $notes, card: $card)';
}


}

/// @nodoc
abstract mixin class $CollectionItemCopyWith<$Res>  {
  factory $CollectionItemCopyWith(CollectionItem value, $Res Function(CollectionItem) _then) = _$CollectionItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'card_id') String cardId, int quantity, String condition, String? notes, TcgCard card
});


$TcgCardCopyWith<$Res> get card;

}
/// @nodoc
class _$CollectionItemCopyWithImpl<$Res>
    implements $CollectionItemCopyWith<$Res> {
  _$CollectionItemCopyWithImpl(this._self, this._then);

  final CollectionItem _self;
  final $Res Function(CollectionItem) _then;

/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardId = null,Object? quantity = null,Object? condition = null,Object? notes = freezed,Object? card = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TcgCard,
  ));
}
/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TcgCardCopyWith<$Res> get card {
  
  return $TcgCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [CollectionItem].
extension CollectionItemPatterns on CollectionItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionItem value)  $default,){
final _that = this;
switch (_that) {
case _CollectionItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionItem value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'card_id')  String cardId,  int quantity,  String condition,  String? notes,  TcgCard card)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionItem() when $default != null:
return $default(_that.id,_that.cardId,_that.quantity,_that.condition,_that.notes,_that.card);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'card_id')  String cardId,  int quantity,  String condition,  String? notes,  TcgCard card)  $default,) {final _that = this;
switch (_that) {
case _CollectionItem():
return $default(_that.id,_that.cardId,_that.quantity,_that.condition,_that.notes,_that.card);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'card_id')  String cardId,  int quantity,  String condition,  String? notes,  TcgCard card)?  $default,) {final _that = this;
switch (_that) {
case _CollectionItem() when $default != null:
return $default(_that.id,_that.cardId,_that.quantity,_that.condition,_that.notes,_that.card);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionItem implements CollectionItem {
  const _CollectionItem({required this.id, @JsonKey(name: 'card_id') required this.cardId, required this.quantity, required this.condition, this.notes, required this.card});
  factory _CollectionItem.fromJson(Map<String, dynamic> json) => _$CollectionItemFromJson(json);

@override final  int id;
@override@JsonKey(name: 'card_id') final  String cardId;
@override final  int quantity;
@override final  String condition;
@override final  String? notes;
@override final  TcgCard card;

/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionItemCopyWith<_CollectionItem> get copyWith => __$CollectionItemCopyWithImpl<_CollectionItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionItem&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.condition, condition) || other.condition == condition)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.card, card) || other.card == card));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardId,quantity,condition,notes,card);

@override
String toString() {
  return 'CollectionItem(id: $id, cardId: $cardId, quantity: $quantity, condition: $condition, notes: $notes, card: $card)';
}


}

/// @nodoc
abstract mixin class _$CollectionItemCopyWith<$Res> implements $CollectionItemCopyWith<$Res> {
  factory _$CollectionItemCopyWith(_CollectionItem value, $Res Function(_CollectionItem) _then) = __$CollectionItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'card_id') String cardId, int quantity, String condition, String? notes, TcgCard card
});


@override $TcgCardCopyWith<$Res> get card;

}
/// @nodoc
class __$CollectionItemCopyWithImpl<$Res>
    implements _$CollectionItemCopyWith<$Res> {
  __$CollectionItemCopyWithImpl(this._self, this._then);

  final _CollectionItem _self;
  final $Res Function(_CollectionItem) _then;

/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardId = null,Object? quantity = null,Object? condition = null,Object? notes = freezed,Object? card = null,}) {
  return _then(_CollectionItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,condition: null == condition ? _self.condition : condition // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TcgCard,
  ));
}

/// Create a copy of CollectionItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TcgCardCopyWith<$Res> get card {
  
  return $TcgCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// @nodoc
mixin _$SetCount {

@JsonKey(name: 'set_id') String get setId;@JsonKey(name: 'set_name') String get setName; int get count;
/// Create a copy of SetCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetCountCopyWith<SetCount> get copyWith => _$SetCountCopyWithImpl<SetCount>(this as SetCount, _$identity);

  /// Serializes this SetCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetCount&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.setName, setName) || other.setName == setName)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setId,setName,count);

@override
String toString() {
  return 'SetCount(setId: $setId, setName: $setName, count: $count)';
}


}

/// @nodoc
abstract mixin class $SetCountCopyWith<$Res>  {
  factory $SetCountCopyWith(SetCount value, $Res Function(SetCount) _then) = _$SetCountCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'set_id') String setId,@JsonKey(name: 'set_name') String setName, int count
});




}
/// @nodoc
class _$SetCountCopyWithImpl<$Res>
    implements $SetCountCopyWith<$Res> {
  _$SetCountCopyWithImpl(this._self, this._then);

  final SetCount _self;
  final $Res Function(SetCount) _then;

/// Create a copy of SetCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setId = null,Object? setName = null,Object? count = null,}) {
  return _then(_self.copyWith(
setId: null == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String,setName: null == setName ? _self.setName : setName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SetCount].
extension SetCountPatterns on SetCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetCount value)  $default,){
final _that = this;
switch (_that) {
case _SetCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetCount value)?  $default,){
final _that = this;
switch (_that) {
case _SetCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'set_id')  String setId, @JsonKey(name: 'set_name')  String setName,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetCount() when $default != null:
return $default(_that.setId,_that.setName,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'set_id')  String setId, @JsonKey(name: 'set_name')  String setName,  int count)  $default,) {final _that = this;
switch (_that) {
case _SetCount():
return $default(_that.setId,_that.setName,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'set_id')  String setId, @JsonKey(name: 'set_name')  String setName,  int count)?  $default,) {final _that = this;
switch (_that) {
case _SetCount() when $default != null:
return $default(_that.setId,_that.setName,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetCount implements SetCount {
  const _SetCount({@JsonKey(name: 'set_id') required this.setId, @JsonKey(name: 'set_name') required this.setName, required this.count});
  factory _SetCount.fromJson(Map<String, dynamic> json) => _$SetCountFromJson(json);

@override@JsonKey(name: 'set_id') final  String setId;
@override@JsonKey(name: 'set_name') final  String setName;
@override final  int count;

/// Create a copy of SetCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetCountCopyWith<_SetCount> get copyWith => __$SetCountCopyWithImpl<_SetCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetCount&&(identical(other.setId, setId) || other.setId == setId)&&(identical(other.setName, setName) || other.setName == setName)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setId,setName,count);

@override
String toString() {
  return 'SetCount(setId: $setId, setName: $setName, count: $count)';
}


}

/// @nodoc
abstract mixin class _$SetCountCopyWith<$Res> implements $SetCountCopyWith<$Res> {
  factory _$SetCountCopyWith(_SetCount value, $Res Function(_SetCount) _then) = __$SetCountCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'set_id') String setId,@JsonKey(name: 'set_name') String setName, int count
});




}
/// @nodoc
class __$SetCountCopyWithImpl<$Res>
    implements _$SetCountCopyWith<$Res> {
  __$SetCountCopyWithImpl(this._self, this._then);

  final _SetCount _self;
  final $Res Function(_SetCount) _then;

/// Create a copy of SetCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setId = null,Object? setName = null,Object? count = null,}) {
  return _then(_SetCount(
setId: null == setId ? _self.setId : setId // ignore: cast_nullable_to_non_nullable
as String,setName: null == setName ? _self.setName : setName // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CollectionStats {

@JsonKey(name: 'total_cards') int get totalCards;@JsonKey(name: 'unique_cards') int get uniqueCards; List<SetCount> get sets;
/// Create a copy of CollectionStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionStatsCopyWith<CollectionStats> get copyWith => _$CollectionStatsCopyWithImpl<CollectionStats>(this as CollectionStats, _$identity);

  /// Serializes this CollectionStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionStats&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.uniqueCards, uniqueCards) || other.uniqueCards == uniqueCards)&&const DeepCollectionEquality().equals(other.sets, sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCards,uniqueCards,const DeepCollectionEquality().hash(sets));

@override
String toString() {
  return 'CollectionStats(totalCards: $totalCards, uniqueCards: $uniqueCards, sets: $sets)';
}


}

/// @nodoc
abstract mixin class $CollectionStatsCopyWith<$Res>  {
  factory $CollectionStatsCopyWith(CollectionStats value, $Res Function(CollectionStats) _then) = _$CollectionStatsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'total_cards') int totalCards,@JsonKey(name: 'unique_cards') int uniqueCards, List<SetCount> sets
});




}
/// @nodoc
class _$CollectionStatsCopyWithImpl<$Res>
    implements $CollectionStatsCopyWith<$Res> {
  _$CollectionStatsCopyWithImpl(this._self, this._then);

  final CollectionStats _self;
  final $Res Function(CollectionStats) _then;

/// Create a copy of CollectionStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalCards = null,Object? uniqueCards = null,Object? sets = null,}) {
  return _then(_self.copyWith(
totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,uniqueCards: null == uniqueCards ? _self.uniqueCards : uniqueCards // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetCount>,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionStats].
extension CollectionStatsPatterns on CollectionStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionStats value)  $default,){
final _that = this;
switch (_that) {
case _CollectionStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionStats value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_cards')  int totalCards, @JsonKey(name: 'unique_cards')  int uniqueCards,  List<SetCount> sets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionStats() when $default != null:
return $default(_that.totalCards,_that.uniqueCards,_that.sets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'total_cards')  int totalCards, @JsonKey(name: 'unique_cards')  int uniqueCards,  List<SetCount> sets)  $default,) {final _that = this;
switch (_that) {
case _CollectionStats():
return $default(_that.totalCards,_that.uniqueCards,_that.sets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'total_cards')  int totalCards, @JsonKey(name: 'unique_cards')  int uniqueCards,  List<SetCount> sets)?  $default,) {final _that = this;
switch (_that) {
case _CollectionStats() when $default != null:
return $default(_that.totalCards,_that.uniqueCards,_that.sets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CollectionStats implements CollectionStats {
  const _CollectionStats({@JsonKey(name: 'total_cards') required this.totalCards, @JsonKey(name: 'unique_cards') required this.uniqueCards, required final  List<SetCount> sets}): _sets = sets;
  factory _CollectionStats.fromJson(Map<String, dynamic> json) => _$CollectionStatsFromJson(json);

@override@JsonKey(name: 'total_cards') final  int totalCards;
@override@JsonKey(name: 'unique_cards') final  int uniqueCards;
 final  List<SetCount> _sets;
@override List<SetCount> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}


/// Create a copy of CollectionStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionStatsCopyWith<_CollectionStats> get copyWith => __$CollectionStatsCopyWithImpl<_CollectionStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionStats&&(identical(other.totalCards, totalCards) || other.totalCards == totalCards)&&(identical(other.uniqueCards, uniqueCards) || other.uniqueCards == uniqueCards)&&const DeepCollectionEquality().equals(other._sets, _sets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalCards,uniqueCards,const DeepCollectionEquality().hash(_sets));

@override
String toString() {
  return 'CollectionStats(totalCards: $totalCards, uniqueCards: $uniqueCards, sets: $sets)';
}


}

/// @nodoc
abstract mixin class _$CollectionStatsCopyWith<$Res> implements $CollectionStatsCopyWith<$Res> {
  factory _$CollectionStatsCopyWith(_CollectionStats value, $Res Function(_CollectionStats) _then) = __$CollectionStatsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'total_cards') int totalCards,@JsonKey(name: 'unique_cards') int uniqueCards, List<SetCount> sets
});




}
/// @nodoc
class __$CollectionStatsCopyWithImpl<$Res>
    implements _$CollectionStatsCopyWith<$Res> {
  __$CollectionStatsCopyWithImpl(this._self, this._then);

  final _CollectionStats _self;
  final $Res Function(_CollectionStats) _then;

/// Create a copy of CollectionStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalCards = null,Object? uniqueCards = null,Object? sets = null,}) {
  return _then(_CollectionStats(
totalCards: null == totalCards ? _self.totalCards : totalCards // ignore: cast_nullable_to_non_nullable
as int,uniqueCards: null == uniqueCards ? _self.uniqueCards : uniqueCards // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetCount>,
  ));
}


}

// dart format on
