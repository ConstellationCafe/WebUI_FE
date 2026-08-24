// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordQuery {

 List<Academy> get academies; List<AcademyClass> get classes; List<Teacher> get teachers; List<Student> get students; List<Subject> get subjects; Academy? get selectedAcademy; AcademyClass? get selectedAcademyClass; Subject? get selectedSubject; Teacher? get mainTeacher; List<Teacher> get selectedCoTeachers; List<Student> get selectedStudents; DateTime? get educationDate; DateTime? get startTime; DateTime? get endTime;
/// Create a copy of LessonRecordQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordQueryCopyWith<LessonRecordQuery> get copyWith => _$LessonRecordQueryCopyWithImpl<LessonRecordQuery>(this as LessonRecordQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordQuery&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.teachers, teachers)&&const DeepCollectionEquality().equals(other.students, students)&&const DeepCollectionEquality().equals(other.subjects, subjects)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedSubject, selectedSubject) || other.selectedSubject == selectedSubject)&&(identical(other.mainTeacher, mainTeacher) || other.mainTeacher == mainTeacher)&&const DeepCollectionEquality().equals(other.selectedCoTeachers, selectedCoTeachers)&&const DeepCollectionEquality().equals(other.selectedStudents, selectedStudents)&&(identical(other.educationDate, educationDate) || other.educationDate == educationDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(teachers),const DeepCollectionEquality().hash(students),const DeepCollectionEquality().hash(subjects),selectedAcademy,selectedAcademyClass,selectedSubject,mainTeacher,const DeepCollectionEquality().hash(selectedCoTeachers),const DeepCollectionEquality().hash(selectedStudents),educationDate,startTime,endTime);

@override
String toString() {
  return 'LessonRecordQuery(academies: $academies, classes: $classes, teachers: $teachers, students: $students, subjects: $subjects, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedSubject: $selectedSubject, mainTeacher: $mainTeacher, selectedCoTeachers: $selectedCoTeachers, selectedStudents: $selectedStudents, educationDate: $educationDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class $LessonRecordQueryCopyWith<$Res>  {
  factory $LessonRecordQueryCopyWith(LessonRecordQuery value, $Res Function(LessonRecordQuery) _then) = _$LessonRecordQueryCopyWithImpl;
@useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Teacher> teachers, List<Student> students, List<Subject> subjects, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Subject? selectedSubject, Teacher? mainTeacher, List<Teacher> selectedCoTeachers, List<Student> selectedStudents, DateTime? educationDate, DateTime? startTime, DateTime? endTime
});




}
/// @nodoc
class _$LessonRecordQueryCopyWithImpl<$Res>
    implements $LessonRecordQueryCopyWith<$Res> {
  _$LessonRecordQueryCopyWithImpl(this._self, this._then);

  final LessonRecordQuery _self;
  final $Res Function(LessonRecordQuery) _then;

/// Create a copy of LessonRecordQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academies = null,Object? classes = null,Object? teachers = null,Object? students = null,Object? subjects = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedSubject = freezed,Object? mainTeacher = freezed,Object? selectedCoTeachers = null,Object? selectedStudents = null,Object? educationDate = freezed,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_self.copyWith(
academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,teachers: null == teachers ? _self.teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedSubject: freezed == selectedSubject ? _self.selectedSubject : selectedSubject // ignore: cast_nullable_to_non_nullable
as Subject?,mainTeacher: freezed == mainTeacher ? _self.mainTeacher : mainTeacher // ignore: cast_nullable_to_non_nullable
as Teacher?,selectedCoTeachers: null == selectedCoTeachers ? _self.selectedCoTeachers : selectedCoTeachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,selectedStudents: null == selectedStudents ? _self.selectedStudents : selectedStudents // ignore: cast_nullable_to_non_nullable
as List<Student>,educationDate: freezed == educationDate ? _self.educationDate : educationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonRecordQuery].
extension LessonRecordQueryPatterns on LessonRecordQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordQuery value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordQuery value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Subject? selectedSubject,  Teacher? mainTeacher,  List<Teacher> selectedCoTeachers,  List<Student> selectedStudents,  DateTime? educationDate,  DateTime? startTime,  DateTime? endTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.teachers,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedSubject,_that.mainTeacher,_that.selectedCoTeachers,_that.selectedStudents,_that.educationDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Subject? selectedSubject,  Teacher? mainTeacher,  List<Teacher> selectedCoTeachers,  List<Student> selectedStudents,  DateTime? educationDate,  DateTime? startTime,  DateTime? endTime)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordQuery():
return $default(_that.academies,_that.classes,_that.teachers,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedSubject,_that.mainTeacher,_that.selectedCoTeachers,_that.selectedStudents,_that.educationDate,_that.startTime,_that.endTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Academy> academies,  List<AcademyClass> classes,  List<Teacher> teachers,  List<Student> students,  List<Subject> subjects,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Subject? selectedSubject,  Teacher? mainTeacher,  List<Teacher> selectedCoTeachers,  List<Student> selectedStudents,  DateTime? educationDate,  DateTime? startTime,  DateTime? endTime)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.teachers,_that.students,_that.subjects,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedSubject,_that.mainTeacher,_that.selectedCoTeachers,_that.selectedStudents,_that.educationDate,_that.startTime,_that.endTime);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordQuery implements LessonRecordQuery {
  const _LessonRecordQuery({final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<Teacher> teachers = const [], final  List<Student> students = const [], final  List<Subject> subjects = const [], this.selectedAcademy, this.selectedAcademyClass, this.selectedSubject, this.mainTeacher, final  List<Teacher> selectedCoTeachers = const [], final  List<Student> selectedStudents = const [], this.educationDate, this.startTime, this.endTime}): _academies = academies,_classes = classes,_teachers = teachers,_students = students,_subjects = subjects,_selectedCoTeachers = selectedCoTeachers,_selectedStudents = selectedStudents;
  

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
@override final  Subject? selectedSubject;
@override final  Teacher? mainTeacher;
 final  List<Teacher> _selectedCoTeachers;
@override@JsonKey() List<Teacher> get selectedCoTeachers {
  if (_selectedCoTeachers is EqualUnmodifiableListView) return _selectedCoTeachers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedCoTeachers);
}

 final  List<Student> _selectedStudents;
