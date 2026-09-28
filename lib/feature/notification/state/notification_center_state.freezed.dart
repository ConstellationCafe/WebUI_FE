// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_center_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationCenterState {

 List<AppNotification> get items; int get unreadCount; int? get latestId; int get lastReadId; bool get isPanelOpen; bool get isLoading; bool get isLoadingMore; bool get hasLoaded; bool get hasError; bool get hasNext; int? get nextBeforeId; bool get isRealtimeConnected;
/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationCenterStateCopyWith<NotificationCenterState> get copyWith => _$NotificationCenterStateCopyWithImpl<NotificationCenterState>(this as NotificationCenterState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationCenterState&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.latestId, latestId) || other.latestId == latestId)&&(identical(other.lastReadId, lastReadId) || other.lastReadId == lastReadId)&&(identical(other.isPanelOpen, isPanelOpen) || other.isPanelOpen == isPanelOpen)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasLoaded, hasLoaded) || other.hasLoaded == hasLoaded)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.nextBeforeId, nextBeforeId) || other.nextBeforeId == nextBeforeId)&&(identical(other.isRealtimeConnected, isRealtimeConnected) || other.isRealtimeConnected == isRealtimeConnected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),unreadCount,latestId,lastReadId,isPanelOpen,isLoading,isLoadingMore,hasLoaded,hasError,hasNext,nextBeforeId,isRealtimeConnected);

@override
String toString() {
  return 'NotificationCenterState(items: $items, unreadCount: $unreadCount, latestId: $latestId, lastReadId: $lastReadId, isPanelOpen: $isPanelOpen, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasLoaded: $hasLoaded, hasError: $hasError, hasNext: $hasNext, nextBeforeId: $nextBeforeId, isRealtimeConnected: $isRealtimeConnected)';
}


}

/// @nodoc
abstract mixin class $NotificationCenterStateCopyWith<$Res>  {
  factory $NotificationCenterStateCopyWith(NotificationCenterState value, $Res Function(NotificationCenterState) _then) = _$NotificationCenterStateCopyWithImpl;
@useResult
$Res call({
 List<AppNotification> items, int unreadCount, int? latestId, int lastReadId, bool isPanelOpen, bool isLoading, bool isLoadingMore, bool hasLoaded, bool hasError, bool hasNext, int? nextBeforeId, bool isRealtimeConnected
});




}
/// @nodoc
class _$NotificationCenterStateCopyWithImpl<$Res>
    implements $NotificationCenterStateCopyWith<$Res> {
  _$NotificationCenterStateCopyWithImpl(this._self, this._then);

  final NotificationCenterState _self;
  final $Res Function(NotificationCenterState) _then;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? unreadCount = null,Object? latestId = freezed,Object? lastReadId = null,Object? isPanelOpen = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasLoaded = null,Object? hasError = null,Object? hasNext = null,Object? nextBeforeId = freezed,Object? isRealtimeConnected = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,latestId: freezed == latestId ? _self.latestId : latestId // ignore: cast_nullable_to_non_nullable
as int?,lastReadId: null == lastReadId ? _self.lastReadId : lastReadId // ignore: cast_nullable_to_non_nullable
as int,isPanelOpen: null == isPanelOpen ? _self.isPanelOpen : isPanelOpen // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasLoaded: null == hasLoaded ? _self.hasLoaded : hasLoaded // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,nextBeforeId: freezed == nextBeforeId ? _self.nextBeforeId : nextBeforeId // ignore: cast_nullable_to_non_nullable
as int?,isRealtimeConnected: null == isRealtimeConnected ? _self.isRealtimeConnected : isRealtimeConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationCenterState].
extension NotificationCenterStatePatterns on NotificationCenterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationCenterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationCenterState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationCenterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationCenterState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AppNotification> items,  int unreadCount,  int? latestId,  int lastReadId,  bool isPanelOpen,  bool isLoading,  bool isLoadingMore,  bool hasLoaded,  bool hasError,  bool hasNext,  int? nextBeforeId,  bool isRealtimeConnected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
return $default(_that.items,_that.unreadCount,_that.latestId,_that.lastReadId,_that.isPanelOpen,_that.isLoading,_that.isLoadingMore,_that.hasLoaded,_that.hasError,_that.hasNext,_that.nextBeforeId,_that.isRealtimeConnected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AppNotification> items,  int unreadCount,  int? latestId,  int lastReadId,  bool isPanelOpen,  bool isLoading,  bool isLoadingMore,  bool hasLoaded,  bool hasError,  bool hasNext,  int? nextBeforeId,  bool isRealtimeConnected)  $default,) {final _that = this;
switch (_that) {
case _NotificationCenterState():
return $default(_that.items,_that.unreadCount,_that.latestId,_that.lastReadId,_that.isPanelOpen,_that.isLoading,_that.isLoadingMore,_that.hasLoaded,_that.hasError,_that.hasNext,_that.nextBeforeId,_that.isRealtimeConnected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AppNotification> items,  int unreadCount,  int? latestId,  int lastReadId,  bool isPanelOpen,  bool isLoading,  bool isLoadingMore,  bool hasLoaded,  bool hasError,  bool hasNext,  int? nextBeforeId,  bool isRealtimeConnected)?  $default,) {final _that = this;
switch (_that) {
case _NotificationCenterState() when $default != null:
return $default(_that.items,_that.unreadCount,_that.latestId,_that.lastReadId,_that.isPanelOpen,_that.isLoading,_that.isLoadingMore,_that.hasLoaded,_that.hasError,_that.hasNext,_that.nextBeforeId,_that.isRealtimeConnected);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationCenterState implements NotificationCenterState {
  const _NotificationCenterState({final  List<AppNotification> items = const [], this.unreadCount = 0, this.latestId, this.lastReadId = 0, this.isPanelOpen = false, this.isLoading = false, this.isLoadingMore = false, this.hasLoaded = false, this.hasError = false, this.hasNext = false, this.nextBeforeId, this.isRealtimeConnected = false}): _items = items;
  

 final  List<AppNotification> _items;
@override@JsonKey() List<AppNotification> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int unreadCount;
@override final  int? latestId;
@override@JsonKey() final  int lastReadId;
@override@JsonKey() final  bool isPanelOpen;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasLoaded;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  bool hasNext;
@override final  int? nextBeforeId;
@override@JsonKey() final  bool isRealtimeConnected;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationCenterStateCopyWith<_NotificationCenterState> get copyWith => __$NotificationCenterStateCopyWithImpl<_NotificationCenterState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationCenterState&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.latestId, latestId) || other.latestId == latestId)&&(identical(other.lastReadId, lastReadId) || other.lastReadId == lastReadId)&&(identical(other.isPanelOpen, isPanelOpen) || other.isPanelOpen == isPanelOpen)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasLoaded, hasLoaded) || other.hasLoaded == hasLoaded)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.hasNext, hasNext) || other.hasNext == hasNext)&&(identical(other.nextBeforeId, nextBeforeId) || other.nextBeforeId == nextBeforeId)&&(identical(other.isRealtimeConnected, isRealtimeConnected) || other.isRealtimeConnected == isRealtimeConnected));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),unreadCount,latestId,lastReadId,isPanelOpen,isLoading,isLoadingMore,hasLoaded,hasError,hasNext,nextBeforeId,isRealtimeConnected);

