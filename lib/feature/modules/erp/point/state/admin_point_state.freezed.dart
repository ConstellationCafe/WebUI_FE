// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_point_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminPointState {

 List<PointMember> get members; PointMemberDetail? get selected; String? get selectedDiscordId; String get searchInput; String get search; int get memberPage; int get memberTotalPages; bool get isLoadingMembers; bool get isLoadingDetail; bool get isSubmitting; bool get hasMembersError; bool get hasDetailError;
/// Create a copy of AdminPointState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminPointStateCopyWith<AdminPointState> get copyWith => _$AdminPointStateCopyWithImpl<AdminPointState>(this as AdminPointState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminPointState&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedDiscordId, selectedDiscordId) || other.selectedDiscordId == selectedDiscordId)&&(identical(other.searchInput, searchInput) || other.searchInput == searchInput)&&(identical(other.search, search) || other.search == search)&&(identical(other.memberPage, memberPage) || other.memberPage == memberPage)&&(identical(other.memberTotalPages, memberTotalPages) || other.memberTotalPages == memberTotalPages)&&(identical(other.isLoadingMembers, isLoadingMembers) || other.isLoadingMembers == isLoadingMembers)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasMembersError, hasMembersError) || other.hasMembersError == hasMembersError)&&(identical(other.hasDetailError, hasDetailError) || other.hasDetailError == hasDetailError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(members),selected,selectedDiscordId,searchInput,search,memberPage,memberTotalPages,isLoadingMembers,isLoadingDetail,isSubmitting,hasMembersError,hasDetailError);

@override
String toString() {
  return 'AdminPointState(members: $members, selected: $selected, selectedDiscordId: $selectedDiscordId, searchInput: $searchInput, search: $search, memberPage: $memberPage, memberTotalPages: $memberTotalPages, isLoadingMembers: $isLoadingMembers, isLoadingDetail: $isLoadingDetail, isSubmitting: $isSubmitting, hasMembersError: $hasMembersError, hasDetailError: $hasDetailError)';
}


}