@override@JsonKey() List<Student> get selectedStudents {
  if (_selectedStudents is EqualUnmodifiableListView) return _selectedStudents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedStudents);
}

@override final  DateTime? educationDate;
@override final  DateTime? startTime;
@override final  DateTime? endTime;

/// Create a copy of LessonRecordQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordQueryCopyWith<_LessonRecordQuery> get copyWith => __$LessonRecordQueryCopyWithImpl<_LessonRecordQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordQuery&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._teachers, _teachers)&&const DeepCollectionEquality().equals(other._students, _students)&&const DeepCollectionEquality().equals(other._subjects, _subjects)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedSubject, selectedSubject) || other.selectedSubject == selectedSubject)&&(identical(other.mainTeacher, mainTeacher) || other.mainTeacher == mainTeacher)&&const DeepCollectionEquality().equals(other._selectedCoTeachers, _selectedCoTeachers)&&const DeepCollectionEquality().equals(other._selectedStudents, _selectedStudents)&&(identical(other.educationDate, educationDate) || other.educationDate == educationDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_teachers),const DeepCollectionEquality().hash(_students),const DeepCollectionEquality().hash(_subjects),selectedAcademy,selectedAcademyClass,selectedSubject,mainTeacher,const DeepCollectionEquality().hash(_selectedCoTeachers),const DeepCollectionEquality().hash(_selectedStudents),educationDate,startTime,endTime);

@override
String toString() {
  return 'LessonRecordQuery(academies: $academies, classes: $classes, teachers: $teachers, students: $students, subjects: $subjects, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedSubject: $selectedSubject, mainTeacher: $mainTeacher, selectedCoTeachers: $selectedCoTeachers, selectedStudents: $selectedStudents, educationDate: $educationDate, startTime: $startTime, endTime: $endTime)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordQueryCopyWith<$Res> implements $LessonRecordQueryCopyWith<$Res> {
  factory _$LessonRecordQueryCopyWith(_LessonRecordQuery value, $Res Function(_LessonRecordQuery) _then) = __$LessonRecordQueryCopyWithImpl;
@override @useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Teacher> teachers, List<Student> students, List<Subject> subjects, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Subject? selectedSubject, Teacher? mainTeacher, List<Teacher> selectedCoTeachers, List<Student> selectedStudents, DateTime? educationDate, DateTime? startTime, DateTime? endTime
});




}
/// @nodoc
class __$LessonRecordQueryCopyWithImpl<$Res>
    implements _$LessonRecordQueryCopyWith<$Res> {
  __$LessonRecordQueryCopyWithImpl(this._self, this._then);

  final _LessonRecordQuery _self;
  final $Res Function(_LessonRecordQuery) _then;

/// Create a copy of LessonRecordQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academies = null,Object? classes = null,Object? teachers = null,Object? students = null,Object? subjects = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedSubject = freezed,Object? mainTeacher = freezed,Object? selectedCoTeachers = null,Object? selectedStudents = null,Object? educationDate = freezed,Object? startTime = freezed,Object? endTime = freezed,}) {
  return _then(_LessonRecordQuery(
academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,teachers: null == teachers ? _self._teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedSubject: freezed == selectedSubject ? _self.selectedSubject : selectedSubject // ignore: cast_nullable_to_non_nullable
as Subject?,mainTeacher: freezed == mainTeacher ? _self.mainTeacher : mainTeacher // ignore: cast_nullable_to_non_nullable
as Teacher?,selectedCoTeachers: null == selectedCoTeachers ? _self._selectedCoTeachers : selectedCoTeachers // ignore: cast_nullable_to_non_nullable
as List<Teacher>,selectedStudents: null == selectedStudents ? _self._selectedStudents : selectedStudents // ignore: cast_nullable_to_non_nullable
as List<Student>,educationDate: freezed == educationDate ? _self.educationDate : educationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
