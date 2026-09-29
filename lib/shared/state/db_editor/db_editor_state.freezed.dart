// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'db_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DbEditorState {

 DBModel get model; int get revision; bool get isEditMode; int get currentPage; bool get isLoading; bool get hasNext; bool get isInitialized; String? get searchColumn; String? get searchValue; String? get sortColumn; String? get sortDirection;
/// Create a copy of DbEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DbEditorStateCopyWith<DbEditorState> get copyWith => _$DbEditorStateCopyWithImpl<DbEditorState>(this as DbEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DbEditorState&&(identical(other.model, model) || other.model == model)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.searchColumn, searchColumn) || other.searchColumn == searchColumn)&&(identical(other.searchValue, searchValue) || other.searchValue == searchValue)&&(identical(other.sortColumn, sortColumn) || other.sortColumn == sortColumn)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,model,revision,isEditMode,currentPage,isLoading,hasNext,isInitialized,searchColumn,searchValue,sortColumn,sortDirection);

@override
String toString() {
  return 'DbEditorState(model: $model, revision: $revision, isEditMode: $isEditMode, currentPage: $currentPage, isLoading: $isLoading, hasNext: $hasNext, isInitialized: $isInitialized, searchColumn: $searchColumn, searchValue: $searchValue, sortColumn: $sortColumn, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class $DbEditorStateCopyWith<$Res>  {
  factory $DbEditorStateCopyWith(DbEditorState value, $Res Function(DbEditorState) _then) = _$DbEditorStateCopyWithImpl;
@useResult
$Res call({
 DBModel model, int revision, bool isEditMode, int currentPage, bool isLoading, bool hasNext, bool isInitialized, String? searchColumn, String? searchValue, String? sortColumn, String? sortDirection
});




}
/// @nodoc
class _$DbEditorStateCopyWithImpl<$Res>
    implements $DbEditorStateCopyWith<$Res> {
  _$DbEditorStateCopyWithImpl(this._self, this._then);

  final DbEditorState _self;
  final $Res Function(DbEditorState) _then;

/// Create a copy of DbEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? revision = null,Object? isEditMode = null,Object? currentPage = null,Object? isLoading = null,Object? hasNext = null,Object? isInitialized = null,Object? searchColumn = freezed,Object? searchValue = freezed,Object? sortColumn = freezed,Object? sortDirection = freezed,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as DBModel,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,searchColumn: freezed == searchColumn ? _self.searchColumn : searchColumn // ignore: cast_nullable_to_non_nullable
as String?,searchValue: freezed == searchValue ? _self.searchValue : searchValue // ignore: cast_nullable_to_non_nullable
as String?,sortColumn: freezed == sortColumn ? _self.sortColumn : sortColumn // ignore: cast_nullable_to_non_nullable
as String?,sortDirection: freezed == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DbEditorState].
extension DbEditorStatePatterns on DbEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DbEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DbEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DbEditorState value)  $default,){
final _that = this;
switch (_that) {
case _DbEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DbEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _DbEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DBModel model,  int revision,  bool isEditMode,  int currentPage,  bool isLoading,  bool hasNext,  bool isInitialized,  String? searchColumn,  String? searchValue,  String? sortColumn,  String? sortDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DbEditorState() when $default != null:
return $default(_that.model,_that.revision,_that.isEditMode,_that.currentPage,_that.isLoading,_that.hasNext,_that.isInitialized,_that.searchColumn,_that.searchValue,_that.sortColumn,_that.sortDirection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DBModel model,  int revision,  bool isEditMode,  int currentPage,  bool isLoading,  bool hasNext,  bool isInitialized,  String? searchColumn,  String? searchValue,  String? sortColumn,  String? sortDirection)  $default,) {final _that = this;
switch (_that) {
case _DbEditorState():
return $default(_that.model,_that.revision,_that.isEditMode,_that.currentPage,_that.isLoading,_that.hasNext,_that.isInitialized,_that.searchColumn,_that.searchValue,_that.sortColumn,_that.sortDirection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DBModel model,  int revision,  bool isEditMode,  int currentPage,  bool isLoading,  bool hasNext,  bool isInitialized,  String? searchColumn,  String? searchValue,  String? sortColumn,  String? sortDirection)?  $default,) {final _that = this;
switch (_that) {
case _DbEditorState() when $default != null:
return $default(_that.model,_that.revision,_that.isEditMode,_that.currentPage,_that.isLoading,_that.hasNext,_that.isInitialized,_that.searchColumn,_that.searchValue,_that.sortColumn,_that.sortDirection);case _:
  return null;

}
}

}

/// @nodoc


class _DbEditorState extends DbEditorState {
  const _DbEditorState({required this.model, this.revision = 0, this.isEditMode = false, this.currentPage = 0, this.isLoading = false, this.hasNext = true, this.isInitialized = false, this.searchColumn, this.searchValue, this.sortColumn, this.sortDirection}): super._();
  

@override final  DBModel model;
@override@JsonKey() final  int revision;
@override@JsonKey() final  bool isEditMode;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasNext;
@override@JsonKey() final  bool isInitialized;
@override final  String? searchColumn;
@override final  String? searchValue;
@override final  String? sortColumn;
@override final  String? sortDirection;

/// Create a copy of DbEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DbEditorStateCopyWith<_DbEditorState> get copyWith => __$DbEditorStateCopyWithImpl<_DbEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DbEditorState&&(identical(other.model, model) || other.model == model)&&(identical(other.revision, revision) || other.revision == revision)&&(identical(other.isEditMode, isEditMode) || other.isEditMode == isEditMode)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.isInitialized, isInitialized) || other.isInitialized == isInitialized)&&(identical(other.searchColumn, searchColumn) || other.searchColumn == searchColumn)&&(identical(other.searchValue, searchValue) || other.searchValue == searchValue)&&(identical(other.sortColumn, sortColumn) || other.sortColumn == sortColumn)&&(identical(other.sortDirection, sortDirection) || other.sortDirection == sortDirection));
}


@override
int get hashCode => Object.hash(runtimeType,model,revision,isEditMode,currentPage,isLoading,hasNext,isInitialized,searchColumn,searchValue,sortColumn,sortDirection);

@override
String toString() {
  return 'DbEditorState(model: $model, revision: $revision, isEditMode: $isEditMode, currentPage: $currentPage, isLoading: $isLoading, hasNext: $hasNext, isInitialized: $isInitialized, searchColumn: $searchColumn, searchValue: $searchValue, sortColumn: $sortColumn, sortDirection: $sortDirection)';
}


}

