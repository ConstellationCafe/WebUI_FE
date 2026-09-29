// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_penalty_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminPenaltyState {

 PenaltyPage<PenaltyLog>? get history; PenaltyPage<PenaltyMember>? get members; PenaltyDetail? get selected; String? get selectedId; String get channelId; String get discordId; String get rankingSearch; String get sort; bool get isHistoryLoading; bool get isMembersLoading; bool get isDetailLoading; bool get isSubmitting; bool get hasHistoryError; bool get hasMembersError; bool get hasDetailError; String? get submissionError;
/// Create a copy of AdminPenaltyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminPenaltyStateCopyWith<AdminPenaltyState> get copyWith => _$AdminPenaltyStateCopyWithImpl<AdminPenaltyState>(this as AdminPenaltyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminPenaltyState&&(identical(other.history, history) || other.history == history)&&(identical(other.members, members) || other.members == members)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.discordId, discordId) || other.discordId == discordId)&&(identical(other.rankingSearch, rankingSearch) || other.rankingSearch == rankingSearch)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.isHistoryLoading, isHistoryLoading) || other.isHistoryLoading == isHistoryLoading)&&(identical(other.isMembersLoading, isMembersLoading) || other.isMembersLoading == isMembersLoading)&&(identical(other.isDetailLoading, isDetailLoading) || other.isDetailLoading == isDetailLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.hasMembersError, hasMembersError) || other.hasMembersError == hasMembersError)&&(identical(other.hasDetailError, hasDetailError) || other.hasDetailError == hasDetailError)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError));
}


@override
int get hashCode => Object.hash(runtimeType,history,members,selected,selectedId,channelId,discordId,rankingSearch,sort,isHistoryLoading,isMembersLoading,isDetailLoading,isSubmitting,hasHistoryError,hasMembersError,hasDetailError,submissionError);

@override
String toString() {
  return 'AdminPenaltyState(history: $history, members: $members, selected: $selected, selectedId: $selectedId, channelId: $channelId, discordId: $discordId, rankingSearch: $rankingSearch, sort: $sort, isHistoryLoading: $isHistoryLoading, isMembersLoading: $isMembersLoading, isDetailLoading: $isDetailLoading, isSubmitting: $isSubmitting, hasHistoryError: $hasHistoryError, hasMembersError: $hasMembersError, hasDetailError: $hasDetailError, submissionError: $submissionError)';
}


}

