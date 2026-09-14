// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatusState {

 bool get isLoading; bool get isProcessing; StudentStatus get studentStatus; String? get errorMessage;
/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusStateCopyWith<StudentStatusState> get copyWith => _$StudentStatusStateCopyWithImpl<StudentStatusState>(this as StudentStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.studentStatus, studentStatus) || other.studentStatus == studentStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,studentStatus,errorMessage);

@override
String toString() {
  return 'StudentStatusState(isLoading: $isLoading, isProcessing: $isProcessing, studentStatus: $studentStatus, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StudentStatusStateCopyWith<$Res>  {
  factory $StudentStatusStateCopyWith(StudentStatusState value, $Res Function(StudentStatusState) _then) = _$StudentStatusStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isProcessing, StudentStatus studentStatus, String? errorMessage
});


$StudentStatusCopyWith<$Res> get studentStatus;

}
/// @nodoc
class _$StudentStatusStateCopyWithImpl<$Res>
    implements $StudentStatusStateCopyWith<$Res> {
  _$StudentStatusStateCopyWithImpl(this._self, this._then);

  final StudentStatusState _self;
  final $Res Function(StudentStatusState) _then;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isProcessing = null,Object? studentStatus = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,studentStatus: null == studentStatus ? _self.studentStatus : studentStatus // ignore: cast_nullable_to_non_nullable
as StudentStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusCopyWith<$Res> get studentStatus {
  
  return $StudentStatusCopyWith<$Res>(_self.studentStatus, (value) {
    return _then(_self.copyWith(studentStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudentStatusState].
extension StudentStatusStatePatterns on StudentStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatusState value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatusState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatusState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  StudentStatus studentStatus,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.studentStatus,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  StudentStatus studentStatus,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StudentStatusState():
return $default(_that.isLoading,_that.isProcessing,_that.studentStatus,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isProcessing,  StudentStatus studentStatus,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.studentStatus,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatusState implements StudentStatusState {
  const _StudentStatusState({this.isLoading = false, this.isProcessing = false, this.studentStatus = const StudentStatus(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
@override@JsonKey() final  StudentStatus studentStatus;
@override final  String? errorMessage;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusStateCopyWith<_StudentStatusState> get copyWith => __$StudentStatusStateCopyWithImpl<_StudentStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&(identical(other.studentStatus, studentStatus) || other.studentStatus == studentStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,studentStatus,errorMessage);

@override
String toString() {
  return 'StudentStatusState(isLoading: $isLoading, isProcessing: $isProcessing, studentStatus: $studentStatus, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusStateCopyWith<$Res> implements $StudentStatusStateCopyWith<$Res> {
  factory _$StudentStatusStateCopyWith(_StudentStatusState value, $Res Function(_StudentStatusState) _then) = __$StudentStatusStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isProcessing, StudentStatus studentStatus, String? errorMessage
});


@override $StudentStatusCopyWith<$Res> get studentStatus;

}
/// @nodoc
class __$StudentStatusStateCopyWithImpl<$Res>
    implements _$StudentStatusStateCopyWith<$Res> {
  __$StudentStatusStateCopyWithImpl(this._self, this._then);

  final _StudentStatusState _self;
  final $Res Function(_StudentStatusState) _then;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isProcessing = null,Object? studentStatus = null,Object? errorMessage = freezed,}) {
  return _then(_StudentStatusState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,studentStatus: null == studentStatus ? _self.studentStatus : studentStatus // ignore: cast_nullable_to_non_nullable
as StudentStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusCopyWith<$Res> get studentStatus {
  
  return $StudentStatusCopyWith<$Res>(_self.studentStatus, (value) {
    return _then(_self.copyWith(studentStatus: value));
  });
}
}

// dart format on
