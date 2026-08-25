// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatusListState {

 bool get isLoading; bool get isFilterLoading; StudentStatusQuery get query; StudentStatusList get studentStatusList; String? get errorMessage;
/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusListStateCopyWith<StudentStatusListState> get copyWith => _$StudentStatusListStateCopyWithImpl<StudentStatusListState>(this as StudentStatusListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatusListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.query, query) || other.query == query)&&(identical(other.studentStatusList, studentStatusList) || other.studentStatusList == studentStatusList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,query,studentStatusList,errorMessage);

@override
String toString() {
  return 'StudentStatusListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, query: $query, studentStatusList: $studentStatusList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StudentStatusListStateCopyWith<$Res>  {
  factory $StudentStatusListStateCopyWith(StudentStatusListState value, $Res Function(StudentStatusListState) _then) = _$StudentStatusListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isFilterLoading, StudentStatusQuery query, StudentStatusList studentStatusList, String? errorMessage
});


$StudentStatusQueryCopyWith<$Res> get query;$StudentStatusListCopyWith<$Res> get studentStatusList;

}
/// @nodoc
class _$StudentStatusListStateCopyWithImpl<$Res>
    implements $StudentStatusListStateCopyWith<$Res> {
  _$StudentStatusListStateCopyWithImpl(this._self, this._then);

  final StudentStatusListState _self;
  final $Res Function(StudentStatusListState) _then;

/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? query = null,Object? studentStatusList = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as StudentStatusQuery,studentStatusList: null == studentStatusList ? _self.studentStatusList : studentStatusList // ignore: cast_nullable_to_non_nullable
as StudentStatusList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusQueryCopyWith<$Res> get query {
  
  return $StudentStatusQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusListCopyWith<$Res> get studentStatusList {
  
  return $StudentStatusListCopyWith<$Res>(_self.studentStatusList, (value) {
    return _then(_self.copyWith(studentStatusList: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudentStatusListState].
extension StudentStatusListStatePatterns on StudentStatusListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatusListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatusListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatusListState value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatusListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatusListState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatusListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  StudentStatusQuery query,  StudentStatusList studentStatusList,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatusListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.studentStatusList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  StudentStatusQuery query,  StudentStatusList studentStatusList,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StudentStatusListState():
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.studentStatusList,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isFilterLoading,  StudentStatusQuery query,  StudentStatusList studentStatusList,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatusListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.query,_that.studentStatusList,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatusListState implements StudentStatusListState {
  const _StudentStatusListState({this.isLoading = false, this.isFilterLoading = false, this.query = const StudentStatusQuery(), this.studentStatusList = const StudentStatusList(), this.errorMessage});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFilterLoading;
@override@JsonKey() final  StudentStatusQuery query;
@override@JsonKey() final  StudentStatusList studentStatusList;
@override final  String? errorMessage;

/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusListStateCopyWith<_StudentStatusListState> get copyWith => __$StudentStatusListStateCopyWithImpl<_StudentStatusListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatusListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&(identical(other.query, query) || other.query == query)&&(identical(other.studentStatusList, studentStatusList) || other.studentStatusList == studentStatusList)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,query,studentStatusList,errorMessage);

@override
String toString() {
  return 'StudentStatusListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, query: $query, studentStatusList: $studentStatusList, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusListStateCopyWith<$Res> implements $StudentStatusListStateCopyWith<$Res> {
  factory _$StudentStatusListStateCopyWith(_StudentStatusListState value, $Res Function(_StudentStatusListState) _then) = __$StudentStatusListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isFilterLoading, StudentStatusQuery query, StudentStatusList studentStatusList, String? errorMessage
});


@override $StudentStatusQueryCopyWith<$Res> get query;@override $StudentStatusListCopyWith<$Res> get studentStatusList;

}
/// @nodoc
class __$StudentStatusListStateCopyWithImpl<$Res>
    implements _$StudentStatusListStateCopyWith<$Res> {
  __$StudentStatusListStateCopyWithImpl(this._self, this._then);

  final _StudentStatusListState _self;
  final $Res Function(_StudentStatusListState) _then;

/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? query = null,Object? studentStatusList = null,Object? errorMessage = freezed,}) {
  return _then(_StudentStatusListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as StudentStatusQuery,studentStatusList: null == studentStatusList ? _self.studentStatusList : studentStatusList // ignore: cast_nullable_to_non_nullable
as StudentStatusList,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusQueryCopyWith<$Res> get query {
  
  return $StudentStatusQueryCopyWith<$Res>(_self.query, (value) {
    return _then(_self.copyWith(query: value));
  });
}/// Create a copy of StudentStatusListState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StudentStatusListCopyWith<$Res> get studentStatusList {
  
  return $StudentStatusListCopyWith<$Res>(_self.studentStatusList, (value) {
    return _then(_self.copyWith(studentStatusList: value));
  });
}
}

// dart format on
