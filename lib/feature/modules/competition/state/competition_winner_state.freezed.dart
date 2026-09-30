// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition_winner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompetitionWinnerState {

 List<CompetitionWinner> get history; int get historyPage; int get historyTotalPages; bool get isLoadingHistory; bool get hasHistoryError; bool get isSubmitting;
/// Create a copy of CompetitionWinnerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionWinnerStateCopyWith<CompetitionWinnerState> get copyWith => _$CompetitionWinnerStateCopyWithImpl<CompetitionWinnerState>(this as CompetitionWinnerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionWinnerState&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.historyPage, historyPage) || other.historyPage == historyPage)&&(identical(other.historyTotalPages, historyTotalPages) || other.historyTotalPages == historyTotalPages)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(history),historyPage,historyTotalPages,isLoadingHistory,hasHistoryError,isSubmitting);

@override
String toString() {
  return 'CompetitionWinnerState(history: $history, historyPage: $historyPage, historyTotalPages: $historyTotalPages, isLoadingHistory: $isLoadingHistory, hasHistoryError: $hasHistoryError, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $CompetitionWinnerStateCopyWith<$Res>  {
  factory $CompetitionWinnerStateCopyWith(CompetitionWinnerState value, $Res Function(CompetitionWinnerState) _then) = _$CompetitionWinnerStateCopyWithImpl;
@useResult
$Res call({
 List<CompetitionWinner> history, int historyPage, int historyTotalPages, bool isLoadingHistory, bool hasHistoryError, bool isSubmitting
});




}
/// @nodoc
class _$CompetitionWinnerStateCopyWithImpl<$Res>
    implements $CompetitionWinnerStateCopyWith<$Res> {
  _$CompetitionWinnerStateCopyWithImpl(this._self, this._then);

  final CompetitionWinnerState _self;
  final $Res Function(CompetitionWinnerState) _then;

/// Create a copy of CompetitionWinnerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? history = null,Object? historyPage = null,Object? historyTotalPages = null,Object? isLoadingHistory = null,Object? hasHistoryError = null,Object? isSubmitting = null,}) {
  return _then(_self.copyWith(
history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<CompetitionWinner>,historyPage: null == historyPage ? _self.historyPage : historyPage // ignore: cast_nullable_to_non_nullable
as int,historyTotalPages: null == historyTotalPages ? _self.historyTotalPages : historyTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionWinnerState].
extension CompetitionWinnerStatePatterns on CompetitionWinnerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionWinnerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionWinnerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionWinnerState value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionWinnerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionWinnerState value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionWinnerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CompetitionWinner> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionWinnerState() when $default != null:
return $default(_that.history,_that.historyPage,_that.historyTotalPages,_that.isLoadingHistory,_that.hasHistoryError,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CompetitionWinner> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _CompetitionWinnerState():
return $default(_that.history,_that.historyPage,_that.historyTotalPages,_that.isLoadingHistory,_that.hasHistoryError,_that.isSubmitting);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CompetitionWinner> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionWinnerState() when $default != null:
return $default(_that.history,_that.historyPage,_that.historyTotalPages,_that.isLoadingHistory,_that.hasHistoryError,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionWinnerState implements CompetitionWinnerState {
  const _CompetitionWinnerState({final  List<CompetitionWinner> history = const [], this.historyPage = 1, this.historyTotalPages = 0, this.isLoadingHistory = false, this.hasHistoryError = false, this.isSubmitting = false}): _history = history;
  

 final  List<CompetitionWinner> _history;
@override@JsonKey() List<CompetitionWinner> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  int historyPage;
@override@JsonKey() final  int historyTotalPages;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool hasHistoryError;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of CompetitionWinnerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionWinnerStateCopyWith<_CompetitionWinnerState> get copyWith => __$CompetitionWinnerStateCopyWithImpl<_CompetitionWinnerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionWinnerState&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.historyPage, historyPage) || other.historyPage == historyPage)&&(identical(other.historyTotalPages, historyTotalPages) || other.historyTotalPages == historyTotalPages)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history),historyPage,historyTotalPages,isLoadingHistory,hasHistoryError,isSubmitting);

@override
String toString() {
  return 'CompetitionWinnerState(history: $history, historyPage: $historyPage, historyTotalPages: $historyTotalPages, isLoadingHistory: $isLoadingHistory, hasHistoryError: $hasHistoryError, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$CompetitionWinnerStateCopyWith<$Res> implements $CompetitionWinnerStateCopyWith<$Res> {
  factory _$CompetitionWinnerStateCopyWith(_CompetitionWinnerState value, $Res Function(_CompetitionWinnerState) _then) = __$CompetitionWinnerStateCopyWithImpl;
@override @useResult
$Res call({
 List<CompetitionWinner> history, int historyPage, int historyTotalPages, bool isLoadingHistory, bool hasHistoryError, bool isSubmitting
});




}
/// @nodoc
class __$CompetitionWinnerStateCopyWithImpl<$Res>
    implements _$CompetitionWinnerStateCopyWith<$Res> {
  __$CompetitionWinnerStateCopyWithImpl(this._self, this._then);

  final _CompetitionWinnerState _self;
  final $Res Function(_CompetitionWinnerState) _then;

/// Create a copy of CompetitionWinnerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? history = null,Object? historyPage = null,Object? historyTotalPages = null,Object? isLoadingHistory = null,Object? hasHistoryError = null,Object? isSubmitting = null,}) {
  return _then(_CompetitionWinnerState(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<CompetitionWinner>,historyPage: null == historyPage ? _self.historyPage : historyPage // ignore: cast_nullable_to_non_nullable
as int,historyTotalPages: null == historyTotalPages ? _self.historyTotalPages : historyTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
