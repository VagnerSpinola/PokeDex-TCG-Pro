// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grading_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GradeSubScores {

 double get centering; double get corners; double get edges; double get surface;
/// Create a copy of GradeSubScores
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeSubScoresCopyWith<GradeSubScores> get copyWith => _$GradeSubScoresCopyWithImpl<GradeSubScores>(this as GradeSubScores, _$identity);

  /// Serializes this GradeSubScores to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeSubScores&&(identical(other.centering, centering) || other.centering == centering)&&(identical(other.corners, corners) || other.corners == corners)&&(identical(other.edges, edges) || other.edges == edges)&&(identical(other.surface, surface) || other.surface == surface));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,centering,corners,edges,surface);

@override
String toString() {
  return 'GradeSubScores(centering: $centering, corners: $corners, edges: $edges, surface: $surface)';
}


}

/// @nodoc
abstract mixin class $GradeSubScoresCopyWith<$Res>  {
  factory $GradeSubScoresCopyWith(GradeSubScores value, $Res Function(GradeSubScores) _then) = _$GradeSubScoresCopyWithImpl;
@useResult
$Res call({
 double centering, double corners, double edges, double surface
});




}
/// @nodoc
class _$GradeSubScoresCopyWithImpl<$Res>
    implements $GradeSubScoresCopyWith<$Res> {
  _$GradeSubScoresCopyWithImpl(this._self, this._then);

  final GradeSubScores _self;
  final $Res Function(GradeSubScores) _then;

/// Create a copy of GradeSubScores
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? centering = null,Object? corners = null,Object? edges = null,Object? surface = null,}) {
  return _then(_self.copyWith(
centering: null == centering ? _self.centering : centering // ignore: cast_nullable_to_non_nullable
as double,corners: null == corners ? _self.corners : corners // ignore: cast_nullable_to_non_nullable
as double,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as double,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeSubScores].
extension GradeSubScoresPatterns on GradeSubScores {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeSubScores value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeSubScores() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeSubScores value)  $default,){
final _that = this;
switch (_that) {
case _GradeSubScores():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeSubScores value)?  $default,){
final _that = this;
switch (_that) {
case _GradeSubScores() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double centering,  double corners,  double edges,  double surface)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeSubScores() when $default != null:
return $default(_that.centering,_that.corners,_that.edges,_that.surface);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double centering,  double corners,  double edges,  double surface)  $default,) {final _that = this;
switch (_that) {
case _GradeSubScores():
return $default(_that.centering,_that.corners,_that.edges,_that.surface);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double centering,  double corners,  double edges,  double surface)?  $default,) {final _that = this;
switch (_that) {
case _GradeSubScores() when $default != null:
return $default(_that.centering,_that.corners,_that.edges,_that.surface);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeSubScores implements GradeSubScores {
  const _GradeSubScores({required this.centering, required this.corners, required this.edges, required this.surface});
  factory _GradeSubScores.fromJson(Map<String, dynamic> json) => _$GradeSubScoresFromJson(json);

@override final  double centering;
@override final  double corners;
@override final  double edges;
@override final  double surface;

/// Create a copy of GradeSubScores
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeSubScoresCopyWith<_GradeSubScores> get copyWith => __$GradeSubScoresCopyWithImpl<_GradeSubScores>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeSubScoresToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeSubScores&&(identical(other.centering, centering) || other.centering == centering)&&(identical(other.corners, corners) || other.corners == corners)&&(identical(other.edges, edges) || other.edges == edges)&&(identical(other.surface, surface) || other.surface == surface));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,centering,corners,edges,surface);

@override
String toString() {
  return 'GradeSubScores(centering: $centering, corners: $corners, edges: $edges, surface: $surface)';
}


}

