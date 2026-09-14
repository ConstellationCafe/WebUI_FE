// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_status_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherStatusListState {

 bool get isLoading; bool get isFilterLoading; StatusQuery<Teacher, TeacherRosterStatus> get query; TeacherStatusList get teacherStatusList; String? get errorMessage;
/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherStatusListStateCopyWith<TeacherStatusListState> get copyWith => _$TeacherStatusListStateCopyWithImpl<TeacherStatusListState>(this as TeacherStatusListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherStatusListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.query, query) || other.query == query)&&(identical(other.teacherStatusList, teacherStatusList) || other.teacherStatusList == teacherStatusList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,query,teacherStatusList,errorMessage);

@override
String toString() {
  return 'TeacherStatusListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, query: $query, teacherStatusList: $teacherStatusList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TeacherStatusListStateCopyWith<$Res>  {
  factory $TeacherStatusListStateCopyWith(TeacherStatusListState value, $Res Function(TeacherStatusListState) _then) = _$TeacherStatusListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isFilterLoading, StatusQuery<Teacher, TeacherRosterStatus> query, TeacherStatusList teacherStatusList, String? errorMessage
});


$StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res> get query;$TeacherStatusListCopyWith<$Res> get teacherStatusList;

}
/// @nodoc
class _$TeacherStatusListStateCopyWithImpl<$Res>
    implements $TeacherStatusListStateCopyWith<$Res> {
  _$TeacherStatusListStateCopyWithImpl(this._self, this._then);

  final TeacherStatusListState _self;
  final $Res Function(TeacherStatusListState) _then;

/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? query = null,Object? teacherStatusList = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as StatusQuery<Teacher, TeacherRosterStatus>,teacherStatusList: null == teacherStatusList ? _self.teacherStatusList : teacherStatusList // ignore: cast_nullable_to_non_nullable
as TeacherStatusList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res> get query {
  
  return $StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeacherStatusListCopyWith<$Res> get teacherStatusList {
  
  return $TeacherStatusListCopyWith<$Res>(_self.teacherStatusList, (value) {
    return _then(_self.copyWith(teacherStatusList: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeacherStatusListState].
extension TeacherStatusListStatePatterns on TeacherStatusListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherStatusListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherStatusListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherStatusListState value)  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherStatusListState value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  StatusQuery<Teacher, TeacherRosterStatus> query,  TeacherStatusList teacherStatusList,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherStatusListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.teacherStatusList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  StatusQuery<Teacher, TeacherRosterStatus> query,  TeacherStatusList teacherStatusList,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusListState():
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.teacherStatusList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isFilterLoading,  StatusQuery<Teacher, TeacherRosterStatus> query,  TeacherStatusList teacherStatusList,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.teacherStatusList,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherStatusListState implements TeacherStatusListState {
  const _TeacherStatusListState({this.isLoading = false, this.isFilterLoading = false, this.query = const StatusQuery<Teacher, TeacherRosterStatus>(), this.teacherStatusList = const TeacherStatusList(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFilterLoading;
@override@JsonKey() final  StatusQuery<Teacher, TeacherRosterStatus> query;
@override@JsonKey() final  TeacherStatusList teacherStatusList;
@override final  String? errorMessage;

/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherStatusListStateCopyWith<_TeacherStatusListState> get copyWith => __$TeacherStatusListStateCopyWithImpl<_TeacherStatusListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherStatusListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.query, query) || other.query == query)&&(identical(other.teacherStatusList, teacherStatusList) || other.teacherStatusList == teacherStatusList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,query,teacherStatusList,errorMessage);

@override
String toString() {
  return 'TeacherStatusListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, query: $query, teacherStatusList: $teacherStatusList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TeacherStatusListStateCopyWith<$Res> implements $TeacherStatusListStateCopyWith<$Res> {
  factory _$TeacherStatusListStateCopyWith(_TeacherStatusListState value, $Res Function(_TeacherStatusListState) _then) = __$TeacherStatusListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isFilterLoading, StatusQuery<Teacher, TeacherRosterStatus> query, TeacherStatusList teacherStatusList, String? errorMessage
});


@override $StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res> get query;@override $TeacherStatusListCopyWith<$Res> get teacherStatusList;

}
/// @nodoc
class __$TeacherStatusListStateCopyWithImpl<$Res>
    implements _$TeacherStatusListStateCopyWith<$Res> {
  __$TeacherStatusListStateCopyWithImpl(this._self, this._then);

  final _TeacherStatusListState _self;
  final $Res Function(_TeacherStatusListState) _then;

/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? query = null,Object? teacherStatusList = null,Object? errorMessage = freezed,}) {
  return _then(_TeacherStatusListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as StatusQuery<Teacher, TeacherRosterStatus>,teacherStatusList: null == teacherStatusList ? _self.teacherStatusList : teacherStatusList // ignore: cast_nullable_to_non_nullable
as TeacherStatusList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res> get query {
  
  return $StatusQueryCopyWith<Teacher, TeacherRosterStatus, $Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}/// Create a copy of TeacherStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeacherStatusListCopyWith<$Res> get teacherStatusList {
  
  return $TeacherStatusListCopyWith<$Res>(_self.teacherStatusList, (value) {
    return _then(_self.copyWith(teacherStatusList: value));
  });
}
}

// dart format on