/// @nodoc
abstract mixin class $AdminPointStateCopyWith<$Res>  {
  factory $AdminPointStateCopyWith(AdminPointState value, $Res Function(AdminPointState) _then) = _$AdminPointStateCopyWithImpl;
@useResult
$Res call({
 List<PointMember> members, PointMemberDetail? selected, String? selectedDiscordId, String searchInput, String search, int memberPage, int memberTotalPages, bool isLoadingMembers, bool isLoadingDetail, bool isSubmitting, bool hasMembersError, bool hasDetailError
});




}
/// @nodoc
class _$AdminPointStateCopyWithImpl<$Res>
    implements $AdminPointStateCopyWith<$Res> {
  _$AdminPointStateCopyWithImpl(this._self, this._then);

  final AdminPointState _self;
  final $Res Function(AdminPointState) _then;

/// Create a copy of AdminPointState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? members = null,Object? selected = freezed,Object? selectedDiscordId = freezed,Object? searchInput = null,Object? search = null,Object? memberPage = null,Object? memberTotalPages = null,Object? isLoadingMembers = null,Object? isLoadingDetail = null,Object? isSubmitting = null,Object? hasMembersError = null,Object? hasDetailError = null,}) {
  return _then(_self.copyWith(
members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<PointMember>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as PointMemberDetail?,selectedDiscordId: freezed == selectedDiscordId ? _self.selectedDiscordId : selectedDiscordId // ignore: cast_nullable_to_non_nullable
as String?,searchInput: null == searchInput ? _self.searchInput : searchInput // ignore: cast_nullable_to_non_nullable
as String,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,memberPage: null == memberPage ? _self.memberPage : memberPage // ignore: cast_nullable_to_non_nullable
as int,memberTotalPages: null == memberTotalPages ? _self.memberTotalPages : memberTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingMembers: null == isLoadingMembers ? _self.isLoadingMembers : isLoadingMembers // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasMembersError: null == hasMembersError ? _self.hasMembersError : hasMembersError // ignore: cast_nullable_to_non_nullable
as bool,hasDetailError: null == hasDetailError ? _self.hasDetailError : hasDetailError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminPointState].
extension AdminPointStatePatterns on AdminPointState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminPointState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminPointState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminPointState value)  $default,){
final _that = this;
switch (_that) {
case _AdminPointState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminPointState value)?  $default,){
final _that = this;
switch (_that) {
case _AdminPointState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PointMember> members,  PointMemberDetail? selected,  String? selectedDiscordId,  String searchInput,  String search,  int memberPage,  int memberTotalPages,  bool isLoadingMembers,  bool isLoadingDetail,  bool isSubmitting,  bool hasMembersError,  bool hasDetailError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminPointState() when $default != null:
return $default(_that.members,_that.selected,_that.selectedDiscordId,_that.searchInput,_that.search,_that.memberPage,_that.memberTotalPages,_that.isLoadingMembers,_that.isLoadingDetail,_that.isSubmitting,_that.hasMembersError,_that.hasDetailError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PointMember> members,  PointMemberDetail? selected,  String? selectedDiscordId,  String searchInput,  String search,  int memberPage,  int memberTotalPages,  bool isLoadingMembers,  bool isLoadingDetail,  bool isSubmitting,  bool hasMembersError,  bool hasDetailError)  $default,) {final _that = this;
switch (_that) {
case _AdminPointState():
return $default(_that.members,_that.selected,_that.selectedDiscordId,_that.searchInput,_that.search,_that.memberPage,_that.memberTotalPages,_that.isLoadingMembers,_that.isLoadingDetail,_that.isSubmitting,_that.hasMembersError,_that.hasDetailError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PointMember> members,  PointMemberDetail? selected,  String? selectedDiscordId,  String searchInput,  String search,  int memberPage,  int memberTotalPages,  bool isLoadingMembers,  bool isLoadingDetail,  bool isSubmitting,  bool hasMembersError,  bool hasDetailError)?  $default,) {final _that = this;
switch (_that) {
case _AdminPointState() when $default != null:
return $default(_that.members,_that.selected,_that.selectedDiscordId,_that.searchInput,_that.search,_that.memberPage,_that.memberTotalPages,_that.isLoadingMembers,_that.isLoadingDetail,_that.isSubmitting,_that.hasMembersError,_that.hasDetailError);case _:
  return null;

}
}

}

/// @nodoc


class _AdminPointState implements AdminPointState {
  const _AdminPointState({final  List<PointMember> members = const [], this.selected, this.selectedDiscordId, this.searchInput = '', this.search = '', this.memberPage = 1, this.memberTotalPages = 0, this.isLoadingMembers = false, this.isLoadingDetail = false, this.isSubmitting = false, this.hasMembersError = false, this.hasDetailError = false}): _members = members;
  

 final  List<PointMember> _members;
@override@JsonKey() List<PointMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  PointMemberDetail? selected;
@override final  String? selectedDiscordId;
@override@JsonKey() final  String searchInput;
@override@JsonKey() final  String search;
@override@JsonKey() final  int memberPage;
@override@JsonKey() final  int memberTotalPages;
@override@JsonKey() final  bool isLoadingMembers;
@override@JsonKey() final  bool isLoadingDetail;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool hasMembersError;
@override@JsonKey() final  bool hasDetailError;

/// Create a copy of AdminPointState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminPointStateCopyWith<_AdminPointState> get copyWith => __$AdminPointStateCopyWithImpl<_AdminPointState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminPointState&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.selectedDiscordId, selectedDiscordId) || other.selectedDiscordId == selectedDiscordId)&&(identical(other.searchInput, searchInput) || other.searchInput == searchInput)&&(identical(other.search, search) || other.search == search)&&(identical(other.memberPage, memberPage) || other.memberPage == memberPage)&&(identical(other.memberTotalPages, memberTotalPages) || other.memberTotalPages == memberTotalPages)&&(identical(other.isLoadingMembers, isLoadingMembers) || other.isLoadingMembers == isLoadingMembers)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.hasMembersError, hasMembersError) || other.hasMembersError == hasMembersError)&&(identical(other.hasDetailError, hasDetailError) || other.hasDetailError == hasDetailError));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_members),selected,selectedDiscordId,searchInput,search,memberPage,memberTotalPages,isLoadingMembers,isLoadingDetail,isSubmitting,hasMembersError,hasDetailError);

@override
String toString() {
  return 'AdminPointState(members: $members, selected: $selected, selectedDiscordId: $selectedDiscordId, searchInput: $searchInput, search: $search, memberPage: $memberPage, memberTotalPages: $memberTotalPages, isLoadingMembers: $isLoadingMembers, isLoadingDetail: $isLoadingDetail, isSubmitting: $isSubmitting, hasMembersError: $hasMembersError, hasDetailError: $hasDetailError)';
}


}

/// @nodoc
abstract mixin class _$AdminPointStateCopyWith<$Res> implements $AdminPointStateCopyWith<$Res> {
  factory _$AdminPointStateCopyWith(_AdminPointState value, $Res Function(_AdminPointState) _then) = __$AdminPointStateCopyWithImpl;
@override @useResult
$Res call({
 List<PointMember> members, PointMemberDetail? selected, String? selectedDiscordId, String searchInput, String search, int memberPage, int memberTotalPages, bool isLoadingMembers, bool isLoadingDetail, bool isSubmitting, bool hasMembersError, bool hasDetailError
});




}
/// @nodoc
class __$AdminPointStateCopyWithImpl<$Res>
    implements _$AdminPointStateCopyWith<$Res> {
  __$AdminPointStateCopyWithImpl(this._self, this._then);

  final _AdminPointState _self;
  final $Res Function(_AdminPointState) _then;

/// Create a copy of AdminPointState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? members = null,Object? selected = freezed,Object? selectedDiscordId = freezed,Object? searchInput = null,Object? search = null,Object? memberPage = null,Object? memberTotalPages = null,Object? isLoadingMembers = null,Object? isLoadingDetail = null,Object? isSubmitting = null,Object? hasMembersError = null,Object? hasDetailError = null,}) {
  return _then(_AdminPointState(
members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<PointMember>,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as PointMemberDetail?,selectedDiscordId: freezed == selectedDiscordId ? _self.selectedDiscordId : selectedDiscordId // ignore: cast_nullable_to_non_nullable
as String?,searchInput: null == searchInput ? _self.searchInput : searchInput // ignore: cast_nullable_to_non_nullable
as String,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,memberPage: null == memberPage ? _self.memberPage : memberPage // ignore: cast_nullable_to_non_nullable
as int,memberTotalPages: null == memberTotalPages ? _self.memberTotalPages : memberTotalPages // ignore: cast_nullable_to_non_nullable
as int,isLoadingMembers: null == isLoadingMembers ? _self.isLoadingMembers : isLoadingMembers // ignore: cast_nullable_to_non_nullable
as bool,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,hasMembersError: null == hasMembersError ? _self.hasMembersError : hasMembersError // ignore: cast_nullable_to_non_nullable
as bool,hasDetailError: null == hasDetailError ? _self.hasDetailError : hasDetailError // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
