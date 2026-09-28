// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminNotificationState {

 List<SentNotification> get history; int get historyPage; int get historyTotalPages; bool get isLoadingHistory; bool get hasHistoryError; bool get isSubmitting;
/// Create a copy of AdminNotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminNotificationStateCopyWith<AdminNotificationState> get copyWith => _$AdminNotificationStateCopyWithImpl<AdminNotificationState>(this as AdminNotificationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminNotificationState&&const DeepCollectionEquality().equals(other.history, history)&&(identical(other.historyPage, historyPage) || other.historyPage == historyPage)&&(identical(other.historyTotalPages, historyTotalPages) || other.historyTotalPages == historyTotalPages)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(history),historyPage,historyTotalPages,isLoadingHistory,hasHistoryError,isSubmitting);

@override
String toString() {
  return 'AdminNotificationState(history: $history, historyPage: $historyPage, historyTotalPages: $historyTotalPages, isLoadingHistory: $isLoadingHistory, hasHistoryError: $hasHistoryError, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $AdminNotificationStateCopyWith<$Res>  {
  factory $AdminNotificationStateCopyWith(AdminNotificationState value, $Res Function(AdminNotificationState) _then) = _$AdminNotificationStateCopyWithImpl;
@useResult
$Res call({
 List<SentNotification> history, int historyPage, int historyTotalPages, bool isLoadingHistory, bool hasHistoryError, bool isSubmitting
});




}
/// @nodoc
class _$AdminNotificationStateCopyWithImpl<$Res>
    implements $AdminNotificationStateCopyWith<$Res> {
  _$AdminNotificationStateCopyWithImpl(this._self, this._then);

  final AdminNotificationState _self;
  final $Res Function(AdminNotificationState) _then;

/// Create a copy of AdminNotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? history = null,Object? historyPage = null,Object? historyTotalPages = null,Object? isLoadingHistory = null,Object? hasHistoryError = null,Object? isSubmitting = null,}) {
  return _then(_self.copyWith(
history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<SentNotification>,historyPage: null == historyPage ? _self.historyPage : historyPage // ignore: cast_nullable_to_non_nullable
as int,historyTotalPages: null == historyTotalPages ? _self.historyTotalPages : historyTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminNotificationState].
extension AdminNotificationStatePatterns on AdminNotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminNotificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminNotificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminNotificationState value)  $default,){
final _that = this;
switch (_that) {
case _AdminNotificationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminNotificationState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminNotificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SentNotification> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminNotificationState() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SentNotification> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _AdminNotificationState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SentNotification> history,  int historyPage,  int historyTotalPages,  bool isLoadingHistory,  bool hasHistoryError,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _AdminNotificationState() when $default != null:
return $default(_that.history,_that.historyPage,_that.historyTotalPages,_that.isLoadingHistory,_that.hasHistoryError,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _AdminNotificationState implements AdminNotificationState {
  const _AdminNotificationState({final  List<SentNotification> history = const [], this.historyPage = 1, this.historyTotalPages = 0, this.isLoadingHistory = false, this.hasHistoryError = false, this.isSubmitting = false}): _history = history;
  

 final  List<SentNotification> _history;
@override@JsonKey() List<SentNotification> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

@override@JsonKey() final  int historyPage;
@override@JsonKey() final  int historyTotalPages;
@override@JsonKey() final  bool isLoadingHistory;
@override@JsonKey() final  bool hasHistoryError;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of AdminNotificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminNotificationStateCopyWith<_AdminNotificationState> get copyWith => __$AdminNotificationStateCopyWithImpl<_AdminNotificationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminNotificationState&&const DeepCollectionEquality().equals(other._history, _history)&&(identical(other.historyPage, historyPage) || other.historyPage == historyPage)&&(identical(other.historyTotalPages, historyTotalPages) || other.historyTotalPages == historyTotalPages)&&(identical(other.isLoadingHistory, isLoadingHistory) || other.isLoadingHistory == isLoadingHistory)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history),historyPage,historyTotalPages,isLoadingHistory,hasHistoryError,isSubmitting);

@override
String toString() {
  return 'AdminNotificationState(history: $history, historyPage: $historyPage, historyTotalPages: $historyTotalPages, isLoadingHistory: $isLoadingHistory, hasHistoryError: $hasHistoryError, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$AdminNotificationStateCopyWith<$Res> implements $AdminNotificationStateCopyWith<$Res> {
  factory _$AdminNotificationStateCopyWith(_AdminNotificationState value, $Res Function(_AdminNotificationState) _then) = __$AdminNotificationStateCopyWithImpl;
@override @useResult
$Res call({
 List<SentNotification> history, int historyPage, int historyTotalPages, bool isLoadingHistory, bool hasHistoryError, bool isSubmitting
});




}
/// @nodoc
class __$AdminNotificationStateCopyWithImpl<$Res>
    implements _$AdminNotificationStateCopyWith<$Res> {
  __$AdminNotificationStateCopyWithImpl(this._self, this._then);

  final _AdminNotificationState _self;
  final $Res Function(_AdminNotificationState) _then;

/// Create a copy of AdminNotificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? history = null,Object? historyPage = null,Object? historyTotalPages = null,Object? isLoadingHistory = null,Object? hasHistoryError = null,Object? isSubmitting = null,}) {
  return _then(_AdminNotificationState(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<SentNotification>,historyPage: null == historyPage ? _self.historyPage : historyPage // ignore: cast_nullable_to_non_nullable
as int,historyTotalPages: null == historyTotalPages ? _self.historyTotalPages : historyTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingHistory: null == isLoadingHistory ? _self.isLoadingHistory : isLoadingHistory // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
