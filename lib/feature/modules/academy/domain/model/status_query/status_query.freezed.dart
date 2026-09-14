// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'status_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatusQuery<TMember extends AcademyMember,TStatus extends RosterStatus> {

 List<Academy> get academies; List<AcademyClass> get classes; List<TMember> get academyMembers; Academy? get selectedAcademy; AcademyClass? get selectedAcademyClass; TMember? get selectedAcademyMember; TStatus? get selectedStatus; int get page; int get pageSize;
/// Create a copy of StatusQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusQueryCopyWith<TMember, TStatus, StatusQuery<TMember, TStatus>> get copyWith => _$StatusQueryCopyWithImpl<TMember, TStatus, StatusQuery<TMember, TStatus>>(this as StatusQuery<TMember, TStatus>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusQuery<TMember, TStatus>&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.academyMembers, academyMembers)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&const DeepCollectionEquality().equals(other.selectedAcademyMember, selectedAcademyMember)&&const DeepCollectionEquality().equals(other.selectedStatus, selectedStatus)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(academyMembers),selectedAcademy,selectedAcademyClass,const DeepCollectionEquality().hash(selectedAcademyMember),const DeepCollectionEquality().hash(selectedStatus),page,pageSize);

@override
String toString() {
  return 'StatusQuery<$TMember, $TStatus>(academies: $academies, classes: $classes, academyMembers: $academyMembers, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedAcademyMember: $selectedAcademyMember, selectedStatus: $selectedStatus, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $StatusQueryCopyWith<TMember extends AcademyMember,TStatus extends RosterStatus,$Res>  {
  factory $StatusQueryCopyWith(StatusQuery<TMember, TStatus> value, $Res Function(StatusQuery<TMember, TStatus>) _then) = _$StatusQueryCopyWithImpl;
@useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<TMember> academyMembers, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, TMember? selectedAcademyMember, TStatus? selectedStatus, int page, int pageSize
});




}
/// @nodoc
class _$StatusQueryCopyWithImpl<TMember extends AcademyMember,TStatus extends RosterStatus,$Res>
    implements $StatusQueryCopyWith<TMember, TStatus, $Res> {
  _$StatusQueryCopyWithImpl(this._self, this._then);

  final StatusQuery<TMember, TStatus> _self;
  final $Res Function(StatusQuery<TMember, TStatus>) _then;

/// Create a copy of StatusQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academies = null,Object? classes = null,Object? academyMembers = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedAcademyMember = freezed,Object? selectedStatus = freezed,Object? page = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,academyMembers: null == academyMembers ? _self.academyMembers : academyMembers // ignore: cast_nullable_to_non_nullable
as List<TMember>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedAcademyMember: freezed == selectedAcademyMember ? _self.selectedAcademyMember : selectedAcademyMember // ignore: cast_nullable_to_non_nullable
as TMember?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TStatus?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusQuery].
extension StatusQueryPatterns<TMember extends AcademyMember,TStatus extends RosterStatus> on StatusQuery<TMember, TStatus> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusQuery<TMember, TStatus> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusQuery<TMember, TStatus> value)  $default,){
final _that = this;
switch (_that) {
case _StatusQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusQuery<TMember, TStatus> value)?  $default,){
final _that = this;
switch (_that) {
case _StatusQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<TMember> academyMembers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  TMember? selectedAcademyMember,  TStatus? selectedStatus,  int page,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.academyMembers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedAcademyMember,_that.selectedStatus,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<TMember> academyMembers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  TMember? selectedAcademyMember,  TStatus? selectedStatus,  int page,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _StatusQuery():
return $default(_that.academies,_that.classes,_that.academyMembers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedAcademyMember,_that.selectedStatus,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Academy> academies,  List<AcademyClass> classes,  List<TMember> academyMembers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  TMember? selectedAcademyMember,  TStatus? selectedStatus,  int page,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _StatusQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.academyMembers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedAcademyMember,_that.selectedStatus,_that.page,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc


class _StatusQuery<TMember extends AcademyMember,TStatus extends RosterStatus> extends StatusQuery<TMember, TStatus> {
  const _StatusQuery({final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<TMember> academyMembers = const [], this.selectedAcademy, this.selectedAcademyClass, this.selectedAcademyMember, this.selectedStatus, this.page = 1, this.pageSize = 20}): _academies = academies,_classes = classes,_academyMembers = academyMembers,super._();
  

 final  List<Academy> _academies;
@override@JsonKey() List<Academy> get academies {
  if (_academies is EqualUnmodifiableListView) return _academies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_academies);
}

 final  List<AcademyClass> _classes;
@override@JsonKey() List<AcademyClass> get classes {
  if (_classes is EqualUnmodifiableListView) return _classes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_classes);
}

 final  List<TMember> _academyMembers;
@override@JsonKey() List<TMember> get academyMembers {
  if (_academyMembers is EqualUnmodifiableListView) return _academyMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_academyMembers);
}

@override final  Academy? selectedAcademy;
@override final  AcademyClass? selectedAcademyClass;
@override final  TMember? selectedAcademyMember;
@override final  TStatus? selectedStatus;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;

/// Create a copy of StatusQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusQueryCopyWith<TMember, TStatus, _StatusQuery<TMember, TStatus>> get copyWith => __$StatusQueryCopyWithImpl<TMember, TStatus, _StatusQuery<TMember, TStatus>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusQuery<TMember, TStatus>&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._academyMembers, _academyMembers)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&const DeepCollectionEquality().equals(other.selectedAcademyMember, selectedAcademyMember)&&const DeepCollectionEquality().equals(other.selectedStatus, selectedStatus)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_academyMembers),selectedAcademy,selectedAcademyClass,const DeepCollectionEquality().hash(selectedAcademyMember),const DeepCollectionEquality().hash(selectedStatus),page,pageSize);

@override
String toString() {
  return 'StatusQuery<$TMember, $TStatus>(academies: $academies, classes: $classes, academyMembers: $academyMembers, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedAcademyMember: $selectedAcademyMember, selectedStatus: $selectedStatus, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$StatusQueryCopyWith<TMember extends AcademyMember,TStatus extends RosterStatus,$Res> implements $StatusQueryCopyWith<TMember, TStatus, $Res> {
  factory _$StatusQueryCopyWith(_StatusQuery<TMember, TStatus> value, $Res Function(_StatusQuery<TMember, TStatus>) _then) = __$StatusQueryCopyWithImpl;
@override @useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<TMember> academyMembers, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, TMember? selectedAcademyMember, TStatus? selectedStatus, int page, int pageSize
});




}
/// @nodoc
class __$StatusQueryCopyWithImpl<TMember extends AcademyMember,TStatus extends RosterStatus,$Res>
    implements _$StatusQueryCopyWith<TMember, TStatus, $Res> {
  __$StatusQueryCopyWithImpl(this._self, this._then);

  final _StatusQuery<TMember, TStatus> _self;
  final $Res Function(_StatusQuery<TMember, TStatus>) _then;

/// Create a copy of StatusQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academies = null,Object? classes = null,Object? academyMembers = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedAcademyMember = freezed,Object? selectedStatus = freezed,Object? page = null,Object? pageSize = null,}) {
  return _then(_StatusQuery<TMember, TStatus>(
academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,academyMembers: null == academyMembers ? _self._academyMembers : academyMembers // ignore: cast_nullable_to_non_nullable
as List<TMember>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedAcademyMember: freezed == selectedAcademyMember ? _self.selectedAcademyMember : selectedAcademyMember // ignore: cast_nullable_to_non_nullable
as TMember?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as TStatus?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
