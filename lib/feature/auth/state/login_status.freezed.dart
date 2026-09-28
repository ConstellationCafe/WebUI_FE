// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginStatus {

 bool get isLoggedIn; bool get roomSelected;
/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStatusCopyWith<LoginStatus> get copyWith => _$LoginStatusCopyWithImpl<LoginStatus>(this as LoginStatus, _$identity);

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginStatus&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.roomSelected, roomSelected) || other.roomSelected == roomSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoggedIn,roomSelected);

@override
String toString() {
  return 'LoginStatus(isLoggedIn: $isLoggedIn, roomSelected: $roomSelected)';
}


}

/// @nodoc
abstract mixin class $LoginStatusCopyWith<$Res>  {
  factory $LoginStatusCopyWith(LoginStatus value, $Res Function(LoginStatus) _then) = _$LoginStatusCopyWithImpl;
@useResult
$Res call({
 bool isLoggedIn, bool roomSelected
});




}
/// @nodoc
class _$LoginStatusCopyWithImpl<$Res>
    implements $LoginStatusCopyWith<$Res> {
  _$LoginStatusCopyWithImpl(this._self, this._then);

  final LoginStatus _self;
  final $Res Function(LoginStatus) _then;

/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoggedIn = null,Object? roomSelected = null,}) {
  return _then(_self.copyWith(
isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,roomSelected: null == roomSelected ? _self.roomSelected : roomSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginStatus].
extension LoginStatusPatterns on LoginStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginStatus value)  $default,){
final _that = this;
switch (_that) {
case _LoginStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginStatus value)?  $default,){
final _that = this;
switch (_that) {
case _LoginStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoggedIn,  bool roomSelected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginStatus() when $default != null:
return $default(_that.isLoggedIn,_that.roomSelected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoggedIn,  bool roomSelected)  $default,) {final _that = this;
switch (_that) {
case _LoginStatus():
return $default(_that.isLoggedIn,_that.roomSelected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoggedIn,  bool roomSelected)?  $default,) {final _that = this;
switch (_that) {
case _LoginStatus() when $default != null:
return $default(_that.isLoggedIn,_that.roomSelected);case _:
  return null;

}
}

}

/// @nodoc


class _LoginStatus implements LoginStatus {
  const _LoginStatus({required this.isLoggedIn, required this.roomSelected});

@override final  bool isLoggedIn;
@override final  bool roomSelected;

/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStatusCopyWith<_LoginStatus> get copyWith => __$LoginStatusCopyWithImpl<_LoginStatus>(this, _$identity);

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginStatus&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.roomSelected, roomSelected) || other.roomSelected == roomSelected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoggedIn,roomSelected);

@override
String toString() {
  return 'LoginStatus(isLoggedIn: $isLoggedIn, roomSelected: $roomSelected)';
}


}

/// @nodoc
abstract mixin class _$LoginStatusCopyWith<$Res> implements $LoginStatusCopyWith<$Res> {
  factory _$LoginStatusCopyWith(_LoginStatus value, $Res Function(_LoginStatus) _then) = __$LoginStatusCopyWithImpl;
@override @useResult
$Res call({
 bool isLoggedIn, bool roomSelected
});




}
/// @nodoc
class __$LoginStatusCopyWithImpl<$Res>
    implements _$LoginStatusCopyWith<$Res> {
  __$LoginStatusCopyWithImpl(this._self, this._then);

  final _LoginStatus _self;
  final $Res Function(_LoginStatus) _then;

/// Create a copy of LoginStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoggedIn = null,Object? roomSelected = null,}) {
  return _then(_LoginStatus(
isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,roomSelected: null == roomSelected ? _self.roomSelected : roomSelected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
