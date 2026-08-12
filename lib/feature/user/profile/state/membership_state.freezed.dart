// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'membership_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MembershipState {

 bool get isLoading; String get username; String? get uid1; String? get uid2; String? get role; String get coin; String? get s1Data; String? get s2Data; String? get guild; String get joinAt; String get avatar;
/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipStateCopyWith<MembershipState> get copyWith => _$MembershipStateCopyWithImpl<MembershipState>(this as MembershipState, _$identity);

  /// Serializes this MembershipState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.username, username) || other.username == username)&&(identical(other.uid1, uid1) || other.uid1 == uid1)&&(identical(other.uid2, uid2) || other.uid2 == uid2)&&(identical(other.role, role) || other.role == role)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.s1Data, s1Data) || other.s1Data == s1Data)&&(identical(other.s2Data, s2Data) || other.s2Data == s2Data)&&(identical(other.guild, guild) || other.guild == guild)&&(identical(other.joinAt, joinAt) || other.joinAt == joinAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,username,uid1,uid2,role,coin,s1Data,s2Data,guild,joinAt,avatar);

@override
String toString() {
  return 'MembershipState(isLoading: $isLoading, username: $username, uid1: $uid1, uid2: $uid2, role: $role, coin: $coin, s1Data: $s1Data, s2Data: $s2Data, guild: $guild, joinAt: $joinAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $MembershipStateCopyWith<$Res>  {
  factory $MembershipStateCopyWith(MembershipState value, $Res Function(MembershipState) _then) = _$MembershipStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String username, String? uid1, String? uid2, String? role, String coin, String? s1Data, String? s2Data, String? guild, String joinAt, String avatar
});




}
/// @nodoc
class _$MembershipStateCopyWithImpl<$Res>
    implements $MembershipStateCopyWith<$Res> {
  _$MembershipStateCopyWithImpl(this._self, this._then);

  final MembershipState _self;
  final $Res Function(MembershipState) _then;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? username = null,Object? uid1 = freezed,Object? uid2 = freezed,Object? role = freezed,Object? coin = null,Object? s1Data = freezed,Object? s2Data = freezed,Object? guild = freezed,Object? joinAt = null,Object? avatar = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,uid1: freezed == uid1 ? _self.uid1 : uid1 // ignore: cast_nullable_to_non_nullable
as String?,uid2: freezed == uid2 ? _self.uid2 : uid2 // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,s1Data: freezed == s1Data ? _self.s1Data : s1Data // ignore: cast_nullable_to_non_nullable
as String?,s2Data: freezed == s2Data ? _self.s2Data : s2Data // ignore: cast_nullable_to_non_nullable
as String?,guild: freezed == guild ? _self.guild : guild // ignore: cast_nullable_to_non_nullable
as String?,joinAt: null == joinAt ? _self.joinAt : joinAt // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MembershipState].
extension MembershipStatePatterns on MembershipState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipState value)  $default,){
final _that = this;
switch (_that) {
case _MembershipState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipState value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  String username,  String? uid1,  String? uid2,  String? role,  String coin,  String? s1Data,  String? s2Data,  String? guild,  String joinAt,  String avatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
return $default(_that.isLoading,_that.username,_that.uid1,_that.uid2,_that.role,_that.coin,_that.s1Data,_that.s2Data,_that.guild,_that.joinAt,_that.avatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  String username,  String? uid1,  String? uid2,  String? role,  String coin,  String? s1Data,  String? s2Data,  String? guild,  String joinAt,  String avatar)  $default,) {final _that = this;
switch (_that) {
case _MembershipState():
return $default(_that.isLoading,_that.username,_that.uid1,_that.uid2,_that.role,_that.coin,_that.s1Data,_that.s2Data,_that.guild,_that.joinAt,_that.avatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  String username,  String? uid1,  String? uid2,  String? role,  String coin,  String? s1Data,  String? s2Data,  String? guild,  String joinAt,  String avatar)?  $default,) {final _that = this;
switch (_that) {
case _MembershipState() when $default != null:
return $default(_that.isLoading,_that.username,_that.uid1,_that.uid2,_that.role,_that.coin,_that.s1Data,_that.s2Data,_that.guild,_that.joinAt,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MembershipState implements MembershipState {
  const _MembershipState({this.isLoading = true, required this.username, this.uid1, this.uid2, this.role, this.coin = "0", this.s1Data, this.s2Data, this.guild, required this.joinAt, required this.avatar});
  factory _MembershipState.fromJson(Map<String, dynamic> json) => _$MembershipStateFromJson(json);

@override@JsonKey() final  bool isLoading;
@override final  String username;
@override final  String? uid1;
@override final  String? uid2;
@override final  String? role;
@override@JsonKey() final  String coin;
@override final  String? s1Data;
@override final  String? s2Data;
@override final  String? guild;
@override final  String joinAt;
@override final  String avatar;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipStateCopyWith<_MembershipState> get copyWith => __$MembershipStateCopyWithImpl<_MembershipState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MembershipStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.username, username) || other.username == username)&&(identical(other.uid1, uid1) || other.uid1 == uid1)&&(identical(other.uid2, uid2) || other.uid2 == uid2)&&(identical(other.role, role) || other.role == role)&&(identical(other.coin, coin) || other.coin == coin)&&(identical(other.s1Data, s1Data) || other.s1Data == s1Data)&&(identical(other.s2Data, s2Data) || other.s2Data == s2Data)&&(identical(other.guild, guild) || other.guild == guild)&&(identical(other.joinAt, joinAt) || other.joinAt == joinAt)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLoading,username,uid1,uid2,role,coin,s1Data,s2Data,guild,joinAt,avatar);

@override
String toString() {
  return 'MembershipState(isLoading: $isLoading, username: $username, uid1: $uid1, uid2: $uid2, role: $role, coin: $coin, s1Data: $s1Data, s2Data: $s2Data, guild: $guild, joinAt: $joinAt, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$MembershipStateCopyWith<$Res> implements $MembershipStateCopyWith<$Res> {
  factory _$MembershipStateCopyWith(_MembershipState value, $Res Function(_MembershipState) _then) = __$MembershipStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, String username, String? uid1, String? uid2, String? role, String coin, String? s1Data, String? s2Data, String? guild, String joinAt, String avatar
});




}
/// @nodoc
class __$MembershipStateCopyWithImpl<$Res>
    implements _$MembershipStateCopyWith<$Res> {
  __$MembershipStateCopyWithImpl(this._self, this._then);

  final _MembershipState _self;
  final $Res Function(_MembershipState) _then;

/// Create a copy of MembershipState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? username = null,Object? uid1 = freezed,Object? uid2 = freezed,Object? role = freezed,Object? coin = null,Object? s1Data = freezed,Object? s2Data = freezed,Object? guild = freezed,Object? joinAt = null,Object? avatar = null,}) {
  return _then(_MembershipState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,uid1: freezed == uid1 ? _self.uid1 : uid1 // ignore: cast_nullable_to_non_nullable
as String?,uid2: freezed == uid2 ? _self.uid2 : uid2 // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,coin: null == coin ? _self.coin : coin // ignore: cast_nullable_to_non_nullable
as String,s1Data: freezed == s1Data ? _self.s1Data : s1Data // ignore: cast_nullable_to_non_nullable
as String?,s2Data: freezed == s2Data ? _self.s2Data : s2Data // ignore: cast_nullable_to_non_nullable
as String?,guild: freezed == guild ? _self.guild : guild // ignore: cast_nullable_to_non_nullable
as String?,joinAt: null == joinAt ? _self.joinAt : joinAt // ignore: cast_nullable_to_non_nullable
as String,avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
