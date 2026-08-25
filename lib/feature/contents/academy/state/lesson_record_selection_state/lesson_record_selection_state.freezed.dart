// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordSelectionState {

 bool get isLoading; LessonRecordSelection get queryForm; String? get errorMessage;
/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordSelectionStateCopyWith<LessonRecordSelectionState> get copyWith => _$LessonRecordSelectionStateCopyWithImpl<LessonRecordSelectionState>(this as LessonRecordSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordSelectionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.queryForm, queryForm) || other.queryForm == queryForm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,queryForm,errorMessage);

@override
String toString() {
  return 'LessonRecordSelectionState(isLoading: $isLoading, queryForm: $queryForm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonRecordSelectionStateCopyWith<$Res>  {
  factory $LessonRecordSelectionStateCopyWith(LessonRecordSelectionState value, $Res Function(LessonRecordSelectionState) _then) = _$LessonRecordSelectionStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, LessonRecordSelection queryForm, String? errorMessage
});


$LessonRecordSelectionCopyWith<$Res> get queryForm;

}
/// @nodoc
class _$LessonRecordSelectionStateCopyWithImpl<$Res>
    implements $LessonRecordSelectionStateCopyWith<$Res> {
  _$LessonRecordSelectionStateCopyWithImpl(this._self, this._then);

  final LessonRecordSelectionState _self;
  final $Res Function(LessonRecordSelectionState) _then;

/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? queryForm = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,queryForm: null == queryForm ? _self.queryForm : queryForm // ignore: cast_nullable_to_non_nullable
as LessonRecordSelection,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonRecordSelectionCopyWith<$Res> get queryForm {
  
  return $LessonRecordSelectionCopyWith<$Res>(_self.queryForm, (value) {
    return _then(_self.copyWith(queryForm: value));
  });
}
}


/// Adds pattern-matching-related methods to [LessonRecordSelectionState].
extension LessonRecordSelectionStatePatterns on LessonRecordSelectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordSelectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordSelectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordSelectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  LessonRecordSelection queryForm,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordSelectionState() when $default != null:
return $default(_that.isLoading,_that.queryForm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  LessonRecordSelection queryForm,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordSelectionState():
return $default(_that.isLoading,_that.queryForm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  LessonRecordSelection queryForm,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordSelectionState() when $default != null:
return $default(_that.isLoading,_that.queryForm,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordSelectionState implements LessonRecordSelectionState {
  const _LessonRecordSelectionState({this.isLoading = false, this.queryForm = const LessonRecordSelection(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  LessonRecordSelection queryForm;
@override final  String? errorMessage;

/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordSelectionStateCopyWith<_LessonRecordSelectionState> get copyWith => __$LessonRecordSelectionStateCopyWithImpl<_LessonRecordSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordSelectionState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.queryForm, queryForm) || other.queryForm == queryForm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,queryForm,errorMessage);

@override
String toString() {
  return 'LessonRecordSelectionState(isLoading: $isLoading, queryForm: $queryForm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordSelectionStateCopyWith<$Res> implements $LessonRecordSelectionStateCopyWith<$Res> {
  factory _$LessonRecordSelectionStateCopyWith(_LessonRecordSelectionState value, $Res Function(_LessonRecordSelectionState) _then) = __$LessonRecordSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, LessonRecordSelection queryForm, String? errorMessage
});


@override $LessonRecordSelectionCopyWith<$Res> get queryForm;

}
/// @nodoc
class __$LessonRecordSelectionStateCopyWithImpl<$Res>
    implements _$LessonRecordSelectionStateCopyWith<$Res> {
  __$LessonRecordSelectionStateCopyWithImpl(this._self, this._then);

  final _LessonRecordSelectionState _self;
  final $Res Function(_LessonRecordSelectionState) _then;

/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? queryForm = null,Object? errorMessage = freezed,}) {
  return _then(_LessonRecordSelectionState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,queryForm: null == queryForm ? _self.queryForm : queryForm // ignore: cast_nullable_to_non_nullable
as LessonRecordSelection,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LessonRecordSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonRecordSelectionCopyWith<$Res> get queryForm {
  
  return $LessonRecordSelectionCopyWith<$Res>(_self.queryForm, (value) {
    return _then(_self.copyWith(queryForm: value));
  });
}
}

// dart format on
