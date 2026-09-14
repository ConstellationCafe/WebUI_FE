// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatusView<T,K extends RosterStatus> {

 T get academyMember; Academy get academy; AcademyClass get academyClass; K get status; DateTime? get statusChangedAt; String? get reason;
/// Create a copy of StatusView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusViewCopyWith<T, K, StatusView<T, K>> get copyWith => _$StatusViewCopyWithImpl<T, K, StatusView<T, K>>(this as StatusView<T, K>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusView<T, K>&&const DeepCollectionEquality().equals(other.academyMember, academyMember)&&(identical(other.academy, academy) || other.academy == academy)&&(identical(other.academyClass, academyClass) || other.academyClass == academyClass)&&const DeepCollectionEquality().equals(other.status, status)&&(identical(other.statusChangedAt, statusChangedAt) || other.statusChangedAt == statusChangedAt)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academyMember),academy,academyClass,const DeepCollectionEquality().hash(status),statusChangedAt,reason);

@override
String toString() {
  return 'StatusView<$T, $K>(academyMember: $academyMember, academy: $academy, academyClass: $academyClass, status: $status, statusChangedAt: $statusChangedAt, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $StatusViewCopyWith<T,K extends RosterStatus,$Res>  {
  factory $StatusViewCopyWith(StatusView<T, K> value, $Res Function(StatusView<T, K>) _then) = _$StatusViewCopyWithImpl;
@useResult
$Res call({
 T academyMember, Academy academy, AcademyClass academyClass, K status, DateTime? statusChangedAt, String? reason
});




}
/// @nodoc
class _$StatusViewCopyWithImpl<T,K extends RosterStatus,$Res>
    implements $StatusViewCopyWith<T, K, $Res> {
  _$StatusViewCopyWithImpl(this._self, this._then);

  final StatusView<T, K> _self;
  final $Res Function(StatusView<T, K>) _then;

/// Create a copy of StatusView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academyMember = freezed,Object? academy = null,Object? academyClass = null,Object? status = null,Object? statusChangedAt = freezed,Object? reason = freezed,}) {
  return _then(_self.copyWith(
academyMember: freezed == academyMember ? _self.academyMember : academyMember // ignore: cast_nullable_to_non_nullable
as T,academy: null == academy ? _self.academy : academy // ignore: cast_nullable_to_non_nullable
as Academy,academyClass: null == academyClass ? _self.academyClass : academyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as K,statusChangedAt: freezed == statusChangedAt ? _self.statusChangedAt : statusChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusView].
extension StatusViewPatterns<T,K extends RosterStatus> on StatusView<T, K> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusView<T, K> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusView<T, K> value)  $default,){
final _that = this;
switch (_that) {
case _StatusView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusView<T, K> value)?  $default,){
final _that = this;
switch (_that) {
case _StatusView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T academyMember,  Academy academy,  AcademyClass academyClass,  K status,  DateTime? statusChangedAt,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusView() when $default != null:
return $default(_that.academyMember,_that.academy,_that.academyClass,_that.status,_that.statusChangedAt,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T academyMember,  Academy academy,  AcademyClass academyClass,  K status,  DateTime? statusChangedAt,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _StatusView():
return $default(_that.academyMember,_that.academy,_that.academyClass,_that.status,_that.statusChangedAt,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T academyMember,  Academy academy,  AcademyClass academyClass,  K status,  DateTime? statusChangedAt,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _StatusView() when $default != null:
return $default(_that.academyMember,_that.academy,_that.academyClass,_that.status,_that.statusChangedAt,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _StatusView<T,K extends RosterStatus> implements StatusView<T, K> {
  const _StatusView({required this.academyMember, required this.academy, required this.academyClass, required this.status, this.statusChangedAt, this.reason});
  

@override final  T academyMember;
@override final  Academy academy;
@override final  AcademyClass academyClass;
@override final  K status;
@override final  DateTime? statusChangedAt;
@override final  String? reason;

/// Create a copy of StatusView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusViewCopyWith<T, K, _StatusView<T, K>> get copyWith => __$StatusViewCopyWithImpl<T, K, _StatusView<T, K>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusView<T, K>&&const DeepCollectionEquality().equals(other.academyMember, academyMember)&&(identical(other.academy, academy) || other.academy == academy)&&(identical(other.academyClass, academyClass) || other.academyClass == academyClass)&&const DeepCollectionEquality().equals(other.status, status)&&(identical(other.statusChangedAt, statusChangedAt) || other.statusChangedAt == statusChangedAt)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academyMember),academy,academyClass,const DeepCollectionEquality().hash(status),statusChangedAt,reason);

@override
String toString() {
  return 'StatusView<$T, $K>(academyMember: $academyMember, academy: $academy, academyClass: $academyClass, status: $status, statusChangedAt: $statusChangedAt, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$StatusViewCopyWith<T,K extends RosterStatus,$Res> implements $StatusViewCopyWith<T, K, $Res> {
  factory _$StatusViewCopyWith(_StatusView<T, K> value, $Res Function(_StatusView<T, K>) _then) = __$StatusViewCopyWithImpl;
@override @useResult
$Res call({
 T academyMember, Academy academy, AcademyClass academyClass, K status, DateTime? statusChangedAt, String? reason
});




}
/// @nodoc
class __$StatusViewCopyWithImpl<T,K extends RosterStatus,$Res>
    implements _$StatusViewCopyWith<T, K, $Res> {
  __$StatusViewCopyWithImpl(this._self, this._then);

  final _StatusView<T, K> _self;
  final $Res Function(_StatusView<T, K>) _then;

/// Create a copy of StatusView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academyMember = freezed,Object? academy = null,Object? academyClass = null,Object? status = null,Object? statusChangedAt = freezed,Object? reason = freezed,}) {
  return _then(_StatusView<T, K>(
academyMember: freezed == academyMember ? _self.academyMember : academyMember // ignore: cast_nullable_to_non_nullable
as T,academy: null == academy ? _self.academy : academy // ignore: cast_nullable_to_non_nullable
as Academy,academyClass: null == academyClass ? _self.academyClass : academyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as K,statusChangedAt: freezed == statusChangedAt ? _self.statusChangedAt : statusChangedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
