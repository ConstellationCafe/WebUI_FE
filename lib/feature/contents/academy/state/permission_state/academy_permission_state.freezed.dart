// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academy_permission_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AcademyPermissionState {

 bool get isLoading; bool get isInitialized; AcademyPermission? get permission; String? get errorMessage;
/// Create a copy of AcademyPermissionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AcademyPermissionStateCopyWith<AcademyPermissionState> get copyWith => _$AcademyPermissionStateCopyWithImpl<AcademyPermissionState>(this as AcademyPermissionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AcademyPermissionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isInitialized,permission,errorMessage);

@override
String toString() {
  return 'AcademyPermissionState(isLoading: $isLoading, isInitialized: $isInitialized, permission: $permission, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AcademyPermissionStateCopyWith<$Res>  {
  factory $AcademyPermissionStateCopyWith(AcademyPermissionState value, $Res Function(AcademyPermissionState) _then) = _$AcademyPermissionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isInitialized, AcademyPermission? permission, String? errorMessage
});




}
/// @nodoc
class _$AcademyPermissionStateCopyWithImpl<$Res>
    implements $AcademyPermissionStateCopyWith<$Res> {
  _$AcademyPermissionStateCopyWithImpl(this._self, this._then);

  final AcademyPermissionState _self;
  final $Res Function(AcademyPermissionState) _then;

/// Create a copy of AcademyPermissionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isInitialized = null,Object? permission = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as AcademyPermission?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AcademyPermissionState].
extension AcademyPermissionStatePatterns on AcademyPermissionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AcademyPermissionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AcademyPermissionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AcademyPermissionState value)  $default,){
final _that = this;
switch (_that) {
case _AcademyPermissionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AcademyPermissionState value)?  $default,){
final _that = this;
switch (_that) {
case _AcademyPermissionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isInitialized,  AcademyPermission? permission,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AcademyPermissionState() when $default != null:
return $default(_that.isLoading,_that.isInitialized,_that.permission,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isInitialized,  AcademyPermission? permission,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AcademyPermissionState():
return $default(_that.isLoading,_that.isInitialized,_that.permission,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isInitialized,  AcademyPermission? permission,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AcademyPermissionState() when $default != null:
return $default(_that.isLoading,_that.isInitialized,_that.permission,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AcademyPermissionState implements AcademyPermissionState {
  const _AcademyPermissionState({this.isLoading = false, this.isInitialized = false, this.permission, this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isInitialized;
@override final  AcademyPermission? permission;
@override final  String? errorMessage;

/// Create a copy of AcademyPermissionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcademyPermissionStateCopyWith<_AcademyPermissionState> get copyWith => __$AcademyPermissionStateCopyWithImpl<_AcademyPermissionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcademyPermissionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.permission, permission) || other.permission == permission)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isInitialized,permission,errorMessage);

@override
String toString() {
  return 'AcademyPermissionState(isLoading: $isLoading, isInitialized: $isInitialized, permission: $permission, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AcademyPermissionStateCopyWith<$Res> implements $AcademyPermissionStateCopyWith<$Res> {
  factory _$AcademyPermissionStateCopyWith(_AcademyPermissionState value, $Res Function(_AcademyPermissionState) _then) = __$AcademyPermissionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isInitialized, AcademyPermission? permission, String? errorMessage
});




}
/// @nodoc
class __$AcademyPermissionStateCopyWithImpl<$Res>
    implements _$AcademyPermissionStateCopyWith<$Res> {
  __$AcademyPermissionStateCopyWithImpl(this._self, this._then);

  final _AcademyPermissionState _self;
  final $Res Function(_AcademyPermissionState) _then;

/// Create a copy of AcademyPermissionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isInitialized = null,Object? permission = freezed,Object? errorMessage = freezed,}) {
  return _then(_AcademyPermissionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,permission: freezed == permission ? _self.permission : permission // ignore: cast_nullable_to_non_nullable
as AcademyPermission?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
