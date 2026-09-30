// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_competition_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminCompetitionState {

 List<CompetitionBoard> get boards; String? get selectedBoardKey; bool get isLoadingBoards; bool get hasBoardsError;/// 서버가 조립한 실제 게시글. 필수 입력이 비어 있거나 검증에 실패하면 null
 String? get preview;/// 미리보기 실패 이유. 입력 오류(invalid)면 서버 안내 문구를 함께 담는다.
 CompetitionException? get previewFailure; bool get isPreviewing; bool get isSubmitting;
/// Create a copy of AdminCompetitionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminCompetitionStateCopyWith<AdminCompetitionState> get copyWith => _$AdminCompetitionStateCopyWithImpl<AdminCompetitionState>(this as AdminCompetitionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminCompetitionState&&const DeepCollectionEquality().equals(other.boards, boards)&&(identical(other.selectedBoardKey, selectedBoardKey) || other.selectedBoardKey == selectedBoardKey)&&(identical(other.isLoadingBoards, isLoadingBoards) || other.isLoadingBoards == isLoadingBoards)&&(identical(other.hasBoardsError, hasBoardsError) || other.hasBoardsError == hasBoardsError)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.previewFailure, previewFailure) || other.previewFailure == previewFailure)&&(identical(other.isPreviewing, isPreviewing) || other.isPreviewing == isPreviewing)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(boards),selectedBoardKey,isLoadingBoards,hasBoardsError,preview,previewFailure,isPreviewing,isSubmitting);