/// @nodoc
abstract mixin class $AdminPenaltyStateCopyWith<$Res>  {
  factory $AdminPenaltyStateCopyWith(AdminPenaltyState value, $Res Function(AdminPenaltyState) _then) = _$AdminPenaltyStateCopyWithImpl;
@useResult
$Res call({
 PenaltyPage<PenaltyLog>? history, PenaltyPage<PenaltyMember>? members, PenaltyDetail? selected, String? selectedId, String channelId, String discordId, String rankingSearch, String sort, bool isHistoryLoading, bool isMembersLoading, bool isDetailLoading, bool isSubmitting, bool hasHistoryError, bool hasMembersError, bool hasDetailError, String? submissionError
});




}
/// @nodoc
class _$AdminPenaltyStateCopyWithImpl<$Res>
    implements $AdminPenaltyStateCopyWith<$Res> {
  _$AdminPenaltyStateCopyWithImpl(this._self, this._then);

  final AdminPenaltyState _self;
  final $Res Function(AdminPenaltyState) _then;

/// Create a copy of AdminPenaltyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? history = freezed,Object? members = freezed,Object? selected = freezed,Object? selectedId = freezed,Object? channelId = null,Object? discordId = null,Object? rankingSearch = null,Object? sort = null,Object? isHistoryLoading = null,Object? isMembersLoading = null,Object? isDetailLoading = null,Object? isSubmitting = null,Object? hasHistoryError = null,Object? hasMembersError = null,Object? hasDetailError = null,Object? submissionError = freezed,}) {
  return _then(_self.copyWith(
history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as PenaltyPage<PenaltyLog>?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as PenaltyPage<PenaltyMember>?,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as PenaltyDetail?,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,discordId: null == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String,rankingSearch: null == rankingSearch ? _self.rankingSearch : rankingSearch // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,isHistoryLoading: null == isHistoryLoading ? _self.isHistoryLoading : isHistoryLoading // ignore: cast_nullable_to_non_nullable
as bool,isMembersLoading: null == isMembersLoading ? _self.isMembersLoading : isMembersLoading // ignore: cast_nullable_to_non_nullable
as bool,isDetailLoading: null == isDetailLoading ? _self.isDetailLoading : isDetailLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,hasMembersError: null == hasMembersError ? _self.hasMembersError : hasMembersError // ignore: cast_nullable_to_non_nullable
as bool,hasDetailError: null == hasDetailError ? _self.hasDetailError : hasDetailError // ignore: cast_nullable_to_non_nullable
as bool,submissionError: freezed == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminPenaltyState].
extension AdminPenaltyStatePatterns on AdminPenaltyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminPenaltyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminPenaltyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminPenaltyState value)  $default,){
final _that = this;
switch (_that) {
case _AdminPenaltyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminPenaltyState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminPenaltyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PenaltyPage<PenaltyLog>? history,  PenaltyPage<PenaltyMember>? members,  PenaltyDetail? selected,  String? selectedId,  String channelId,  String discordId,  String rankingSearch,  String sort,  bool isHistoryLoading,  bool isMembersLoading,  bool isDetailLoading,  bool isSubmitting,  bool hasHistoryError,  bool hasMembersError,  bool hasDetailError,  String? submissionError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminPenaltyState() when $default != null:
return $default(_that.history,_that.members,_that.selected,_that.selectedId,_that.channelId,_that.discordId,_that.rankingSearch,_that.sort,_that.isHistoryLoading,_that.isMembersLoading,_that.isDetailLoading,_that.isSubmitting,_that.hasHistoryError,_that.hasMembersError,_that.hasDetailError,_that.submissionError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PenaltyPage<PenaltyLog>? history,  PenaltyPage<PenaltyMember>? members,  PenaltyDetail? selected,  String? selectedId,  String channelId,  String discordId,  String rankingSearch,  String sort,  bool isHistoryLoading,  bool isMembersLoading,  bool isDetailLoading,  bool isSubmitting,  bool hasHistoryError,  bool hasMembersError,  bool hasDetailError,  String? submissionError)  $default,) {final _that = this;
switch (_that) {
case _AdminPenaltyState():
return $default(_that.history,_that.members,_that.selected,_that.selectedId,_that.channelId,_that.discordId,_that.rankingSearch,_that.sort,_that.isHistoryLoading,_that.isMembersLoading,_that.isDetailLoading,_that.isSubmitting,_that.hasHistoryError,_that.hasMembersError,_that.hasDetailError,_that.submissionError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PenaltyPage<PenaltyLog>? history,  PenaltyPage<PenaltyMember>? members,  PenaltyDetail? selected,  String? selectedId,  String channelId,  String discordId,  String rankingSearch,  String sort,  bool isHistoryLoading,  bool isMembersLoading,  bool isDetailLoading,  bool isSubmitting,  bool hasHistoryError,  bool hasMembersError,  bool hasDetailError,  String? submissionError)?  $default,) {final _that = this;
switch (_that) {
case _AdminPenaltyState() when $default != null:
return $default(_that.history,_that.members,_that.selected,_that.selectedId,_that.channelId,_that.discordId,_that.rankingSearch,_that.sort,_that.isHistoryLoading,_that.isMembersLoading,_that.isDetailLoading,_that.isSubmitting,_that.hasHistoryError,_that.hasMembersError,_that.hasDetailError,_that.submissionError);case _:
  return null;

}
}

}

/// @nodoc


class _AdminPenaltyState implements AdminPenaltyState {
  const _AdminPenaltyState({this.history, this.members, this.selected, this.selectedId, this.channelId = '', this.discordId = '', this.rankingSearch = '', this.sort = PenaltyHistorySort.newest, this.isHistoryLoading = true, this.isMembersLoading = true, this.isDetailLoading = false, this.isSubmitting = false, this.hasHistoryError = false, this.hasMembersError = false, this.hasDetailError = false, this.submissionError});
  

@override final  PenaltyPage<PenaltyLog>? history;
@override final  PenaltyPage<PenaltyMember>? members;
@override final  PenaltyDetail? selected;
@override final  String? selectedId;
@override@JsonKey() final  String channelId;
@override@JsonKey() final  String discordId;
@override@JsonKey() final  String rankingSearch;
@override@JsonKey() final  String sort;
@override@JsonKey() final  bool isHistoryLoading;
@override@JsonKey() final  bool isMembersLoading;
@override@JsonKey() final  bool isDetailLoading;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool hasHistoryError;
@override@JsonKey() final  bool hasMembersError;
@override@JsonKey() final  bool hasDetailError;
@override final  String? submissionError;

/// Create a copy of AdminPenaltyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminPenaltyStateCopyWith<_AdminPenaltyState> get copyWith => __$AdminPenaltyStateCopyWithImpl<_AdminPenaltyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminPenaltyState&&(identical(other.history, history) || other.history == history)&&(identical(other.members, members) || other.members == members)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedId, selectedId) || other.selectedId == selectedId)&&(identical(other.channelId, channelId) || other.channelId == channelId)&&(identical(other.discordId, discordId) || other.discordId == discordId)&&(identical(other.rankingSearch, rankingSearch) || other.rankingSearch == rankingSearch)&&(identical(other.sort, sort) || other.sort == sort)&&(identical(other.isHistoryLoading, isHistoryLoading) || other.isHistoryLoading == isHistoryLoading)&&(identical(other.isMembersLoading, isMembersLoading) || other.isMembersLoading == isMembersLoading)&&(identical(other.isDetailLoading, isDetailLoading) || other.isDetailLoading == isDetailLoading)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasHistoryError, hasHistoryError) || other.hasHistoryError == hasHistoryError)&&(identical(other.hasMembersError, hasMembersError) || other.hasMembersError == hasMembersError)&&(identical(other.hasDetailError, hasDetailError) || other.hasDetailError == hasDetailError)&&(identical(other.submissionError, submissionError) || other.submissionError == submissionError));
}


@override
int get hashCode => Object.hash(runtimeType,history,members,selected,selectedId,channelId,discordId,rankingSearch,sort,isHistoryLoading,isMembersLoading,isDetailLoading,isSubmitting,hasHistoryError,hasMembersError,hasDetailError,submissionError);

@override
String toString() {
  return 'AdminPenaltyState(history: $history, members: $members, selected: $selected, selectedId: $selectedId, channelId: $channelId, discordId: $discordId, rankingSearch: $rankingSearch, sort: $sort, isHistoryLoading: $isHistoryLoading, isMembersLoading: $isMembersLoading, isDetailLoading: $isDetailLoading, isSubmitting: $isSubmitting, hasHistoryError: $hasHistoryError, hasMembersError: $hasMembersError, hasDetailError: $hasDetailError, submissionError: $submissionError)';
}


}

