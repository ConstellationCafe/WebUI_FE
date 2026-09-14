// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordForm {

 String get description;
/// Create a copy of LessonRecordForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordFormCopyWith<LessonRecordForm> get copyWith => _$LessonRecordFormCopyWithImpl<LessonRecordForm>(this as LessonRecordForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordForm&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,description);

@override
String toString() {
  return 'LessonRecordForm(description: $description)';
}


}

/// @nodoc
abstract mixin class $LessonRecordFormCopyWith<$Res>  {
  factory $LessonRecordFormCopyWith(LessonRecordForm value, $Res Function(LessonRecordForm) _then) = _$LessonRecordFormCopyWithImpl;
@useResult
$Res call({
 String description
});




}
/// @nodoc
class _$LessonRecordFormCopyWithImpl<$Res>
    implements $LessonRecordFormCopyWith<$Res> {
  _$LessonRecordFormCopyWithImpl(this._self, this._then);

  final LessonRecordForm _self;
  final $Res Function(LessonRecordForm) _then;

/// Create a copy of LessonRecordForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonRecordForm].
extension LessonRecordFormPatterns on LessonRecordForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordForm value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordForm value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordForm() when $default != null:
return $default(_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordForm():
return $default(_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordForm() when $default != null:
return $default(_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordForm implements LessonRecordForm {
  const _LessonRecordForm({this.description = ''});
  

@override@JsonKey() final  String description;

/// Create a copy of LessonRecordForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordFormCopyWith<_LessonRecordForm> get copyWith => __$LessonRecordFormCopyWithImpl<_LessonRecordForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordForm&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,description);

@override
String toString() {
  return 'LessonRecordForm(description: $description)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordFormCopyWith<$Res> implements $LessonRecordFormCopyWith<$Res> {
  factory _$LessonRecordFormCopyWith(_LessonRecordForm value, $Res Function(_LessonRecordForm) _then) = __$LessonRecordFormCopyWithImpl;
@override @useResult
$Res call({
 String description
});




}
/// @nodoc
class __$LessonRecordFormCopyWithImpl<$Res>
    implements _$LessonRecordFormCopyWith<$Res> {
  __$LessonRecordFormCopyWithImpl(this._self, this._then);

  final _LessonRecordForm _self;
  final $Res Function(_LessonRecordForm) _then;

/// Create a copy of LessonRecordForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,}) {
  return _then(_LessonRecordForm(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
