// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scan_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScanCandidate {

 TcgCard get card; double get score; String get confidence;
/// Create a copy of ScanCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanCandidateCopyWith<ScanCandidate> get copyWith => _$ScanCandidateCopyWithImpl<ScanCandidate>(this as ScanCandidate, _$identity);

  /// Serializes this ScanCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanCandidate&&(identical(other.card, card) || other.card == card)&&(identical(other.score, score) || other.score == score)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,card,score,confidence);

@override
String toString() {
  return 'ScanCandidate(card: $card, score: $score, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $ScanCandidateCopyWith<$Res>  {
  factory $ScanCandidateCopyWith(ScanCandidate value, $Res Function(ScanCandidate) _then) = _$ScanCandidateCopyWithImpl;
@useResult
$Res call({
 TcgCard card, double score, String confidence
});


$TcgCardCopyWith<$Res> get card;

}
/// @nodoc
class _$ScanCandidateCopyWithImpl<$Res>
    implements $ScanCandidateCopyWith<$Res> {
  _$ScanCandidateCopyWithImpl(this._self, this._then);

  final ScanCandidate _self;
  final $Res Function(ScanCandidate) _then;

/// Create a copy of ScanCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? card = null,Object? score = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TcgCard,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ScanCandidate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TcgCardCopyWith<$Res> get card {
  
  return $TcgCardCopyWith<$Res>(_self.card, (value) {
    return _then(_self.copyWith(card: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScanCandidate].
extension ScanCandidatePatterns on ScanCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanCandidate value)  $default,){
final _that = this;
switch (_that) {
case _ScanCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _ScanCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TcgCard card,  double score,  String confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanCandidate() when $default != null:
return $default(_that.card,_that.score,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TcgCard card,  double score,  String confidence)  $default,) {final _that = this;
switch (_that) {
case _ScanCandidate():
return $default(_that.card,_that.score,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TcgCard card,  double score,  String confidence)?  $default,) {final _that = this;
switch (_that) {
case _ScanCandidate() when $default != null:
return $default(_that.card,_that.score,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanCandidate implements ScanCandidate {
  const _ScanCandidate({required this.card, required this.score, required this.confidence});
  factory _ScanCandidate.fromJson(Map<String, dynamic> json) => _$ScanCandidateFromJson(json);

@override final  TcgCard card;
@override final  double score;
@override final  String confidence;

/// Create a copy of ScanCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanCandidateCopyWith<_ScanCandidate> get copyWith => __$ScanCandidateCopyWithImpl<_ScanCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanCandidate&&(identical(other.card, card) || other.card == card)&&(identical(other.score, score) || other.score == score)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,card,score,confidence);

@override
String toString() {
  return 'ScanCandidate(card: $card, score: $score, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$ScanCandidateCopyWith<$Res> implements $ScanCandidateCopyWith<$Res> {
  factory _$ScanCandidateCopyWith(_ScanCandidate value, $Res Function(_ScanCandidate) _then) = __$ScanCandidateCopyWithImpl;
@override @useResult
$Res call({
 TcgCard card, double score, String confidence
});


@override $TcgCardCopyWith<$Res> get card;

}
/// @nodoc
class __$ScanCandidateCopyWithImpl<$Res>
    implements _$ScanCandidateCopyWith<$Res> {
  __$ScanCandidateCopyWithImpl(this._self, this._then);

  final _ScanCandidate _self;
  final $Res Function(_ScanCandidate) _then;

/// Create a copy of ScanCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? card = null,Object? score = null,Object? confidence = null,}) {
  return _then(_ScanCandidate(
card: null == card ? _self.card : card // ignore: cast_nullable_to_non_nullable
as TcgCard,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ScanCandidate
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
mixin _$ScanResult {

 List<ScanCandidate> get candidates;@JsonKey(name: 'low_confidence') bool get lowConfidence;@JsonKey(name: 'name_guess') String? get nameGuess; String get disclaimer;
/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScanResultCopyWith<ScanResult> get copyWith => _$ScanResultCopyWithImpl<ScanResult>(this as ScanResult, _$identity);

  /// Serializes this ScanResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScanResult&&const DeepCollectionEquality().equals(other.candidates, candidates)&&(identical(other.lowConfidence, lowConfidence) || other.lowConfidence == lowConfidence)&&(identical(other.nameGuess, nameGuess) || other.nameGuess == nameGuess)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(candidates),lowConfidence,nameGuess,disclaimer);

@override
String toString() {
  return 'ScanResult(candidates: $candidates, lowConfidence: $lowConfidence, nameGuess: $nameGuess, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $ScanResultCopyWith<$Res>  {
  factory $ScanResultCopyWith(ScanResult value, $Res Function(ScanResult) _then) = _$ScanResultCopyWithImpl;
@useResult
$Res call({
 List<ScanCandidate> candidates,@JsonKey(name: 'low_confidence') bool lowConfidence,@JsonKey(name: 'name_guess') String? nameGuess, String disclaimer
});




}
/// @nodoc
class _$ScanResultCopyWithImpl<$Res>
    implements $ScanResultCopyWith<$Res> {
  _$ScanResultCopyWithImpl(this._self, this._then);

  final ScanResult _self;
  final $Res Function(ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? candidates = null,Object? lowConfidence = null,Object? nameGuess = freezed,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
candidates: null == candidates ? _self.candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<ScanCandidate>,lowConfidence: null == lowConfidence ? _self.lowConfidence : lowConfidence // ignore: cast_nullable_to_non_nullable
as bool,nameGuess: freezed == nameGuess ? _self.nameGuess : nameGuess // ignore: cast_nullable_to_non_nullable
as String?,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScanResult].
extension ScanResultPatterns on ScanResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScanResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScanResult value)  $default,){
final _that = this;
switch (_that) {
case _ScanResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScanResult value)?  $default,){
final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ScanCandidate> candidates, @JsonKey(name: 'low_confidence')  bool lowConfidence, @JsonKey(name: 'name_guess')  String? nameGuess,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.candidates,_that.lowConfidence,_that.nameGuess,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ScanCandidate> candidates, @JsonKey(name: 'low_confidence')  bool lowConfidence, @JsonKey(name: 'name_guess')  String? nameGuess,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _ScanResult():
return $default(_that.candidates,_that.lowConfidence,_that.nameGuess,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ScanCandidate> candidates, @JsonKey(name: 'low_confidence')  bool lowConfidence, @JsonKey(name: 'name_guess')  String? nameGuess,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _ScanResult() when $default != null:
return $default(_that.candidates,_that.lowConfidence,_that.nameGuess,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScanResult implements ScanResult {
  const _ScanResult({required final  List<ScanCandidate> candidates, @JsonKey(name: 'low_confidence') required this.lowConfidence, @JsonKey(name: 'name_guess') this.nameGuess, required this.disclaimer}): _candidates = candidates;
  factory _ScanResult.fromJson(Map<String, dynamic> json) => _$ScanResultFromJson(json);

 final  List<ScanCandidate> _candidates;
@override List<ScanCandidate> get candidates {
  if (_candidates is EqualUnmodifiableListView) return _candidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_candidates);
}

@override@JsonKey(name: 'low_confidence') final  bool lowConfidence;
@override@JsonKey(name: 'name_guess') final  String? nameGuess;
@override final  String disclaimer;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScanResultCopyWith<_ScanResult> get copyWith => __$ScanResultCopyWithImpl<_ScanResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScanResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScanResult&&const DeepCollectionEquality().equals(other._candidates, _candidates)&&(identical(other.lowConfidence, lowConfidence) || other.lowConfidence == lowConfidence)&&(identical(other.nameGuess, nameGuess) || other.nameGuess == nameGuess)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_candidates),lowConfidence,nameGuess,disclaimer);

@override
String toString() {
  return 'ScanResult(candidates: $candidates, lowConfidence: $lowConfidence, nameGuess: $nameGuess, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$ScanResultCopyWith<$Res> implements $ScanResultCopyWith<$Res> {
  factory _$ScanResultCopyWith(_ScanResult value, $Res Function(_ScanResult) _then) = __$ScanResultCopyWithImpl;
@override @useResult
$Res call({
 List<ScanCandidate> candidates,@JsonKey(name: 'low_confidence') bool lowConfidence,@JsonKey(name: 'name_guess') String? nameGuess, String disclaimer
});




}
/// @nodoc
class __$ScanResultCopyWithImpl<$Res>
    implements _$ScanResultCopyWith<$Res> {
  __$ScanResultCopyWithImpl(this._self, this._then);

  final _ScanResult _self;
  final $Res Function(_ScanResult) _then;

/// Create a copy of ScanResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? candidates = null,Object? lowConfidence = null,Object? nameGuess = freezed,Object? disclaimer = null,}) {
  return _then(_ScanResult(
candidates: null == candidates ? _self._candidates : candidates // ignore: cast_nullable_to_non_nullable
as List<ScanCandidate>,lowConfidence: null == lowConfidence ? _self.lowConfidence : lowConfidence // ignore: cast_nullable_to_non_nullable
as bool,nameGuess: freezed == nameGuess ? _self.nameGuess : nameGuess // ignore: cast_nullable_to_non_nullable
as String?,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