/// @nodoc
abstract mixin class _$AdminPenaltyStateCopyWith<$Res> implements $AdminPenaltyStateCopyWith<$Res> {
  factory _$AdminPenaltyStateCopyWith(_AdminPenaltyState value, $Res Function(_AdminPenaltyState) _then) = __$AdminPenaltyStateCopyWithImpl;
@override @useResult
$Res call({
 PenaltyPage<PenaltyLog>? history, PenaltyPage<PenaltyMember>? members, PenaltyDetail? selected, String? selectedId, String channelId, String discordId, String rankingSearch, String sort, bool isHistoryLoading, bool isMembersLoading, bool isDetailLoading, bool isSubmitting, bool hasHistoryError, bool hasMembersError, bool hasDetailError, String? submissionError
});




}
/// @nodoc
class __$AdminPenaltyStateCopyWithImpl<$Res>
    implements _$AdminPenaltyStateCopyWith<$Res> {
  __$AdminPenaltyStateCopyWithImpl(this._self, this._then);

  final _AdminPenaltyState _self;
  final $Res Function(_AdminPenaltyState) _then;

/// Create a copy of AdminPenaltyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? history = freezed,Object? members = freezed,Object? selected = freezed,Object? selectedId = freezed,Object? channelId = null,Object? discordId = null,Object? rankingSearch = null,Object? sort = null,Object? isHistoryLoading = null,Object? isMembersLoading = null,Object? isDetailLoading = null,Object? isSubmitting = null,Object? hasHistoryError = null,Object? hasMembersError = null,Object? hasDetailError = null,Object? submissionError = freezed,}) {
  return _then(_AdminPenaltyState(
history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as PenaltyPage<PenaltyLog>?,members: freezed == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as PenaltyPage<PenaltyMember>?,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as PenaltyDetail?,selectedId: freezed == selectedId ? _self.selectedId : selectedId // ignore: cast_nullable_to_non_nullable
as String?,channelId: null == channelId ? _self.channelId : channelId // ignore: cast_nullable_to_non_nullable
as String,discordId: null == discordId ? _self.discordId : discordId // ignore: cast_nullable_to_non_nullable
as String,rankingSearch: null == rankingSearch ? _self.rankingSearch : rankingSearch // ignore: cast_nullable_to_non_nullable
as String,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as String,isHistoryLoading: null == isHistoryLoading ? _self.isHistoryLoading : isHistoryLoading // ignore: cast_nullable_to_non_nullable
as bool,isMembersLoading: null == isMembersLoading ? _self.isMembersLoading : isMembersLoading // ignore: cast_nullable_to_non_nullable
as bool,isDetailLoading: null == isDetailLoading ? _self.isDetailLoading : isDetailLoading // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasHistoryError: null == hasHistoryError ? _self.hasHistoryError : hasHistoryError // ignore: cast_nullable_to_non_nullable
as bool,hasMembersError: null == hasMembersError ? _self.hasMembersError : hasMembersError // ignore: cast_nullable_to_non_nullable
as bool,hasDetailError: null == hasDetailError ? _self.hasDetailError : hasDetailError // ignore: cast_nullable_to_non_nullable
as bool,submissionError: freezed == submissionError ? _self.submissionError : submissionError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
