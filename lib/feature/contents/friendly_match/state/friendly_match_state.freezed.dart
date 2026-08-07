// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendly_match_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendlyMatchState {

 String get version; String get mode; String get platform; String get roomNumber; String get message; String get sender;
/// Create a copy of FriendlyMatchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendlyMatchStateCopyWith<FriendlyMatchState> get copyWith => _$FriendlyMatchStateCopyWithImpl<FriendlyMatchState>(this as FriendlyMatchState, _$identity);

  /// Serializes this FriendlyMatchState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendlyMatchState&&(identical(other.version, version) || other.version == version)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.message, message) || other.message == message)&&(identical(other.sender, sender) || other.sender == sender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,mode,platform,roomNumber,message,sender);

@override
String toString() {
  return 'FriendlyMatchState(version: $version, mode: $mode, platform: $platform, roomNumber: $roomNumber, message: $message, sender: $sender)';
}


}

/// @nodoc
abstract mixin class $FriendlyMatchStateCopyWith<$Res>  {
  factory $FriendlyMatchStateCopyWith(FriendlyMatchState value, $Res Function(FriendlyMatchState) _then) = _$FriendlyMatchStateCopyWithImpl;
@useResult
$Res call({
 String version, String mode, String platform, String roomNumber, String message, String sender
});




}
/// @nodoc
class _$FriendlyMatchStateCopyWithImpl<$Res>
    implements $FriendlyMatchStateCopyWith<$Res> {
  _$FriendlyMatchStateCopyWithImpl(this._self, this._then);

  final FriendlyMatchState _self;
  final $Res Function(FriendlyMatchState) _then;

/// Create a copy of FriendlyMatchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? mode = null,Object? platform = null,Object? roomNumber = null,Object? message = null,Object? sender = null,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendlyMatchState].
extension FriendlyMatchStatePatterns on FriendlyMatchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendlyMatchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendlyMatchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendlyMatchState value)  $default,){
final _that = this;
switch (_that) {
case _FriendlyMatchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendlyMatchState value)?  $default,){
final _that = this;
switch (_that) {
case _FriendlyMatchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  String mode,  String platform,  String roomNumber,  String message,  String sender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendlyMatchState() when $default != null:
return $default(_that.version,_that.mode,_that.platform,_that.roomNumber,_that.message,_that.sender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  String mode,  String platform,  String roomNumber,  String message,  String sender)  $default,) {final _that = this;
switch (_that) {
case _FriendlyMatchState():
return $default(_that.version,_that.mode,_that.platform,_that.roomNumber,_that.message,_that.sender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  String mode,  String platform,  String roomNumber,  String message,  String sender)?  $default,) {final _that = this;
switch (_that) {
case _FriendlyMatchState() when $default != null:
return $default(_that.version,_that.mode,_that.platform,_that.roomNumber,_that.message,_that.sender);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendlyMatchState implements FriendlyMatchState {
  const _FriendlyMatchState({required this.version, required this.mode, required this.platform, required this.roomNumber, required this.message, required this.sender});
  factory _FriendlyMatchState.fromJson(Map<String, dynamic> json) => _$FriendlyMatchStateFromJson(json);

@override final  String version;
@override final  String mode;
@override final  String platform;
@override final  String roomNumber;
@override final  String message;
@override final  String sender;

/// Create a copy of FriendlyMatchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendlyMatchStateCopyWith<_FriendlyMatchState> get copyWith => __$FriendlyMatchStateCopyWithImpl<_FriendlyMatchState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendlyMatchStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendlyMatchState&&(identical(other.version, version) || other.version == version)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.roomNumber, roomNumber) || other.roomNumber == roomNumber)&&(identical(other.message, message) || other.message == message)&&(identical(other.sender, sender) || other.sender == sender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,mode,platform,roomNumber,message,sender);

@override
String toString() {
  return 'FriendlyMatchState(version: $version, mode: $mode, platform: $platform, roomNumber: $roomNumber, message: $message, sender: $sender)';
}


}

/// @nodoc
abstract mixin class _$FriendlyMatchStateCopyWith<$Res> implements $FriendlyMatchStateCopyWith<$Res> {
  factory _$FriendlyMatchStateCopyWith(_FriendlyMatchState value, $Res Function(_FriendlyMatchState) _then) = __$FriendlyMatchStateCopyWithImpl;
@override @useResult
$Res call({
 String version, String mode, String platform, String roomNumber, String message, String sender
});




}
/// @nodoc
class __$FriendlyMatchStateCopyWithImpl<$Res>
    implements _$FriendlyMatchStateCopyWith<$Res> {
  __$FriendlyMatchStateCopyWithImpl(this._self, this._then);

  final _FriendlyMatchState _self;
  final $Res Function(_FriendlyMatchState) _then;

/// Create a copy of FriendlyMatchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? mode = null,Object? platform = null,Object? roomNumber = null,Object? message = null,Object? sender = null,}) {
  return _then(_FriendlyMatchState(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,roomNumber: null == roomNumber ? _self.roomNumber : roomNumber // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
