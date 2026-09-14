// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordListState {

 bool get isLoading; bool get isFilterLoading; LessonRecordList get lessonRecordList; String? get errorMessage;
/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordListStateCopyWith<LessonRecordListState> get copyWith => _$LessonRecordListStateCopyWithImpl<LessonRecordListState>(this as LessonRecordListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.lessonRecordList, lessonRecordList) || other.lessonRecordList == lessonRecordList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,lessonRecordList,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, lessonRecordList: $lessonRecordList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonRecordListStateCopyWith<$Res>  {
  factory $LessonRecordListStateCopyWith(LessonRecordListState value, $Res Function(LessonRecordListState) _then) = _$LessonRecordListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isFilterLoading, LessonRecordList lessonRecordList, String? errorMessage
});


$LessonRecordListCopyWith<$Res> get lessonRecordList;

}
/// @nodoc
class _$LessonRecordListStateCopyWithImpl<$Res>
    implements $LessonRecordListStateCopyWith<$Res> {
  _$LessonRecordListStateCopyWithImpl(this._self, this._then);

  final LessonRecordListState _self;
  final $Res Function(LessonRecordListState) _then;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? lessonRecordList = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,lessonRecordList: null == lessonRecordList ? _self.lessonRecordList : lessonRecordList // ignore: cast_nullable_to_non_nullable
as LessonRecordList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonRecordListCopyWith<$Res> get lessonRecordList {
  
  return $LessonRecordListCopyWith<$Res>(_self.lessonRecordList, (value) {
    return _then(_self.copyWith(lessonRecordList: value));
  });
}
}


/// Adds pattern-matching-related methods to [LessonRecordListState].
extension LessonRecordListStatePatterns on LessonRecordListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordListState value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordListState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  LessonRecordList lessonRecordList,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.lessonRecordList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  LessonRecordList lessonRecordList,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState():
return $default(_that.isLoading,_that.isFilterLoading,_that.lessonRecordList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isFilterLoading,  LessonRecordList lessonRecordList,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.lessonRecordList,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordListState implements LessonRecordListState {
  const _LessonRecordListState({this.isLoading = false, this.isFilterLoading = false, this.lessonRecordList = const LessonRecordList(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFilterLoading;
@override@JsonKey() final  LessonRecordList lessonRecordList;
@override final  String? errorMessage;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordListStateCopyWith<_LessonRecordListState> get copyWith => __$LessonRecordListStateCopyWithImpl<_LessonRecordListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.lessonRecordList, lessonRecordList) || other.lessonRecordList == lessonRecordList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,lessonRecordList,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, lessonRecordList: $lessonRecordList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordListStateCopyWith<$Res> implements $LessonRecordListStateCopyWith<$Res> {
  factory _$LessonRecordListStateCopyWith(_LessonRecordListState value, $Res Function(_LessonRecordListState) _then) = __$LessonRecordListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isFilterLoading, LessonRecordList lessonRecordList, String? errorMessage
});


@override $LessonRecordListCopyWith<$Res> get lessonRecordList;

}
/// @nodoc
class __$LessonRecordListStateCopyWithImpl<$Res>
    implements _$LessonRecordListStateCopyWith<$Res> {
  __$LessonRecordListStateCopyWithImpl(this._self, this._then);

  final _LessonRecordListState _self;
  final $Res Function(_LessonRecordListState) _then;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? lessonRecordList = null,Object? errorMessage = freezed,}) {
  return _then(_LessonRecordListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,lessonRecordList: null == lessonRecordList ? _self.lessonRecordList : lessonRecordList // ignore: cast_nullable_to_non_nullable
as LessonRecordList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LessonRecordListCopyWith<$Res> get lessonRecordList {
  
  return $LessonRecordListCopyWith<$Res>(_self.lessonRecordList, (value) {
    return _then(_self.copyWith(lessonRecordList: value));
  });
}
}

// dart format on
