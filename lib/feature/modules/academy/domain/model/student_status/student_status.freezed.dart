// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatus {

 List<Academy> get academies; List<AcademyClass> get classes; List<Student> get students; List<Subject> get subjects; Academy? get selectedAcademy; AcademyClass? get selectedAcademyClass; Student? get selectedStudent; StudentStatusType? get selectedStatusType; List<Subject> get selectedSubjects; String get reason;
/// Create a copy of StudentStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusCopyWith<StudentStatus> get copyWith => _$StudentStatusCopyWithImpl<StudentStatus>(this as StudentStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatus&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.students, students)&&const DeepCollectionEquality().equals(other.subjects, subjects)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedStudent, selectedStudent) || other.selectedStudent == selectedStudent)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&const DeepCollectionEquality().equals(other.selectedSubjects, selectedSubjects)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(students),const DeepCollectionEquality().hash(subjects),selectedAcademy,selectedAcademyClass,selectedStudent,selectedStatusType,const DeepCollectionEquality().hash(selectedSubjects),reason);

@override
String toString() {
  return 'StudentStatus(academies: $academies, classes: $classes, students: $students, subjects: $subjects, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedStudent: $selectedStudent, selectedStatusType: $selectedStatusType, selectedSubjects: $selectedSubjects, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $StudentStatusCopyWith<$Res>  {
  factory $StudentStatusCopyWith(StudentStatus value, $Res Function(StudentStatus) _then) = _$StudentStatusCopyWithImpl;
@useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Student> students, List<Subject> subjects, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Student? selectedStudent, StudentStatusType? selectedStatusType, List<Subject> selectedSubjects, String reason
});




}
/// @nodoc
class _$StudentStatusCopyWithImpl<$Res>
    implements $StudentStatusCopyWith<$Res> {
  _$StudentStatusCopyWithImpl(this._self, this._then);

  final StudentStatus _self;
  final $Res Function(StudentStatus) _then;

/// Create a copy of StudentStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academies = null,Object? classes = null,Object? students = null,Object? subjects = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedStudent = freezed,Object? selectedStatusType = freezed,Object? selectedSubjects = null,Object? reason = null,}) {
  return _then(_self.copyWith(
academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedStudent: freezed == selectedStudent ? _self.selectedStudent : selectedStudent // ignore: cast_nullable_to_non_nullable
as Student?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as StudentStatusType?,selectedSubjects: null == selectedSubjects ? _self.selectedSubjects : selectedSubjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentStatus].
extension StudentStatusPatterns on StudentStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatus value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatus value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentStatusType? selectedStatusType,  List<Subject> selectedSubjects,  String reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatus() when $default != null:
return $default(_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatusType,_that.selectedSubjects,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentStatusType? selectedStatusType,  List<Subject> selectedSubjects,  String reason)  $default,) {final _that = this;
switch (_that) {
case _StudentStatus():
return $default(_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatusType,_that.selectedSubjects,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentStatusType? selectedStatusType,  List<Subject> selectedSubjects,  String reason)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatus() when $default != null:
return $default(_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatusType,_that.selectedSubjects,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatus implements StudentStatus {
  const _StudentStatus({final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<Student> students = const [], final  List<Subject> subjects = const [], this.selectedAcademy, this.selectedAcademyClass, this.selectedStudent, this.selectedStatusType, final  List<Subject> selectedSubjects = const [], this.reason = ''}): _academies = academies,_classes = classes,_students = students,_subjects = subjects,_selectedSubjects = selectedSubjects;
  

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

 final  List<Student> _students;
@override@JsonKey() List<Student> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}

 final  List<Subject> _subjects;
@override@JsonKey() List<Subject> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}

@override final  Academy? selectedAcademy;
@override final  AcademyClass? selectedAcademyClass;
@override final  Student? selectedStudent;
@override final  StudentStatusType? selectedStatusType;
 final  List<Subject> _selectedSubjects;
@override@JsonKey() List<Subject> get selectedSubjects {
  if (_selectedSubjects is EqualUnmodifiableListView) return _selectedSubjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedSubjects);
}

@override@JsonKey() final  String reason;

/// Create a copy of StudentStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusCopyWith<_StudentStatus> get copyWith => __$StudentStatusCopyWithImpl<_StudentStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatus&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._students, _students)&&const DeepCollectionEquality().equals(other._subjects, _subjects)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedStudent, selectedStudent) || other.selectedStudent == selectedStudent)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&const DeepCollectionEquality().equals(other._selectedSubjects, _selectedSubjects)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_students),const DeepCollectionEquality().hash(_subjects),selectedAcademy,selectedAcademyClass,selectedStudent,selectedStatusType,const DeepCollectionEquality().hash(_selectedSubjects),reason);

@override
String toString() {
  return 'StudentStatus(academies: $academies, classes: $classes, students: $students, subjects: $subjects, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedStudent: $selectedStudent, selectedStatusType: $selectedStatusType, selectedSubjects: $selectedSubjects, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusCopyWith<$Res> implements $StudentStatusCopyWith<$Res> {
  factory _$StudentStatusCopyWith(_StudentStatus value, $Res Function(_StudentStatus) _then) = __$StudentStatusCopyWithImpl;
@override @useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Student> students, List<Subject> subjects, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Student? selectedStudent, StudentStatusType? selectedStatusType, List<Subject> selectedSubjects, String reason
});




}
/// @nodoc
class __$StudentStatusCopyWithImpl<$Res>
    implements _$StudentStatusCopyWith<$Res> {
  __$StudentStatusCopyWithImpl(this._self, this._then);

  final _StudentStatus _self;
  final $Res Function(_StudentStatus) _then;

/// Create a copy of StudentStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academies = null,Object? classes = null,Object? students = null,Object? subjects = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedStudent = freezed,Object? selectedStatusType = freezed,Object? selectedSubjects = null,Object? reason = null,}) {
  return _then(_StudentStatus(
academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedStudent: freezed == selectedStudent ? _self.selectedStudent : selectedStudent // ignore: cast_nullable_to_non_nullable
as Student?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as StudentStatusType?,selectedSubjects: null == selectedSubjects ? _self._selectedSubjects : selectedSubjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
