// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition_permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompetitionPermissionState {

 bool get isLoading; bool get isInitialized;/// 대회 매니저 역할(또는 서버장)이 있어 대회 기능을 쓸 수 있는지
 bool get isManager;
/// Create a copy of CompetitionPermissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionPermissionStateCopyWith<CompetitionPermissionState> get copyWith => _$CompetitionPermissionStateCopyWithImpl<CompetitionPermissionState>(this as CompetitionPermissionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionPermissionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isManager, isManager) || other.isManager == isManager));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isInitialized,isManager);

@override
String toString() {
  return 'CompetitionPermissionState(isLoading: $isLoading, isInitialized: $isInitialized, isManager: $isManager)';
}


}

/// @nodoc
abstract mixin class $CompetitionPermissionStateCopyWith<$Res>  {
  factory $CompetitionPermissionStateCopyWith(CompetitionPermissionState value, $Res Function(CompetitionPermissionState) _then) = _$CompetitionPermissionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isInitialized, bool isManager
});




}
/// @nodoc
class _$CompetitionPermissionStateCopyWithImpl<$Res>
    implements $CompetitionPermissionStateCopyWith<$Res> {
  _$CompetitionPermissionStateCopyWithImpl(this._self, this._then);

  final CompetitionPermissionState _self;
  final $Res Function(CompetitionPermissionState) _then;

/// Create a copy of CompetitionPermissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isInitialized = null,Object? isManager = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isManager: null == isManager ? _self.isManager : isManager // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionPermissionState].
extension CompetitionPermissionStatePatterns on CompetitionPermissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionPermissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionPermissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionPermissionState value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionPermissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionPermissionState value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionPermissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isInitialized,  bool isManager)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionPermissionState() when $default != null:
return $default(_that.isLoading,_that.isInitialized,_that.isManager);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isInitialized,  bool isManager)  $default,) {final _that = this;
switch (_that) {
case _CompetitionPermissionState():
return $default(_that.isLoading,_that.isInitialized,_that.isManager);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isInitialized,  bool isManager)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionPermissionState() when $default != null:
return $default(_that.isLoading,_that.isInitialized,_that.isManager);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionPermissionState implements CompetitionPermissionState {
  const _CompetitionPermissionState({this.isLoading = false, this.isInitialized = false, this.isManager = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isInitialized;
/// 대회 매니저 역할(또는 서버장)이 있어 대회 기능을 쓸 수 있는지
@override@JsonKey() final  bool isManager;

/// Create a copy of CompetitionPermissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionPermissionStateCopyWith<_CompetitionPermissionState> get copyWith => __$CompetitionPermissionStateCopyWithImpl<_CompetitionPermissionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionPermissionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.isManager, isManager) || other.isManager == isManager));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isInitialized,isManager);

@override
String toString() {
  return 'CompetitionPermissionState(isLoading: $isLoading, isInitialized: $isInitialized, isManager: $isManager)';
}


}

/// @nodoc
abstract mixin class _$CompetitionPermissionStateCopyWith<$Res> implements $CompetitionPermissionStateCopyWith<$Res> {
  factory _$CompetitionPermissionStateCopyWith(_CompetitionPermissionState value, $Res Function(_CompetitionPermissionState) _then) = __$CompetitionPermissionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isInitialized, bool isManager
});




}
/// @nodoc
class __$CompetitionPermissionStateCopyWithImpl<$Res>
    implements _$CompetitionPermissionStateCopyWith<$Res> {
  __$CompetitionPermissionStateCopyWithImpl(this._self, this._then);

  final _CompetitionPermissionState _self;
  final $Res Function(_CompetitionPermissionState) _then;

/// Create a copy of CompetitionPermissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isInitialized = null,Object? isManager = null,}) {
  return _then(_CompetitionPermissionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,isManager: null == isManager ? _self.isManager : isManager // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
