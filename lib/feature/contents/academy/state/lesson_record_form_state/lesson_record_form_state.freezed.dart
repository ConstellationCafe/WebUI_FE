// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordFormState {

 bool get isLoading; bool get isSaving; dynamic get lessonRecordForm; String? get errorMessage;
/// Create a copy of LessonRecordFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordFormStateCopyWith<LessonRecordFormState> get copyWith => _$LessonRecordFormStateCopyWithImpl<LessonRecordFormState>(this as LessonRecordFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordFormState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other.lessonRecordForm, lessonRecordForm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(lessonRecordForm),errorMessage);

@override
String toString() {
  return 'LessonRecordFormState(isLoading: $isLoading, isSaving: $isSaving, lessonRecordForm: $lessonRecordForm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonRecordFormStateCopyWith<$Res>  {
  factory $LessonRecordFormStateCopyWith(LessonRecordFormState value, $Res Function(LessonRecordFormState) _then) = _$LessonRecordFormStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isSaving, dynamic lessonRecordForm, String? errorMessage
});




}
/// @nodoc
class _$LessonRecordFormStateCopyWithImpl<$Res>
    implements $LessonRecordFormStateCopyWith<$Res> {
  _$LessonRecordFormStateCopyWithImpl(this._self, this._then);

  final LessonRecordFormState _self;
  final $Res Function(LessonRecordFormState) _then;

/// Create a copy of LessonRecordFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isSaving = null,Object? lessonRecordForm = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,lessonRecordForm: freezed == lessonRecordForm ? _self.lessonRecordForm : lessonRecordForm // ignore: cast_nullable_to_non_nullable
as dynamic,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonRecordFormState].
extension LessonRecordFormStatePatterns on LessonRecordFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordFormState value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  dynamic lessonRecordForm,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordFormState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.lessonRecordForm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isSaving,  dynamic lessonRecordForm,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordFormState():
return $default(_that.isLoading,_that.isSaving,_that.lessonRecordForm,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isSaving,  dynamic lessonRecordForm,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordFormState() when $default != null:
return $default(_that.isLoading,_that.isSaving,_that.lessonRecordForm,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordFormState implements LessonRecordFormState {
  const _LessonRecordFormState({this.isLoading = false, this.isSaving = false, this.lessonRecordForm = const LessonRecordForm(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isSaving;
@override@JsonKey() final  dynamic lessonRecordForm;
@override final  String? errorMessage;

/// Create a copy of LessonRecordFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordFormStateCopyWith<_LessonRecordFormState> get copyWith => __$LessonRecordFormStateCopyWithImpl<_LessonRecordFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordFormState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isSaving, isSaving) || other.isSaving == isSaving)&&const DeepCollectionEquality().equals(other.lessonRecordForm, lessonRecordForm)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isSaving,const DeepCollectionEquality().hash(lessonRecordForm),errorMessage);

@override
String toString() {
  return 'LessonRecordFormState(isLoading: $isLoading, isSaving: $isSaving, lessonRecordForm: $lessonRecordForm, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordFormStateCopyWith<$Res> implements $LessonRecordFormStateCopyWith<$Res> {
  factory _$LessonRecordFormStateCopyWith(_LessonRecordFormState value, $Res Function(_LessonRecordFormState) _then) = __$LessonRecordFormStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isSaving, dynamic lessonRecordForm, String? errorMessage
});




}
/// @nodoc
class __$LessonRecordFormStateCopyWithImpl<$Res>
    implements _$LessonRecordFormStateCopyWith<$Res> {
  __$LessonRecordFormStateCopyWithImpl(this._self, this._then);

  final _LessonRecordFormState _self;
  final $Res Function(_LessonRecordFormState) _then;

/// Create a copy of LessonRecordFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isSaving = null,Object? lessonRecordForm = freezed,Object? errorMessage = freezed,}) {
  return _then(_LessonRecordFormState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isSaving: null == isSaving ? _self.isSaving : isSaving // ignore: cast_nullable_to_non_nullable
as bool,lessonRecordForm: freezed == lessonRecordForm ? _self.lessonRecordForm : lessonRecordForm // ignore: cast_nullable_to_non_nullable
as dynamic,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
