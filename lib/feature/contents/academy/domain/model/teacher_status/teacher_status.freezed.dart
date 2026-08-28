// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherStatus {

 List<Academy> get academies; List<AcademyClass> get classes; List<Teacher> get teachers; Academy? get selectedAcademy; AcademyClass? get selectedAcademyClass; Teacher? get selectedTeacher; TeacherStatusType? get selectedStatusType; String get reason; dynamic get k;
/// Create a copy of TeacherStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherStatusCopyWith<TeacherStatus> get copyWith => _$TeacherStatusCopyWithImpl<TeacherStatus>(this as TeacherStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherStatus&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.teachers, teachers)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedTeacher, selectedTeacher) || other.selectedTeacher == selectedTeacher)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.k, k));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(teachers),selectedAcademy,selectedAcademyClass,selectedTeacher,selectedStatusType,reason,const DeepCollectionEquality().hash(k));

@override
String toString() {
  return 'TeacherStatus(academies: $academies, classes: $classes, teachers: $teachers, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedTeacher: $selectedTeacher, selectedStatusType: $selectedStatusType, reason: $reason, k: $k)';
}


}

/// @nodoc
abstract mixin class $TeacherStatusCopyWith<$Res>  {
  factory $TeacherStatusCopyWith(TeacherStatus value, $Res Function(TeacherStatus) _then) = _$TeacherStatusCopyWithImpl;
@useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Teacher> teachers, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Teacher? selectedTeacher, TeacherStatusType? selectedStatusType, String reason, dynamic k
});




}
/// @nodoc
class _$TeacherStatusCopyWithImpl<$Res>
    implements $TeacherStatusCopyWith<$Res> {
  _$TeacherStatusCopyWithImpl(this._self, this._then);

  final TeacherStatus _self;
  final $Res Function(TeacherStatus) _then;

/// Create a copy of TeacherStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academies = null,Object? classes = null,Object? teachers = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedTeacher = freezed,Object? selectedStatusType = freezed,Object? reason = null,Object? k = freezed,}) {
  return _then(_self.copyWith(
academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,teachers: null == teachers ? _self.teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedTeacher: freezed == selectedTeacher ? _self.selectedTeacher : selectedTeacher // ignore: cast_nullable_to_non_nullable
as Teacher?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as TeacherStatusType?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,k: freezed == k ? _self.k : k // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [TeacherStatus].
extension TeacherStatusPatterns on TeacherStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherStatus value)  $default,){
final _that = this;
switch (_that) {
case _TeacherStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherStatus value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Teacher? selectedTeacher,  TeacherStatusType? selectedStatusType,  String reason,  dynamic k)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherStatus() when $default != null:
return $default(_that.academies,_that.classes,_that.teachers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedTeacher,_that.selectedStatusType,_that.reason,_that.k);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Teacher? selectedTeacher,  TeacherStatusType? selectedStatusType,  String reason,  dynamic k)  $default,) {final _that = this;
switch (_that) {
case _TeacherStatus():
return $default(_that.academies,_that.classes,_that.teachers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedTeacher,_that.selectedStatusType,_that.reason,_that.k);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Teacher? selectedTeacher,  TeacherStatusType? selectedStatusType,  String reason,  dynamic k)?  $default,) {final _that = this;
switch (_that) {
case _TeacherStatus() when $default != null:
return $default(_that.academies,_that.classes,_that.teachers,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedTeacher,_that.selectedStatusType,_that.reason,_that.k);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherStatus implements TeacherStatus {
  const _TeacherStatus({final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<Teacher> teachers = const [], this.selectedAcademy, this.selectedAcademyClass, this.selectedTeacher, this.selectedStatusType, this.reason = '', this.k}): _academies = academies,_classes = classes,_teachers = teachers;
  

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

 final  List<Teacher> _teachers;
@override@JsonKey() List<Teacher> get teachers {
  if (_teachers is EqualUnmodifiableListView) return _teachers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teachers);
}

@override final  Academy? selectedAcademy;
@override final  AcademyClass? selectedAcademyClass;
@override final  Teacher? selectedTeacher;
@override final  TeacherStatusType? selectedStatusType;
@override@JsonKey() final  String reason;
@override final  dynamic k;

/// Create a copy of TeacherStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherStatusCopyWith<_TeacherStatus> get copyWith => __$TeacherStatusCopyWithImpl<_TeacherStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherStatus&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._teachers, _teachers)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedTeacher, selectedTeacher) || other.selectedTeacher == selectedTeacher)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&(identical(other.reason, reason) || other.reason == reason)&&const DeepCollectionEquality().equals(other.k, k));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_teachers),selectedAcademy,selectedAcademyClass,selectedTeacher,selectedStatusType,reason,const DeepCollectionEquality().hash(k));

@override
String toString() {
  return 'TeacherStatus(academies: $academies, classes: $classes, teachers: $teachers, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedTeacher: $selectedTeacher, selectedStatusType: $selectedStatusType, reason: $reason, k: $k)';
}


}

/// @nodoc
abstract mixin class _$TeacherStatusCopyWith<$Res> implements $TeacherStatusCopyWith<$Res> {
  factory _$TeacherStatusCopyWith(_TeacherStatus value, $Res Function(_TeacherStatus) _then) = __$TeacherStatusCopyWithImpl;
@override @useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Teacher> teachers, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Teacher? selectedTeacher, TeacherStatusType? selectedStatusType, String reason, dynamic k
});




}
/// @nodoc
class __$TeacherStatusCopyWithImpl<$Res>
    implements _$TeacherStatusCopyWith<$Res> {
  __$TeacherStatusCopyWithImpl(this._self, this._then);

  final _TeacherStatus _self;
  final $Res Function(_TeacherStatus) _then;

/// Create a copy of TeacherStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academies = null,Object? classes = null,Object? teachers = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedTeacher = freezed,Object? selectedStatusType = freezed,Object? reason = null,Object? k = freezed,}) {
  return _then(_TeacherStatus(
academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,teachers: null == teachers ? _self._teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedTeacher: freezed == selectedTeacher ? _self.selectedTeacher : selectedTeacher // ignore: cast_nullable_to_non_nullable
as Teacher?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as TeacherStatusType?,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,k: freezed == k ? _self.k : k // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