@override
String toString() {
  return 'NotificationCenterState(items: $items, unreadCount: $unreadCount, latestId: $latestId, lastReadId: $lastReadId, isPanelOpen: $isPanelOpen, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasLoaded: $hasLoaded, hasError: $hasError, hasNext: $hasNext, nextBeforeId: $nextBeforeId, isRealtimeConnected: $isRealtimeConnected)';
}


}

/// @nodoc
abstract mixin class _$NotificationCenterStateCopyWith<$Res> implements $NotificationCenterStateCopyWith<$Res> {
  factory _$NotificationCenterStateCopyWith(_NotificationCenterState value, $Res Function(_NotificationCenterState) _then) = __$NotificationCenterStateCopyWithImpl;
@override @useResult
$Res call({
 List<AppNotification> items, int unreadCount, int? latestId, int lastReadId, bool isPanelOpen, bool isLoading, bool isLoadingMore, bool hasLoaded, bool hasError, bool hasNext, int? nextBeforeId, bool isRealtimeConnected
});




}
/// @nodoc
class __$NotificationCenterStateCopyWithImpl<$Res>
    implements _$NotificationCenterStateCopyWith<$Res> {
  __$NotificationCenterStateCopyWithImpl(this._self, this._then);

  final _NotificationCenterState _self;
  final $Res Function(_NotificationCenterState) _then;

/// Create a copy of NotificationCenterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? unreadCount = null,Object? latestId = freezed,Object? lastReadId = null,Object? isPanelOpen = null,Object? isLoading = null,Object? isLoadingMore = null,Object? hasLoaded = null,Object? hasError = null,Object? hasNext = null,Object? nextBeforeId = freezed,Object? isRealtimeConnected = null,}) {
  return _then(_NotificationCenterState(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,latestId: freezed == latestId ? _self.latestId : latestId // ignore: cast_nullable_to_non_nullable
as int?,lastReadId: null == lastReadId ? _self.lastReadId : lastReadId // ignore: cast_nullable_to_non_nullable
as int,isPanelOpen: null == isPanelOpen ? _self.isPanelOpen : isPanelOpen // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasLoaded: null == hasLoaded ? _self.hasLoaded : hasLoaded // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,hasNext: null == hasNext ? _self.hasNext : hasNext // ignore: cast_nullable_to_non_nullable
as bool,nextBeforeId: freezed == nextBeforeId ? _self.nextBeforeId : nextBeforeId // ignore: cast_nullable_to_non_nullable
as int?,isRealtimeConnected: null == isRealtimeConnected ? _self.isRealtimeConnected : isRealtimeConnected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