@override
String toString() {
  return 'AdminCompetitionState(boards: $boards, selectedBoardKey: $selectedBoardKey, isLoadingBoards: $isLoadingBoards, hasBoardsError: $hasBoardsError, preview: $preview, previewFailure: $previewFailure, isPreviewing: $isPreviewing, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $AdminCompetitionStateCopyWith<$Res>  {
  factory $AdminCompetitionStateCopyWith(AdminCompetitionState value, $Res Function(AdminCompetitionState) _then) = _$AdminCompetitionStateCopyWithImpl;
@useResult
$Res call({
 List<CompetitionBoard> boards, String? selectedBoardKey, bool isLoadingBoards, bool hasBoardsError, String? preview, CompetitionException? previewFailure, bool isPreviewing, bool isSubmitting
});




}
/// @nodoc
class _$AdminCompetitionStateCopyWithImpl<$Res>
    implements $AdminCompetitionStateCopyWith<$Res> {
  _$AdminCompetitionStateCopyWithImpl(this._self, this._then);

  final AdminCompetitionState _self;
  final $Res Function(AdminCompetitionState) _then;

/// Create a copy of AdminCompetitionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? boards = null,Object? selectedBoardKey = freezed,Object? isLoadingBoards = null,Object? hasBoardsError = null,Object? preview = freezed,Object? previewFailure = freezed,Object? isPreviewing = null,Object? isSubmitting = null,}) {
  return _then(_self.copyWith(
boards: null == boards ? _self.boards : boards // ignore: cast_nullable_to_non_nullable
as List<CompetitionBoard>,selectedBoardKey: freezed == selectedBoardKey ? _self.selectedBoardKey : selectedBoardKey // ignore: cast_nullable_to_non_nullable
as String?,isLoadingBoards: null == isLoadingBoards ? _self.isLoadingBoards : isLoadingBoards // ignore: cast_nullable_to_non_nullable
as bool,hasBoardsError: null == hasBoardsError ? _self.hasBoardsError : hasBoardsError // ignore: cast_nullable_to_non_nullable
as bool,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String?,previewFailure: freezed == previewFailure ? _self.previewFailure : previewFailure // ignore: cast_nullable_to_non_nullable
as CompetitionException?,isPreviewing: null == isPreviewing ? _self.isPreviewing : isPreviewing // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminCompetitionState].
extension AdminCompetitionStatePatterns on AdminCompetitionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminCompetitionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminCompetitionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminCompetitionState value)  $default,){
final _that = this;
switch (_that) {
case _AdminCompetitionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminCompetitionState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminCompetitionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CompetitionBoard> boards,  String? selectedBoardKey,  bool isLoadingBoards,  bool hasBoardsError,  String? preview,  CompetitionException? previewFailure,  bool isPreviewing,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminCompetitionState() when $default != null:
return $default(_that.boards,_that.selectedBoardKey,_that.isLoadingBoards,_that.hasBoardsError,_that.preview,_that.previewFailure,_that.isPreviewing,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CompetitionBoard> boards,  String? selectedBoardKey,  bool isLoadingBoards,  bool hasBoardsError,  String? preview,  CompetitionException? previewFailure,  bool isPreviewing,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _AdminCompetitionState():
return $default(_that.boards,_that.selectedBoardKey,_that.isLoadingBoards,_that.hasBoardsError,_that.preview,_that.previewFailure,_that.isPreviewing,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CompetitionBoard> boards,  String? selectedBoardKey,  bool isLoadingBoards,  bool hasBoardsError,  String? preview,  CompetitionException? previewFailure,  bool isPreviewing,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _AdminCompetitionState() when $default != null:
return $default(_that.boards,_that.selectedBoardKey,_that.isLoadingBoards,_that.hasBoardsError,_that.preview,_that.previewFailure,_that.isPreviewing,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _AdminCompetitionState implements AdminCompetitionState {
  const _AdminCompetitionState({final  List<CompetitionBoard> boards = const [], this.selectedBoardKey, this.isLoadingBoards = false, this.hasBoardsError = false, this.preview, this.previewFailure, this.isPreviewing = false, this.isSubmitting = false}): _boards = boards;
  

 final  List<CompetitionBoard> _boards;
@override@JsonKey() List<CompetitionBoard> get boards {
  if (_boards is EqualUnmodifiableListView) return _boards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boards);
}

@override final  String? selectedBoardKey;
@override@JsonKey() final  bool isLoadingBoards;
@override@JsonKey() final  bool hasBoardsError;
/// 서버가 조립한 실제 게시글. 필수 입력이 비어 있거나 검증에 실패하면 null
@override final  String? preview;
/// 미리보기 실패 이유. 입력 오류(invalid)면 서버 안내 문구를 함께 담는다.
@override final  CompetitionException? previewFailure;
@override@JsonKey() final  bool isPreviewing;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of AdminCompetitionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminCompetitionStateCopyWith<_AdminCompetitionState> get copyWith => __$AdminCompetitionStateCopyWithImpl<_AdminCompetitionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminCompetitionState&&const DeepCollectionEquality().equals(other._boards, _boards)&&(identical(other.selectedBoardKey, selectedBoardKey) || other.selectedBoardKey == selectedBoardKey)&&(identical(other.isLoadingBoards, isLoadingBoards) || other.isLoadingBoards == isLoadingBoards)&&(identical(other.hasBoardsError, hasBoardsError) || other.hasBoardsError == hasBoardsError)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.previewFailure, previewFailure) || other.previewFailure == previewFailure)&&(identical(other.isPreviewing, isPreviewing) || other.isPreviewing == isPreviewing)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_boards),selectedBoardKey,isLoadingBoards,hasBoardsError,preview,previewFailure,isPreviewing,isSubmitting);

@override
String toString() {
  return 'AdminCompetitionState(boards: $boards, selectedBoardKey: $selectedBoardKey, isLoadingBoards: $isLoadingBoards, hasBoardsError: $hasBoardsError, preview: $preview, previewFailure: $previewFailure, isPreviewing: $isPreviewing, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$AdminCompetitionStateCopyWith<$Res> implements $AdminCompetitionStateCopyWith<$Res> {
  factory _$AdminCompetitionStateCopyWith(_AdminCompetitionState value, $Res Function(_AdminCompetitionState) _then) = __$AdminCompetitionStateCopyWithImpl;
@override @useResult
$Res call({
 List<CompetitionBoard> boards, String? selectedBoardKey, bool isLoadingBoards, bool hasBoardsError, String? preview, CompetitionException? previewFailure, bool isPreviewing, bool isSubmitting
});




}
/// @nodoc
class __$AdminCompetitionStateCopyWithImpl<$Res>
    implements _$AdminCompetitionStateCopyWith<$Res> {
  __$AdminCompetitionStateCopyWithImpl(this._self, this._then);

  final _AdminCompetitionState _self;
  final $Res Function(_AdminCompetitionState) _then;

/// Create a copy of AdminCompetitionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? boards = null,Object? selectedBoardKey = freezed,Object? isLoadingBoards = null,Object? hasBoardsError = null,Object? preview = freezed,Object? previewFailure = freezed,Object? isPreviewing = null,Object? isSubmitting = null,}) {
  return _then(_AdminCompetitionState(
boards: null == boards ? _self._boards : boards // ignore: cast_nullable_to_non_nullable
as List<CompetitionBoard>,selectedBoardKey: freezed == selectedBoardKey ? _self.selectedBoardKey : selectedBoardKey // ignore: cast_nullable_to_non_nullable
as String?,isLoadingBoards: null == isLoadingBoards ? _self.isLoadingBoards : isLoadingBoards // ignore: cast_nullable_to_non_nullable
as bool,hasBoardsError: null == hasBoardsError ? _self.hasBoardsError : hasBoardsError // ignore: cast_nullable_to_non_nullable
as bool,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as String?,previewFailure: freezed == previewFailure ? _self.previewFailure : previewFailure // ignore: cast_nullable_to_non_nullable
as CompetitionException?,isPreviewing: null == isPreviewing ? _self.isPreviewing : isPreviewing // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
