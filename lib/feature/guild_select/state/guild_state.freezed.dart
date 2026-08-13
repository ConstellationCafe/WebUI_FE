// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guild_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentGuildState {

 String get guildId; String get guildName; String? get guildIcon;
/// Create a copy of CurrentGuildState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentGuildStateCopyWith<CurrentGuildState> get copyWith => _$CurrentGuildStateCopyWithImpl<CurrentGuildState>(this as CurrentGuildState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentGuildState&&(identical(other.guildId, guildId) || other.guildId == guildId)&&(identical(other.guildName, guildName) || other.guildName == guildName)&&(identical(other.guildIcon, guildIcon) || other.guildIcon == guildIcon));
}


@override
int get hashCode => Object.hash(runtimeType,guildId,guildName,guildIcon);

@override
String toString() {
  return 'CurrentGuildState(guildId: $guildId, guildName: $guildName, guildIcon: $guildIcon)';
}


}

/// @nodoc
abstract mixin class $CurrentGuildStateCopyWith<$Res>  {
  factory $CurrentGuildStateCopyWith(CurrentGuildState value, $Res Function(CurrentGuildState) _then) = _$CurrentGuildStateCopyWithImpl;
@useResult
$Res call({
 String guildId, String guildName, String? guildIcon
});




}
/// @nodoc
class _$CurrentGuildStateCopyWithImpl<$Res>
    implements $CurrentGuildStateCopyWith<$Res> {
  _$CurrentGuildStateCopyWithImpl(this._self, this._then);

  final CurrentGuildState _self;
  final $Res Function(CurrentGuildState) _then;

/// Create a copy of CurrentGuildState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? guildId = null,Object? guildName = null,Object? guildIcon = freezed,}) {
  return _then(_self.copyWith(
guildId: null == guildId ? _self.guildId : guildId // ignore: cast_nullable_to_non_nullable
as String,guildName: null == guildName ? _self.guildName : guildName // ignore: cast_nullable_to_non_nullable
as String,guildIcon: freezed == guildIcon ? _self.guildIcon : guildIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentGuildState].
extension CurrentGuildStatePatterns on CurrentGuildState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentGuildState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentGuildState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentGuildState value)  $default,){
final _that = this;
switch (_that) {
case _CurrentGuildState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentGuildState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentGuildState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String guildId,  String guildName,  String? guildIcon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentGuildState() when $default != null:
return $default(_that.guildId,_that.guildName,_that.guildIcon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String guildId,  String guildName,  String? guildIcon)  $default,) {final _that = this;
switch (_that) {
case _CurrentGuildState():
return $default(_that.guildId,_that.guildName,_that.guildIcon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String guildId,  String guildName,  String? guildIcon)?  $default,) {final _that = this;
switch (_that) {
case _CurrentGuildState() when $default != null:
return $default(_that.guildId,_that.guildName,_that.guildIcon);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentGuildState implements CurrentGuildState {
  const _CurrentGuildState({required this.guildId, required this.guildName, this.guildIcon});
  

@override final  String guildId;
@override final  String guildName;
@override final  String? guildIcon;

/// Create a copy of CurrentGuildState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentGuildStateCopyWith<_CurrentGuildState> get copyWith => __$CurrentGuildStateCopyWithImpl<_CurrentGuildState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentGuildState&&(identical(other.guildId, guildId) || other.guildId == guildId)&&(identical(other.guildName, guildName) || other.guildName == guildName)&&(identical(other.guildIcon, guildIcon) || other.guildIcon == guildIcon));
}


@override
int get hashCode => Object.hash(runtimeType,guildId,guildName,guildIcon);

@override
String toString() {
  return 'CurrentGuildState(guildId: $guildId, guildName: $guildName, guildIcon: $guildIcon)';
}


}

/// @nodoc
abstract mixin class _$CurrentGuildStateCopyWith<$Res> implements $CurrentGuildStateCopyWith<$Res> {
  factory _$CurrentGuildStateCopyWith(_CurrentGuildState value, $Res Function(_CurrentGuildState) _then) = __$CurrentGuildStateCopyWithImpl;
@override @useResult
$Res call({
 String guildId, String guildName, String? guildIcon
});




}
/// @nodoc
class __$CurrentGuildStateCopyWithImpl<$Res>
    implements _$CurrentGuildStateCopyWith<$Res> {
  __$CurrentGuildStateCopyWithImpl(this._self, this._then);

  final _CurrentGuildState _self;
  final $Res Function(_CurrentGuildState) _then;

/// Create a copy of CurrentGuildState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? guildId = null,Object? guildName = null,Object? guildIcon = freezed,}) {
  return _then(_CurrentGuildState(
guildId: null == guildId ? _self.guildId : guildId // ignore: cast_nullable_to_non_nullable
as String,guildName: null == guildName ? _self.guildName : guildName // ignore: cast_nullable_to_non_nullable
as String,guildIcon: freezed == guildIcon ? _self.guildIcon : guildIcon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