/// @nodoc
abstract mixin class _$DbEditorStateCopyWith<$Res> implements $DbEditorStateCopyWith<$Res> {
  factory _$DbEditorStateCopyWith(_DbEditorState value, $Res Function(_DbEditorState) _then) = __$DbEditorStateCopyWithImpl;
@override @useResult
$Res call({
 DBModel model, int revision, bool isEditMode, int currentPage, bool isLoading, bool hasNext, bool isInitialized, String? searchColumn, String? searchValue, String? sortColumn, String? sortDirection
});




}
/// @nodoc
class __$DbEditorStateCopyWithImpl<$Res>
    implements _$DbEditorStateCopyWith<$Res> {
  __$DbEditorStateCopyWithImpl(this._self, this._then);

  final _DbEditorState _self;
  final $Res Function(_DbEditorState) _then;

/// Create a copy of DbEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? revision = null,Object? isEditMode = null,Object? currentPage = null,Object? isLoading = null,Object? hasNext = null,Object? isInitialized = null,Object? searchColumn = freezed,Object? searchValue = freezed,Object? sortColumn = freezed,Object? sortDirection = freezed,}) {
  return _then(_DbEditorState(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as DBModel,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as int,isEditMode: null == isEditMode ? _self.isEditMode : isEditMode // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,isInitialized: null == isInitialized ? _self.isInitialized : isInitialized // ignore: cast_nullable_to_non_nullable
as bool,searchColumn: freezed == searchColumn ? _self.searchColumn : searchColumn // ignore: cast_nullable_to_non_nullable
as String?,searchValue: freezed == searchValue ? _self.searchValue : searchValue // ignore: cast_nullable_to_non_nullable
as String?,sortColumn: freezed == sortColumn ? _self.sortColumn : sortColumn // ignore: cast_nullable_to_non_nullable
as String?,sortDirection: freezed == sortDirection ? _self.sortDirection : sortDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
