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
mixin _$GradeEstimate {

 bool get experimental;@JsonKey(name: 'estimated_grade') double get estimatedGrade;@JsonKey(name: 'sub_scores') GradeSubScores get subScores; List<String> get warnings; String get disclaimer;
/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeEstimateCopyWith<GradeEstimate> get copyWith => _$GradeEstimateCopyWithImpl<GradeEstimate>(this as GradeEstimate, _$identity);

  /// Serializes this GradeEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeEstimate&&(identical(other.experimental, experimental) || other.experimental == experimental)&&(identical(other.estimatedGrade, estimatedGrade) || other.estimatedGrade == estimatedGrade)&&(identical(other.subScores, subScores) || other.subScores == subScores)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experimental,estimatedGrade,subScores,const DeepCollectionEquality().hash(warnings),disclaimer);

@override
String toString() {
  return 'GradeEstimate(experimental: $experimental, estimatedGrade: $estimatedGrade, subScores: $subScores, warnings: $warnings, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class $GradeEstimateCopyWith<$Res>  {
  factory $GradeEstimateCopyWith(GradeEstimate value, $Res Function(GradeEstimate) _then) = _$GradeEstimateCopyWithImpl;
@useResult
$Res call({
 bool experimental,@JsonKey(name: 'estimated_grade') double estimatedGrade,@JsonKey(name: 'sub_scores') GradeSubScores subScores, List<String> warnings, String disclaimer
});


$GradeSubScoresCopyWith<$Res> get subScores;

}
/// @nodoc
class _$GradeEstimateCopyWithImpl<$Res>
    implements $GradeEstimateCopyWith<$Res> {
  _$GradeEstimateCopyWithImpl(this._self, this._then);

  final GradeEstimate _self;
  final $Res Function(GradeEstimate) _then;

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? experimental = null,Object? estimatedGrade = null,Object? subScores = null,Object? warnings = null,Object? disclaimer = null,}) {
  return _then(_self.copyWith(
experimental: null == experimental ? _self.experimental : experimental // ignore: cast_nullable_to_non_nullable
as bool,estimatedGrade: null == estimatedGrade ? _self.estimatedGrade : estimatedGrade // ignore: cast_nullable_to_non_nullable
as double,subScores: null == subScores ? _self.subScores : subScores // ignore: cast_nullable_to_non_nullable
as GradeSubScores,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  List<String> warnings,  String disclaimer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
return $default(_that.experimental,_that.estimatedGrade,_that.subScores,_that.warnings,_that.disclaimer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  List<String> warnings,  String disclaimer)  $default,) {final _that = this;
switch (_that) {
case _GradeEstimate():
return $default(_that.experimental,_that.estimatedGrade,_that.subScores,_that.warnings,_that.disclaimer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool experimental, @JsonKey(name: 'estimated_grade')  double estimatedGrade, @JsonKey(name: 'sub_scores')  GradeSubScores subScores,  List<String> warnings,  String disclaimer)?  $default,) {final _that = this;
switch (_that) {
case _GradeEstimate() when $default != null:
return $default(_that.experimental,_that.estimatedGrade,_that.subScores,_that.warnings,_that.disclaimer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeEstimate implements GradeEstimate {
  const _GradeEstimate({required this.experimental, @JsonKey(name: 'estimated_grade') required this.estimatedGrade, @JsonKey(name: 'sub_scores') required this.subScores, required final  List<String> warnings, required this.disclaimer}): _warnings = warnings;
  factory _GradeEstimate.fromJson(Map<String, dynamic> json) => _$GradeEstimateFromJson(json);

@override final  bool experimental;
@override@JsonKey(name: 'estimated_grade') final  double estimatedGrade;
@override@JsonKey(name: 'sub_scores') final  GradeSubScores subScores;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeEstimate&&(identical(other.experimental, experimental) || other.experimental == experimental)&&(identical(other.estimatedGrade, estimatedGrade) || other.estimatedGrade == estimatedGrade)&&(identical(other.subScores, subScores) || other.subScores == subScores)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&(identical(other.disclaimer, disclaimer) || other.disclaimer == disclaimer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,experimental,estimatedGrade,subScores,const DeepCollectionEquality().hash(_warnings),disclaimer);

@override
String toString() {
  return 'GradeEstimate(experimental: $experimental, estimatedGrade: $estimatedGrade, subScores: $subScores, warnings: $warnings, disclaimer: $disclaimer)';
}


}

/// @nodoc
abstract mixin class _$GradeEstimateCopyWith<$Res> implements $GradeEstimateCopyWith<$Res> {
  factory _$GradeEstimateCopyWith(_GradeEstimate value, $Res Function(_GradeEstimate) _then) = __$GradeEstimateCopyWithImpl;
@override @useResult
$Res call({
 bool experimental,@JsonKey(name: 'estimated_grade') double estimatedGrade,@JsonKey(name: 'sub_scores') GradeSubScores subScores, List<String> warnings, String disclaimer
});


@override $GradeSubScoresCopyWith<$Res> get subScores;

}
/// @nodoc
class __$GradeEstimateCopyWithImpl<$Res>
    implements _$GradeEstimateCopyWith<$Res> {
  __$GradeEstimateCopyWithImpl(this._self, this._then);

  final _GradeEstimate _self;
  final $Res Function(_GradeEstimate) _then;

/// Create a copy of GradeEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? experimental = null,Object? estimatedGrade = null,Object? subScores = null,Object? warnings = null,Object? disclaimer = null,}) {
  return _then(_GradeEstimate(
experimental: null == experimental ? _self.experimental : experimental // ignore: cast_nullable_to_non_nullable
as bool,estimatedGrade: null == estimatedGrade ? _self.estimatedGrade : estimatedGrade // ignore: cast_nullable_to_non_nullable
as double,subScores: null == subScores ? _self.subScores : subScores // ignore: cast_nullable_to_non_nullable
as GradeSubScores,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
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
}
}

// dart format on