/// @nodoc
abstract mixin class _$GradeSubScoresCopyWith<$Res> implements $GradeSubScoresCopyWith<$Res> {
  factory _$GradeSubScoresCopyWith(_GradeSubScores value, $Res Function(_GradeSubScores) _then) = __$GradeSubScoresCopyWithImpl;
@override @useResult
$Res call({
 double centering, double corners, double edges, double surface
});




}
/// @nodoc
class __$GradeSubScoresCopyWithImpl<$Res>
    implements _$GradeSubScoresCopyWith<$Res> {
  __$GradeSubScoresCopyWithImpl(this._self, this._then);

  final _GradeSubScores _self;
  final $Res Function(_GradeSubScores) _then;

/// Create a copy of GradeSubScores
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? centering = null,Object? corners = null,Object? edges = null,Object? surface = null,}) {
  return _then(_GradeSubScores(
centering: null == centering ? _self.centering : centering // ignore: cast_nullable_to_non_nullable
as double,corners: null == corners ? _self.corners : corners // ignore: cast_nullable_to_non_nullable
as double,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as double,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CenteringInfo {

@JsonKey(name: 'left_right') String get leftRight;@JsonKey(name: 'top_bottom') String get topBottom; double get cap;
/// Create a copy of CenteringInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CenteringInfoCopyWith<CenteringInfo> get copyWith => _$CenteringInfoCopyWithImpl<CenteringInfo>(this as CenteringInfo, _$identity);

  /// Serializes this CenteringInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CenteringInfo&&(identical(other.leftRight, leftRight) || other.leftRight == leftRight)&&(identical(other.topBottom, topBottom) || other.topBottom == topBottom)&&(identical(other.cap, cap) || other.cap == cap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftRight,topBottom,cap);

@override
String toString() {
  return 'CenteringInfo(leftRight: $leftRight, topBottom: $topBottom, cap: $cap)';
}


}

/// @nodoc
abstract mixin class $CenteringInfoCopyWith<$Res>  {
  factory $CenteringInfoCopyWith(CenteringInfo value, $Res Function(CenteringInfo) _then) = _$CenteringInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'left_right') String leftRight,@JsonKey(name: 'top_bottom') String topBottom, double cap
});




}
/// @nodoc
class _$CenteringInfoCopyWithImpl<$Res>
    implements $CenteringInfoCopyWith<$Res> {
  _$CenteringInfoCopyWithImpl(this._self, this._then);

  final CenteringInfo _self;
  final $Res Function(CenteringInfo) _then;

/// Create a copy of CenteringInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? leftRight = null,Object? topBottom = null,Object? cap = null,}) {
  return _then(_self.copyWith(
leftRight: null == leftRight ? _self.leftRight : leftRight // ignore: cast_nullable_to_non_nullable
as String,topBottom: null == topBottom ? _self.topBottom : topBottom // ignore: cast_nullable_to_non_nullable
as String,cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CenteringInfo].
extension CenteringInfoPatterns on CenteringInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CenteringInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CenteringInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CenteringInfo value)  $default,){
final _that = this;
switch (_that) {
case _CenteringInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CenteringInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CenteringInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'left_right')  String leftRight, @JsonKey(name: 'top_bottom')  String topBottom,  double cap)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CenteringInfo() when $default != null:
return $default(_that.leftRight,_that.topBottom,_that.cap);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'left_right')  String leftRight, @JsonKey(name: 'top_bottom')  String topBottom,  double cap)  $default,) {final _that = this;
switch (_that) {
case _CenteringInfo():
return $default(_that.leftRight,_that.topBottom,_that.cap);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'left_right')  String leftRight, @JsonKey(name: 'top_bottom')  String topBottom,  double cap)?  $default,) {final _that = this;
switch (_that) {
case _CenteringInfo() when $default != null:
return $default(_that.leftRight,_that.topBottom,_that.cap);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CenteringInfo implements CenteringInfo {
  const _CenteringInfo({@JsonKey(name: 'left_right') required this.leftRight, @JsonKey(name: 'top_bottom') required this.topBottom, required this.cap});
  factory _CenteringInfo.fromJson(Map<String, dynamic> json) => _$CenteringInfoFromJson(json);

@override@JsonKey(name: 'left_right') final  String leftRight;
@override@JsonKey(name: 'top_bottom') final  String topBottom;
@override final  double cap;

/// Create a copy of CenteringInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CenteringInfoCopyWith<_CenteringInfo> get copyWith => __$CenteringInfoCopyWithImpl<_CenteringInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CenteringInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CenteringInfo&&(identical(other.leftRight, leftRight) || other.leftRight == leftRight)&&(identical(other.topBottom, topBottom) || other.topBottom == topBottom)&&(identical(other.cap, cap) || other.cap == cap));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,leftRight,topBottom,cap);

@override
String toString() {
  return 'CenteringInfo(leftRight: $leftRight, topBottom: $topBottom, cap: $cap)';
}


}

/// @nodoc
abstract mixin class _$CenteringInfoCopyWith<$Res> implements $CenteringInfoCopyWith<$Res> {
  factory _$CenteringInfoCopyWith(_CenteringInfo value, $Res Function(_CenteringInfo) _then) = __$CenteringInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'left_right') String leftRight,@JsonKey(name: 'top_bottom') String topBottom, double cap
});




}
/// @nodoc
class __$CenteringInfoCopyWithImpl<$Res>
    implements _$CenteringInfoCopyWith<$Res> {
  __$CenteringInfoCopyWithImpl(this._self, this._then);

  final _CenteringInfo _self;
  final $Res Function(_CenteringInfo) _then;

/// Create a copy of CenteringInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? leftRight = null,Object? topBottom = null,Object? cap = null,}) {
  return _then(_CenteringInfo(
leftRight: null == leftRight ? _self.leftRight : leftRight // ignore: cast_nullable_to_non_nullable
as String,topBottom: null == topBottom ? _self.topBottom : topBottom // ignore: cast_nullable_to_non_nullable
as String,cap: null == cap ? _self.cap : cap // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CornerInfo {

 String get corner;@JsonKey(name: 'whitening_pct') double get whiteningPct; double get score;
/// Create a copy of CornerInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CornerInfoCopyWith<CornerInfo> get copyWith => _$CornerInfoCopyWithImpl<CornerInfo>(this as CornerInfo, _$identity);

  /// Serializes this CornerInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CornerInfo&&(identical(other.corner, corner) || other.corner == corner)&&(identical(other.whiteningPct, whiteningPct) || other.whiteningPct == whiteningPct)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,corner,whiteningPct,score);

@override
String toString() {
  return 'CornerInfo(corner: $corner, whiteningPct: $whiteningPct, score: $score)';
}


}

/// @nodoc
abstract mixin class $CornerInfoCopyWith<$Res>  {
  factory $CornerInfoCopyWith(CornerInfo value, $Res Function(CornerInfo) _then) = _$CornerInfoCopyWithImpl;
@useResult
$Res call({
 String corner,@JsonKey(name: 'whitening_pct') double whiteningPct, double score
});




}
/// @nodoc
class _$CornerInfoCopyWithImpl<$Res>
    implements $CornerInfoCopyWith<$Res> {
  _$CornerInfoCopyWithImpl(this._self, this._then);

  final CornerInfo _self;
  final $Res Function(CornerInfo) _then;

/// Create a copy of CornerInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? corner = null,Object? whiteningPct = null,Object? score = null,}) {
  return _then(_self.copyWith(
corner: null == corner ? _self.corner : corner // ignore: cast_nullable_to_non_nullable
as String,whiteningPct: null == whiteningPct ? _self.whiteningPct : whiteningPct // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CornerInfo].
extension CornerInfoPatterns on CornerInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CornerInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CornerInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CornerInfo value)  $default,){
final _that = this;
switch (_that) {
case _CornerInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CornerInfo value)?  $default,){
final _that = this;
switch (_that) {
case _CornerInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String corner, @JsonKey(name: 'whitening_pct')  double whiteningPct,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CornerInfo() when $default != null:
return $default(_that.corner,_that.whiteningPct,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String corner, @JsonKey(name: 'whitening_pct')  double whiteningPct,  double score)  $default,) {final _that = this;
switch (_that) {
case _CornerInfo():
return $default(_that.corner,_that.whiteningPct,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String corner, @JsonKey(name: 'whitening_pct')  double whiteningPct,  double score)?  $default,) {final _that = this;
switch (_that) {
case _CornerInfo() when $default != null:
return $default(_that.corner,_that.whiteningPct,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CornerInfo implements CornerInfo {
  const _CornerInfo({required this.corner, @JsonKey(name: 'whitening_pct') required this.whiteningPct, required this.score});
  factory _CornerInfo.fromJson(Map<String, dynamic> json) => _$CornerInfoFromJson(json);

@override final  String corner;
@override@JsonKey(name: 'whitening_pct') final  double whiteningPct;
@override final  double score;

/// Create a copy of CornerInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CornerInfoCopyWith<_CornerInfo> get copyWith => __$CornerInfoCopyWithImpl<_CornerInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CornerInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CornerInfo&&(identical(other.corner, corner) || other.corner == corner)&&(identical(other.whiteningPct, whiteningPct) || other.whiteningPct == whiteningPct)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,corner,whiteningPct,score);

@override
String toString() {
  return 'CornerInfo(corner: $corner, whiteningPct: $whiteningPct, score: $score)';
}


}

/// @nodoc
abstract mixin class _$CornerInfoCopyWith<$Res> implements $CornerInfoCopyWith<$Res> {
  factory _$CornerInfoCopyWith(_CornerInfo value, $Res Function(_CornerInfo) _then) = __$CornerInfoCopyWithImpl;
@override @useResult
$Res call({
 String corner,@JsonKey(name: 'whitening_pct') double whiteningPct, double score
});




}
/// @nodoc
class __$CornerInfoCopyWithImpl<$Res>
    implements _$CornerInfoCopyWith<$Res> {
  __$CornerInfoCopyWithImpl(this._self, this._then);

  final _CornerInfo _self;
  final $Res Function(_CornerInfo) _then;

/// Create a copy of CornerInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? corner = null,Object? whiteningPct = null,Object? score = null,}) {
  return _then(_CornerInfo(
corner: null == corner ? _self.corner : corner // ignore: cast_nullable_to_non_nullable
as String,whiteningPct: null == whiteningPct ? _self.whiteningPct : whiteningPct // ignore: cast_nullable_to_non_nullable
as double,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$EdgeInfo {

 String get edge;@JsonKey(name: 'whitening_pct') double get whiteningPct; bool get clustered; double get score;
/// Create a copy of EdgeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EdgeInfoCopyWith<EdgeInfo> get copyWith => _$EdgeInfoCopyWithImpl<EdgeInfo>(this as EdgeInfo, _$identity);

  /// Serializes this EdgeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EdgeInfo&&(identical(other.edge, edge) || other.edge == edge)&&(identical(other.whiteningPct, whiteningPct) || other.whiteningPct == whiteningPct)&&(identical(other.clustered, clustered) || other.clustered == clustered)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,edge,whiteningPct,clustered,score);

@override
String toString() {
  return 'EdgeInfo(edge: $edge, whiteningPct: $whiteningPct, clustered: $clustered, score: $score)';
}


}

/// @nodoc
abstract mixin class $EdgeInfoCopyWith<$Res>  {
  factory $EdgeInfoCopyWith(EdgeInfo value, $Res Function(EdgeInfo) _then) = _$EdgeInfoCopyWithImpl;
@useResult
$Res call({
 String edge,@JsonKey(name: 'whitening_pct') double whiteningPct, bool clustered, double score
});




}
/// @nodoc
class _$EdgeInfoCopyWithImpl<$Res>
    implements $EdgeInfoCopyWith<$Res> {
  _$EdgeInfoCopyWithImpl(this._self, this._then);

  final EdgeInfo _self;
  final $Res Function(EdgeInfo) _then;

/// Create a copy of EdgeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? edge = null,Object? whiteningPct = null,Object? clustered = null,Object? score = null,}) {
  return _then(_self.copyWith(
edge: null == edge ? _self.edge : edge // ignore: cast_nullable_to_non_nullable
as String,whiteningPct: null == whiteningPct ? _self.whiteningPct : whiteningPct // ignore: cast_nullable_to_non_nullable
as double,clustered: null == clustered ? _self.clustered : clustered // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EdgeInfo].
extension EdgeInfoPatterns on EdgeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EdgeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EdgeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EdgeInfo value)  $default,){
final _that = this;
switch (_that) {
case _EdgeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EdgeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EdgeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String edge, @JsonKey(name: 'whitening_pct')  double whiteningPct,  bool clustered,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EdgeInfo() when $default != null:
return $default(_that.edge,_that.whiteningPct,_that.clustered,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String edge, @JsonKey(name: 'whitening_pct')  double whiteningPct,  bool clustered,  double score)  $default,) {final _that = this;
switch (_that) {
case _EdgeInfo():
return $default(_that.edge,_that.whiteningPct,_that.clustered,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String edge, @JsonKey(name: 'whitening_pct')  double whiteningPct,  bool clustered,  double score)?  $default,) {final _that = this;
switch (_that) {
case _EdgeInfo() when $default != null:
return $default(_that.edge,_that.whiteningPct,_that.clustered,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EdgeInfo implements EdgeInfo {
  const _EdgeInfo({required this.edge, @JsonKey(name: 'whitening_pct') required this.whiteningPct, required this.clustered, required this.score});
  factory _EdgeInfo.fromJson(Map<String, dynamic> json) => _$EdgeInfoFromJson(json);

@override final  String edge;
@override@JsonKey(name: 'whitening_pct') final  double whiteningPct;
@override final  bool clustered;
@override final  double score;

/// Create a copy of EdgeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EdgeInfoCopyWith<_EdgeInfo> get copyWith => __$EdgeInfoCopyWithImpl<_EdgeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EdgeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EdgeInfo&&(identical(other.edge, edge) || other.edge == edge)&&(identical(other.whiteningPct, whiteningPct) || other.whiteningPct == whiteningPct)&&(identical(other.clustered, clustered) || other.clustered == clustered)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,edge,whiteningPct,clustered,score);

@override
String toString() {
  return 'EdgeInfo(edge: $edge, whiteningPct: $whiteningPct, clustered: $clustered, score: $score)';
}


}

/// @nodoc
abstract mixin class _$EdgeInfoCopyWith<$Res> implements $EdgeInfoCopyWith<$Res> {
  factory _$EdgeInfoCopyWith(_EdgeInfo value, $Res Function(_EdgeInfo) _then) = __$EdgeInfoCopyWithImpl;
@override @useResult
$Res call({
 String edge,@JsonKey(name: 'whitening_pct') double whiteningPct, bool clustered, double score
});




}
/// @nodoc
class __$EdgeInfoCopyWithImpl<$Res>
    implements _$EdgeInfoCopyWith<$Res> {
  __$EdgeInfoCopyWithImpl(this._self, this._then);

  final _EdgeInfo _self;
  final $Res Function(_EdgeInfo) _then;

/// Create a copy of EdgeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? edge = null,Object? whiteningPct = null,Object? clustered = null,Object? score = null,}) {
  return _then(_EdgeInfo(
edge: null == edge ? _self.edge : edge // ignore: cast_nullable_to_non_nullable
as String,whiteningPct: null == whiteningPct ? _self.whiteningPct : whiteningPct // ignore: cast_nullable_to_non_nullable
as double,clustered: null == clustered ? _self.clustered : clustered // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$SurfaceInfo {

@JsonKey(name: 'glare_pct') double get glarePct;@JsonKey(name: 'scratch_index') double get scratchIndex;@JsonKey(name: 'crease_detected') bool get creaseDetected;@JsonKey(name: 'severe_crease') bool get severeCrease;@JsonKey(name: 'print_line') bool get printLine; double get score;
/// Create a copy of SurfaceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurfaceInfoCopyWith<SurfaceInfo> get copyWith => _$SurfaceInfoCopyWithImpl<SurfaceInfo>(this as SurfaceInfo, _$identity);

  /// Serializes this SurfaceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurfaceInfo&&(identical(other.glarePct, glarePct) || other.glarePct == glarePct)&&(identical(other.scratchIndex, scratchIndex) || other.scratchIndex == scratchIndex)&&(identical(other.creaseDetected, creaseDetected) || other.creaseDetected == creaseDetected)&&(identical(other.severeCrease, severeCrease) || other.severeCrease == severeCrease)&&(identical(other.printLine, printLine) || other.printLine == printLine)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,glarePct,scratchIndex,creaseDetected,severeCrease,printLine,score);

@override
String toString() {
  return 'SurfaceInfo(glarePct: $glarePct, scratchIndex: $scratchIndex, creaseDetected: $creaseDetected, severeCrease: $severeCrease, printLine: $printLine, score: $score)';
}


}

/// @nodoc
abstract mixin class $SurfaceInfoCopyWith<$Res>  {
  factory $SurfaceInfoCopyWith(SurfaceInfo value, $Res Function(SurfaceInfo) _then) = _$SurfaceInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'glare_pct') double glarePct,@JsonKey(name: 'scratch_index') double scratchIndex,@JsonKey(name: 'crease_detected') bool creaseDetected,@JsonKey(name: 'severe_crease') bool severeCrease,@JsonKey(name: 'print_line') bool printLine, double score
});




}
/// @nodoc
class _$SurfaceInfoCopyWithImpl<$Res>
    implements $SurfaceInfoCopyWith<$Res> {
  _$SurfaceInfoCopyWithImpl(this._self, this._then);

  final SurfaceInfo _self;
  final $Res Function(SurfaceInfo) _then;

/// Create a copy of SurfaceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? glarePct = null,Object? scratchIndex = null,Object? creaseDetected = null,Object? severeCrease = null,Object? printLine = null,Object? score = null,}) {
  return _then(_self.copyWith(
glarePct: null == glarePct ? _self.glarePct : glarePct // ignore: cast_nullable_to_non_nullable
as double,scratchIndex: null == scratchIndex ? _self.scratchIndex : scratchIndex // ignore: cast_nullable_to_non_nullable
as double,creaseDetected: null == creaseDetected ? _self.creaseDetected : creaseDetected // ignore: cast_nullable_to_non_nullable
as bool,severeCrease: null == severeCrease ? _self.severeCrease : severeCrease // ignore: cast_nullable_to_non_nullable
as bool,printLine: null == printLine ? _self.printLine : printLine // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SurfaceInfo].
extension SurfaceInfoPatterns on SurfaceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurfaceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurfaceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurfaceInfo value)  $default,){
final _that = this;
switch (_that) {
case _SurfaceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurfaceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SurfaceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'glare_pct')  double glarePct, @JsonKey(name: 'scratch_index')  double scratchIndex, @JsonKey(name: 'crease_detected')  bool creaseDetected, @JsonKey(name: 'severe_crease')  bool severeCrease, @JsonKey(name: 'print_line')  bool printLine,  double score)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurfaceInfo() when $default != null:
return $default(_that.glarePct,_that.scratchIndex,_that.creaseDetected,_that.severeCrease,_that.printLine,_that.score);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'glare_pct')  double glarePct, @JsonKey(name: 'scratch_index')  double scratchIndex, @JsonKey(name: 'crease_detected')  bool creaseDetected, @JsonKey(name: 'severe_crease')  bool severeCrease, @JsonKey(name: 'print_line')  bool printLine,  double score)  $default,) {final _that = this;
switch (_that) {
case _SurfaceInfo():
return $default(_that.glarePct,_that.scratchIndex,_that.creaseDetected,_that.severeCrease,_that.printLine,_that.score);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'glare_pct')  double glarePct, @JsonKey(name: 'scratch_index')  double scratchIndex, @JsonKey(name: 'crease_detected')  bool creaseDetected, @JsonKey(name: 'severe_crease')  bool severeCrease, @JsonKey(name: 'print_line')  bool printLine,  double score)?  $default,) {final _that = this;
switch (_that) {
case _SurfaceInfo() when $default != null:
return $default(_that.glarePct,_that.scratchIndex,_that.creaseDetected,_that.severeCrease,_that.printLine,_that.score);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurfaceInfo implements SurfaceInfo {
  const _SurfaceInfo({@JsonKey(name: 'glare_pct') required this.glarePct, @JsonKey(name: 'scratch_index') required this.scratchIndex, @JsonKey(name: 'crease_detected') required this.creaseDetected, @JsonKey(name: 'severe_crease') required this.severeCrease, @JsonKey(name: 'print_line') required this.printLine, required this.score});
  factory _SurfaceInfo.fromJson(Map<String, dynamic> json) => _$SurfaceInfoFromJson(json);

@override@JsonKey(name: 'glare_pct') final  double glarePct;
@override@JsonKey(name: 'scratch_index') final  double scratchIndex;
@override@JsonKey(name: 'crease_detected') final  bool creaseDetected;
@override@JsonKey(name: 'severe_crease') final  bool severeCrease;
@override@JsonKey(name: 'print_line') final  bool printLine;
@override final  double score;

/// Create a copy of SurfaceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurfaceInfoCopyWith<_SurfaceInfo> get copyWith => __$SurfaceInfoCopyWithImpl<_SurfaceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurfaceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurfaceInfo&&(identical(other.glarePct, glarePct) || other.glarePct == glarePct)&&(identical(other.scratchIndex, scratchIndex) || other.scratchIndex == scratchIndex)&&(identical(other.creaseDetected, creaseDetected) || other.creaseDetected == creaseDetected)&&(identical(other.severeCrease, severeCrease) || other.severeCrease == severeCrease)&&(identical(other.printLine, printLine) || other.printLine == printLine)&&(identical(other.score, score) || other.score == score));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,glarePct,scratchIndex,creaseDetected,severeCrease,printLine,score);

@override
String toString() {
  return 'SurfaceInfo(glarePct: $glarePct, scratchIndex: $scratchIndex, creaseDetected: $creaseDetected, severeCrease: $severeCrease, printLine: $printLine, score: $score)';
}


}

/// @nodoc
abstract mixin class _$SurfaceInfoCopyWith<$Res> implements $SurfaceInfoCopyWith<$Res> {
  factory _$SurfaceInfoCopyWith(_SurfaceInfo value, $Res Function(_SurfaceInfo) _then) = __$SurfaceInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'glare_pct') double glarePct,@JsonKey(name: 'scratch_index') double scratchIndex,@JsonKey(name: 'crease_detected') bool creaseDetected,@JsonKey(name: 'severe_crease') bool severeCrease,@JsonKey(name: 'print_line') bool printLine, double score
});




}
/// @nodoc
class __$SurfaceInfoCopyWithImpl<$Res>
    implements _$SurfaceInfoCopyWith<$Res> {
  __$SurfaceInfoCopyWithImpl(this._self, this._then);

  final _SurfaceInfo _self;
  final $Res Function(_SurfaceInfo) _then;

/// Create a copy of SurfaceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? glarePct = null,Object? scratchIndex = null,Object? creaseDetected = null,Object? severeCrease = null,Object? printLine = null,Object? score = null,}) {
  return _then(_SurfaceInfo(
glarePct: null == glarePct ? _self.glarePct : glarePct // ignore: cast_nullable_to_non_nullable
as double,scratchIndex: null == scratchIndex ? _self.scratchIndex : scratchIndex // ignore: cast_nullable_to_non_nullable
as double,creaseDetected: null == creaseDetected ? _self.creaseDetected : creaseDetected // ignore: cast_nullable_to_non_nullable
as bool,severeCrease: null == severeCrease ? _self.severeCrease : severeCrease // ignore: cast_nullable_to_non_nullable
as bool,printLine: null == printLine ? _self.printLine : printLine // ignore: cast_nullable_to_non_nullable
as bool,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$QualityInfo {

 bool get ok; double get sharpness;@JsonKey(name: 'glare_pct') double get glarePct; List<String> get issues;
/// Create a copy of QualityInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QualityInfoCopyWith<QualityInfo> get copyWith => _$QualityInfoCopyWithImpl<QualityInfo>(this as QualityInfo, _$identity);

  /// Serializes this QualityInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QualityInfo&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.sharpness, sharpness) || other.sharpness == sharpness)&&(identical(other.glarePct, glarePct) || other.glarePct == glarePct)&&const DeepCollectionEquality().equals(other.issues, issues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,sharpness,glarePct,const DeepCollectionEquality().hash(issues));

@override
String toString() {
  return 'QualityInfo(ok: $ok, sharpness: $sharpness, glarePct: $glarePct, issues: $issues)';
}


}

/// @nodoc
abstract mixin class $QualityInfoCopyWith<$Res>  {
  factory $QualityInfoCopyWith(QualityInfo value, $Res Function(QualityInfo) _then) = _$QualityInfoCopyWithImpl;
@useResult
$Res call({
 bool ok, double sharpness,@JsonKey(name: 'glare_pct') double glarePct, List<String> issues
});




}
/// @nodoc
class _$QualityInfoCopyWithImpl<$Res>
    implements $QualityInfoCopyWith<$Res> {
  _$QualityInfoCopyWithImpl(this._self, this._then);

  final QualityInfo _self;
  final $Res Function(QualityInfo) _then;

/// Create a copy of QualityInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ok = null,Object? sharpness = null,Object? glarePct = null,Object? issues = null,}) {
  return _then(_self.copyWith(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,sharpness: null == sharpness ? _self.sharpness : sharpness // ignore: cast_nullable_to_non_nullable
as double,glarePct: null == glarePct ? _self.glarePct : glarePct // ignore: cast_nullable_to_non_nullable
as double,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [QualityInfo].
extension QualityInfoPatterns on QualityInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QualityInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QualityInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QualityInfo value)  $default,){
final _that = this;
switch (_that) {
case _QualityInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QualityInfo value)?  $default,){
final _that = this;
switch (_that) {
case _QualityInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool ok,  double sharpness, @JsonKey(name: 'glare_pct')  double glarePct,  List<String> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QualityInfo() when $default != null:
return $default(_that.ok,_that.sharpness,_that.glarePct,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool ok,  double sharpness, @JsonKey(name: 'glare_pct')  double glarePct,  List<String> issues)  $default,) {final _that = this;
switch (_that) {
case _QualityInfo():
return $default(_that.ok,_that.sharpness,_that.glarePct,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool ok,  double sharpness, @JsonKey(name: 'glare_pct')  double glarePct,  List<String> issues)?  $default,) {final _that = this;
switch (_that) {
case _QualityInfo() when $default != null:
return $default(_that.ok,_that.sharpness,_that.glarePct,_that.issues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QualityInfo implements QualityInfo {
  const _QualityInfo({required this.ok, required this.sharpness, @JsonKey(name: 'glare_pct') required this.glarePct, required final  List<String> issues}): _issues = issues;
  factory _QualityInfo.fromJson(Map<String, dynamic> json) => _$QualityInfoFromJson(json);

@override final  bool ok;
@override final  double sharpness;
@override@JsonKey(name: 'glare_pct') final  double glarePct;
 final  List<String> _issues;
@override List<String> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of QualityInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QualityInfoCopyWith<_QualityInfo> get copyWith => __$QualityInfoCopyWithImpl<_QualityInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QualityInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QualityInfo&&(identical(other.ok, ok) || other.ok == ok)&&(identical(other.sharpness, sharpness) || other.sharpness == sharpness)&&(identical(other.glarePct, glarePct) || other.glarePct == glarePct)&&const DeepCollectionEquality().equals(other._issues, _issues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ok,sharpness,glarePct,const DeepCollectionEquality().hash(_issues));

@override
String toString() {
  return 'QualityInfo(ok: $ok, sharpness: $sharpness, glarePct: $glarePct, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$QualityInfoCopyWith<$Res> implements $QualityInfoCopyWith<$Res> {
  factory _$QualityInfoCopyWith(_QualityInfo value, $Res Function(_QualityInfo) _then) = __$QualityInfoCopyWithImpl;
@override @useResult
$Res call({
 bool ok, double sharpness,@JsonKey(name: 'glare_pct') double glarePct, List<String> issues
});




}
/// @nodoc
class __$QualityInfoCopyWithImpl<$Res>
    implements _$QualityInfoCopyWith<$Res> {
  __$QualityInfoCopyWithImpl(this._self, this._then);

  final _QualityInfo _self;
  final $Res Function(_QualityInfo) _then;

/// Create a copy of QualityInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ok = null,Object? sharpness = null,Object? glarePct = null,Object? issues = null,}) {
  return _then(_QualityInfo(
ok: null == ok ? _self.ok : ok // ignore: cast_nullable_to_non_nullable
as bool,sharpness: null == sharpness ? _self.sharpness : sharpness // ignore: cast_nullable_to_non_nullable
as double,glarePct: null == glarePct ? _self.glarePct : glarePct // ignore: cast_nullable_to_non_nullable
as double,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$GradeEstimate {

 bool get experimental;@JsonKey(name: 'estimated_grade') double get estimatedGrade;@JsonKey(name: 'grade_range') List<double> get gradeRange;@JsonKey(name: 'sub_scores') GradeSubScores get subScores; CenteringInfo get centering; List<CornerInfo> get corners; List<EdgeInfo> get edges; SurfaceInfo get surface; QualityInfo get quality;@JsonKey(name: 'frames_analyzed') int get framesAnalyzed; List<String> get warnings; String get disclaimer;
/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeEstimateCopyWith<GradeEstimate> get copyWith => _$GradeEstimateCopyWithImpl<GradeEstimate>(this as GradeEstimate, _$identity);

  /// Serializes this GradeEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeEstimate&&(identical(other.experimental, experimental) || other.experimental == experimental)&&(identical(other.estimatedGrade, estimatedGrade) || other.estimatedGrade == estimatedGrade)&&const DeepCollectionEquality().equals(other.gradeRange, gradeRange)&&(identical(other.subScores, subScores) || other.subScores == subScores)&&(identical(other.centering, centering) || other.centering == centering)&&const DeepCollectionEquality().equals(other.corners, corners)&&const DeepCollectionEquality().equals(other.edges, edges)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.framesAnalyzed, framesAnalyzed) || other.framesAnalyzed == framesAnalyzed)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experimental,estimatedGrade,const DeepCollectionEquality().hash(gradeRange),subScores,centering,const DeepCollectionEquality().hash(corners),const DeepCollectionEquality().hash(edges),surface,quality,framesAnalyzed,const DeepCollectionEquality().hash(warnings),disclaimer);

@override
String toString() {
  return 'GradeEstimate(experimental: $experimental, estimatedGrade: $estimatedGrade, gradeRange: $gradeRange, subScores: $subScores, centering: $centering, corners: $corners, edges: $edges, surface: $surface, quality: $quality, framesAnalyzed: $framesAnalyzed, warnings: $warnings, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $GradeEstimateCopyWith<$Res>  {
  factory $GradeEstimateCopyWith(GradeEstimate value, $Res Function(GradeEstimate) _then) = _$GradeEstimateCopyWithImpl;
@useResult
$Res call({
 bool experimental,@JsonKey(name: 'estimated_grade') double estimatedGrade,@JsonKey(name: 'grade_range') List<double> gradeRange,@JsonKey(name: 'sub_scores') GradeSubScores subScores, CenteringInfo centering, List<CornerInfo> corners, List<EdgeInfo> edges, SurfaceInfo surface, QualityInfo quality,@JsonKey(name: 'frames_analyzed') int framesAnalyzed, List<String> warnings, String disclaimer
});


$GradeSubScoresCopyWith<$Res> get subScores;$CenteringInfoCopyWith<$Res> get centering;$SurfaceInfoCopyWith<$Res> get surface;$QualityInfoCopyWith<$Res> get quality;

}
/// @nodoc
class _$GradeEstimateCopyWithImpl<$Res>
    implements $GradeEstimateCopyWith<$Res> {
  _$GradeEstimateCopyWithImpl(this._self, this._then);

  final GradeEstimate _self;
  final $Res Function(GradeEstimate) _then;

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experimental = null,Object? estimatedGrade = null,Object? gradeRange = null,Object? subScores = null,Object? centering = null,Object? corners = null,Object? edges = null,Object? surface = null,Object? quality = null,Object? framesAnalyzed = null,Object? warnings = null,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
experimental: null == experimental ? _self.experimental : experimental // ignore: cast_nullable_to_non_nullable
as bool,estimatedGrade: null == estimatedGrade ? _self.estimatedGrade : estimatedGrade // ignore: cast_nullable_to_non_nullable
as double,gradeRange: null == gradeRange ? _self.gradeRange : gradeRange // ignore: cast_nullable_to_non_nullable
as List<double>,subScores: null == subScores ? _self.subScores : subScores // ignore: cast_nullable_to_non_nullable
as GradeSubScores,centering: null == centering ? _self.centering : centering // ignore: cast_nullable_to_non_nullable
as CenteringInfo,corners: null == corners ? _self.corners : corners // ignore: cast_nullable_to_non_nullable
as List<CornerInfo>,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as List<EdgeInfo>,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as SurfaceInfo,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as QualityInfo,framesAnalyzed: null == framesAnalyzed ? _self.framesAnalyzed : framesAnalyzed // ignore: cast_nullable_to_non_nullable
as int,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeSubScoresCopyWith<$Res> get subScores {
  
  return $GradeSubScoresCopyWith<$Res>(_self.subScores, (value) {
    return _then(_self.copyWith(subScores: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CenteringInfoCopyWith<$Res> get centering {
  
  return $CenteringInfoCopyWith<$Res>(_self.centering, (value) {
    return _then(_self.copyWith(centering: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceInfoCopyWith<$Res> get surface {
  
  return $SurfaceInfoCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualityInfoCopyWith<$Res> get quality {
  
  return $QualityInfoCopyWith<$Res>(_self.quality, (value) {
    return _then(_self.copyWith(quality: value));
  });
}
}


/// Adds pattern-matching-related methods to [GradeEstimate].
extension GradeEstimatePatterns on GradeEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeEstimate value)  $default,){
final _that = this;
switch (_that) {
case _GradeEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'grade_range')  List<double> gradeRange, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  CenteringInfo centering,  List<CornerInfo> corners,  List<EdgeInfo> edges,  SurfaceInfo surface,  QualityInfo quality, @JsonKey(name: 'frames_analyzed')  int framesAnalyzed,  List<String> warnings,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
return $default(_that.experimental,_that.estimatedGrade,_that.gradeRange,_that.subScores,_that.centering,_that.corners,_that.edges,_that.surface,_that.quality,_that.framesAnalyzed,_that.warnings,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'grade_range')  List<double> gradeRange, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  CenteringInfo centering,  List<CornerInfo> corners,  List<EdgeInfo> edges,  SurfaceInfo surface,  QualityInfo quality, @JsonKey(name: 'frames_analyzed')  int framesAnalyzed,  List<String> warnings,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _GradeEstimate():
return $default(_that.experimental,_that.estimatedGrade,_that.gradeRange,_that.subScores,_that.centering,_that.corners,_that.edges,_that.surface,_that.quality,_that.framesAnalyzed,_that.warnings,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'grade_range')  List<double> gradeRange, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  CenteringInfo centering,  List<CornerInfo> corners,  List<EdgeInfo> edges,  SurfaceInfo surface,  QualityInfo quality, @JsonKey(name: 'frames_analyzed')  int framesAnalyzed,  List<String> warnings,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
return $default(_that.experimental,_that.estimatedGrade,_that.gradeRange,_that.subScores,_that.centering,_that.corners,_that.edges,_that.surface,_that.quality,_that.framesAnalyzed,_that.warnings,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeEstimate implements GradeEstimate {
  const _GradeEstimate({required this.experimental, @JsonKey(name: 'estimated_grade') required this.estimatedGrade, @JsonKey(name: 'grade_range') required final  List<double> gradeRange, @JsonKey(name: 'sub_scores') required this.subScores, required this.centering, required final  List<CornerInfo> corners, required final  List<EdgeInfo> edges, required this.surface, required this.quality, @JsonKey(name: 'frames_analyzed') required this.framesAnalyzed, required final  List<String> warnings, required this.disclaimer}): _gradeRange = gradeRange,_corners = corners,_edges = edges,_warnings = warnings;
  factory _GradeEstimate.fromJson(Map<String, dynamic> json) => _$GradeEstimateFromJson(json);

@override final  bool experimental;
@override@JsonKey(name: 'estimated_grade') final  double estimatedGrade;
 final  List<double> _gradeRange;
@override@JsonKey(name: 'grade_range') List<double> get gradeRange {
  if (_gradeRange is EqualUnmodifiableListView) return _gradeRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gradeRange);
}

@override@JsonKey(name: 'sub_scores') final  GradeSubScores subScores;
@override final  CenteringInfo centering;
 final  List<CornerInfo> _corners;
@override List<CornerInfo> get corners {
  if (_corners is EqualUnmodifiableListView) return _corners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_corners);
}

 final  List<EdgeInfo> _edges;
@override List<EdgeInfo> get edges {
  if (_edges is EqualUnmodifiableListView) return _edges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edges);
}

@override final  SurfaceInfo surface;
@override final  QualityInfo quality;
@override@JsonKey(name: 'frames_analyzed') final  int framesAnalyzed;
 final  List<String> _warnings;
@override List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}

@override final  String disclaimer;

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeEstimateCopyWith<_GradeEstimate> get copyWith => __$GradeEstimateCopyWithImpl<_GradeEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeEstimate&&(identical(other.experimental, experimental) || other.experimental == experimental)&&(identical(other.estimatedGrade, estimatedGrade) || other.estimatedGrade == estimatedGrade)&&const DeepCollectionEquality().equals(other._gradeRange, _gradeRange)&&(identical(other.subScores, subScores) || other.subScores == subScores)&&(identical(other.centering, centering) || other.centering == centering)&&const DeepCollectionEquality().equals(other._corners, _corners)&&const DeepCollectionEquality().equals(other._edges, _edges)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.framesAnalyzed, framesAnalyzed) || other.framesAnalyzed == framesAnalyzed)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experimental,estimatedGrade,const DeepCollectionEquality().hash(_gradeRange),subScores,centering,const DeepCollectionEquality().hash(_corners),const DeepCollectionEquality().hash(_edges),surface,quality,framesAnalyzed,const DeepCollectionEquality().hash(_warnings),disclaimer);

@override
String toString() {
  return 'GradeEstimate(experimental: $experimental, estimatedGrade: $estimatedGrade, gradeRange: $gradeRange, subScores: $subScores, centering: $centering, corners: $corners, edges: $edges, surface: $surface, quality: $quality, framesAnalyzed: $framesAnalyzed, warnings: $warnings, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$GradeEstimateCopyWith<$Res> implements $GradeEstimateCopyWith<$Res> {
  factory _$GradeEstimateCopyWith(_GradeEstimate value, $Res Function(_GradeEstimate) _then) = __$GradeEstimateCopyWithImpl;
@override @useResult
$Res call({
 bool experimental,@JsonKey(name: 'estimated_grade') double estimatedGrade,@JsonKey(name: 'grade_range') List<double> gradeRange,@JsonKey(name: 'sub_scores') GradeSubScores subScores, CenteringInfo centering, List<CornerInfo> corners, List<EdgeInfo> edges, SurfaceInfo surface, QualityInfo quality,@JsonKey(name: 'frames_analyzed') int framesAnalyzed, List<String> warnings, String disclaimer
});


@override $GradeSubScoresCopyWith<$Res> get subScores;@override $CenteringInfoCopyWith<$Res> get centering;@override $SurfaceInfoCopyWith<$Res> get surface;@override $QualityInfoCopyWith<$Res> get quality;

}
/// @nodoc
class __$GradeEstimateCopyWithImpl<$Res>
    implements _$GradeEstimateCopyWith<$Res> {
  __$GradeEstimateCopyWithImpl(this._self, this._then);

  final _GradeEstimate _self;
  final $Res Function(_GradeEstimate) _then;

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experimental = null,Object? estimatedGrade = null,Object? gradeRange = null,Object? subScores = null,Object? centering = null,Object? corners = null,Object? edges = null,Object? surface = null,Object? quality = null,Object? framesAnalyzed = null,Object? warnings = null,Object? disclaimer = null,}) {
  return _then(_GradeEstimate(
experimental: null == experimental ? _self.experimental : experimental // ignore: cast_nullable_to_non_nullable
as bool,estimatedGrade: null == estimatedGrade ? _self.estimatedGrade : estimatedGrade // ignore: cast_nullable_to_non_nullable
as double,gradeRange: null == gradeRange ? _self._gradeRange : gradeRange // ignore: cast_nullable_to_non_nullable
as List<double>,subScores: null == subScores ? _self.subScores : subScores // ignore: cast_nullable_to_non_nullable
as GradeSubScores,centering: null == centering ? _self.centering : centering // ignore: cast_nullable_to_non_nullable
as CenteringInfo,corners: null == corners ? _self._corners : corners // ignore: cast_nullable_to_non_nullable
as List<CornerInfo>,edges: null == edges ? _self._edges : edges // ignore: cast_nullable_to_non_nullable
as List<EdgeInfo>,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as SurfaceInfo,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as QualityInfo,framesAnalyzed: null == framesAnalyzed ? _self.framesAnalyzed : framesAnalyzed // ignore: cast_nullable_to_non_nullable
as int,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,disclaimer: null == disclaimer ? _self.disclaimer : disclaimer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeSubScoresCopyWith<$Res> get subScores {
  
  return $GradeSubScoresCopyWith<$Res>(_self.subScores, (value) {
    return _then(_self.copyWith(subScores: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CenteringInfoCopyWith<$Res> get centering {
  
  return $CenteringInfoCopyWith<$Res>(_self.centering, (value) {
    return _then(_self.copyWith(centering: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceInfoCopyWith<$Res> get surface {
  
  return $SurfaceInfoCopyWith<$Res>(_self.surface, (value) {
    return _then(_self.copyWith(surface: value));
  });
}/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QualityInfoCopyWith<$Res> get quality {
  
  return $QualityInfoCopyWith<$Res>(_self.quality, (value) {
    return _then(_self.copyWith(quality: value));
  });
}
}

// dart format on
