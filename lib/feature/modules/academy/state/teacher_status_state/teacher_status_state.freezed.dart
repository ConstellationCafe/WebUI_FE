// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherStatusState {

 bool get isLoading; bool get isProcessing; TeacherStatus get teacherStatus; String? get errorMessage;
/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherStatusStateCopyWith<TeacherStatusState> get copyWith => _$TeacherStatusStateCopyWithImpl<TeacherStatusState>(this as TeacherStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.teacherStatus, teacherStatus) || other.teacherStatus == teacherStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,teacherStatus,errorMessage);

@override
String toString() {
  return 'TeacherStatusState(isLoading: $isLoading, isProcessing: $isProcessing, teacherStatus: $teacherStatus, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TeacherStatusStateCopyWith<$Res>  {
  factory $TeacherStatusStateCopyWith(TeacherStatusState value, $Res Function(TeacherStatusState) _then) = _$TeacherStatusStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isProcessing, TeacherStatus teacherStatus, String? errorMessage
});


$TeacherStatusCopyWith<$Res> get teacherStatus;

}
/// @nodoc
class _$TeacherStatusStateCopyWithImpl<$Res>
    implements $TeacherStatusStateCopyWith<$Res> {
  _$TeacherStatusStateCopyWithImpl(this._self, this._then);

  final TeacherStatusState _self;
  final $Res Function(TeacherStatusState) _then;

/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isProcessing = null,Object? teacherStatus = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,teacherStatus: null == teacherStatus ? _self.teacherStatus : teacherStatus // ignore: cast_nullable_to_non_nullable
as TeacherStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeacherStatusCopyWith<$Res> get teacherStatus {
  
  return $TeacherStatusCopyWith<$Res>(_self.teacherStatus, (value) {
    return _then(_self.copyWith(teacherStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeacherStatusState].
extension TeacherStatusStatePatterns on TeacherStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherStatusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherStatusState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherStatusState value)  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherStatusState value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  TeacherStatus teacherStatus,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.teacherStatus,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  TeacherStatus teacherStatus,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusState():
return $default(_that.isLoading,_that.isProcessing,_that.teacherStatus,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isProcessing,  TeacherStatus teacherStatus,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.teacherStatus,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherStatusState implements TeacherStatusState {
  const _TeacherStatusState({this.isLoading = false, this.isProcessing = false, this.teacherStatus = const TeacherStatus(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  TeacherStatus teacherStatus;
@override final  String? errorMessage;

/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherStatusStateCopyWith<_TeacherStatusState> get copyWith => __$TeacherStatusStateCopyWithImpl<_TeacherStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.teacherStatus, teacherStatus) || other.teacherStatus == teacherStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,teacherStatus,errorMessage);

@override
String toString() {
  return 'TeacherStatusState(isLoading: $isLoading, isProcessing: $isProcessing, teacherStatus: $teacherStatus, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TeacherStatusStateCopyWith<$Res> implements $TeacherStatusStateCopyWith<$Res> {
  factory _$TeacherStatusStateCopyWith(_TeacherStatusState value, $Res Function(_TeacherStatusState) _then) = __$TeacherStatusStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isProcessing, TeacherStatus teacherStatus, String? errorMessage
});


@override $TeacherStatusCopyWith<$Res> get teacherStatus;

}
/// @nodoc
class __$TeacherStatusStateCopyWithImpl<$Res>
    implements _$TeacherStatusStateCopyWith<$Res> {
  __$TeacherStatusStateCopyWithImpl(this._self, this._then);

  final _TeacherStatusState _self;
  final $Res Function(_TeacherStatusState) _then;

/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isProcessing = null,Object? teacherStatus = null,Object? errorMessage = freezed,}) {
  return _then(_TeacherStatusState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,teacherStatus: null == teacherStatus ? _self.teacherStatus : teacherStatus // ignore: cast_nullable_to_non_nullable
as TeacherStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TeacherStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeacherStatusCopyWith<$Res> get teacherStatus {
  
  return $TeacherStatusCopyWith<$Res>(_self.teacherStatus, (value) {
    return _then(_self.copyWith(teacherStatus: value));
  });
}
}

// dart format on
