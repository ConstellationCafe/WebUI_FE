// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatusQuery {

 List<Academy> get academies; List<AcademyClass> get classes; List<Student> get students; Academy? get selectedAcademy; AcademyClass? get selectedAcademyClass; Student? get selectedStudent; StudentRosterStatus? get selectedStatus; int get page; int get pageSize;
/// Create a copy of StudentStatusQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusQueryCopyWith<StudentStatusQuery> get copyWith => _$StudentStatusQueryCopyWithImpl<StudentStatusQuery>(this as StudentStatusQuery, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatusQuery&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.students, students)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedStudent, selectedStudent) || other.selectedStudent == selectedStudent)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(students),selectedAcademy,selectedAcademyClass,selectedStudent,selectedStatus,page,pageSize);

@override
String toString() {
  return 'StudentStatusQuery(academies: $academies, classes: $classes, students: $students, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedStudent: $selectedStudent, selectedStatus: $selectedStatus, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $StudentStatusQueryCopyWith<$Res>  {
  factory $StudentStatusQueryCopyWith(StudentStatusQuery value, $Res Function(StudentStatusQuery) _then) = _$StudentStatusQueryCopyWithImpl;
@useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Student> students, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Student? selectedStudent, StudentRosterStatus? selectedStatus, int page, int pageSize
});




}
/// @nodoc
class _$StudentStatusQueryCopyWithImpl<$Res>
    implements $StudentStatusQueryCopyWith<$Res> {
  _$StudentStatusQueryCopyWithImpl(this._self, this._then);

  final StudentStatusQuery _self;
  final $Res Function(StudentStatusQuery) _then;

/// Create a copy of StudentStatusQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? academies = null,Object? classes = null,Object? students = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedStudent = freezed,Object? selectedStatus = freezed,Object? page = null,Object? pageSize = null,}) {
  return _then(_self.copyWith(
academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedStudent: freezed == selectedStudent ? _self.selectedStudent : selectedStudent // ignore: cast_nullable_to_non_nullable
as Student?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as StudentRosterStatus?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentStatusQuery].
extension StudentStatusQueryPatterns on StudentStatusQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatusQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatusQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatusQuery value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatusQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatusQuery value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatusQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentRosterStatus? selectedStatus,  int page,  int pageSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatusQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.students,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatus,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentRosterStatus? selectedStatus,  int page,  int pageSize)  $default,) {final _that = this;
switch (_that) {
case _StudentStatusQuery():
return $default(_that.academies,_that.classes,_that.students,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatus,_that.page,_that.pageSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Academy> academies,  List<AcademyClass> classes,  List<Student> students,  Academy? selectedAcademy,  AcademyClass? selectedAcademyClass,  Student? selectedStudent,  StudentRosterStatus? selectedStatus,  int page,  int pageSize)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatusQuery() when $default != null:
return $default(_that.academies,_that.classes,_that.students,_that.selectedAcademy,_that.selectedAcademyClass,_that.selectedStudent,_that.selectedStatus,_that.page,_that.pageSize);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatusQuery implements StudentStatusQuery {
  const _StudentStatusQuery({final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<Student> students = const [], this.selectedAcademy, this.selectedAcademyClass, this.selectedStudent, this.selectedStatus, this.page = 1, this.pageSize = 20}): _academies = academies,_classes = classes,_students = students;
  

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

@override final  Academy? selectedAcademy;
@override final  AcademyClass? selectedAcademyClass;
@override final  Student? selectedStudent;
@override final  StudentRosterStatus? selectedStatus;
@override@JsonKey() final  int page;
@override@JsonKey() final  int pageSize;

/// Create a copy of StudentStatusQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusQueryCopyWith<_StudentStatusQuery> get copyWith => __$StudentStatusQueryCopyWithImpl<_StudentStatusQuery>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatusQuery&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._students, _students)&&(identical(other.selectedAcademy, selectedAcademy) || other.selectedAcademy == selectedAcademy)&&(identical(other.selectedAcademyClass, selectedAcademyClass) || other.selectedAcademyClass == selectedAcademyClass)&&(identical(other.selectedStudent, selectedStudent) || other.selectedStudent == selectedStudent)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_students),selectedAcademy,selectedAcademyClass,selectedStudent,selectedStatus,page,pageSize);

@override
String toString() {
  return 'StudentStatusQuery(academies: $academies, classes: $classes, students: $students, selectedAcademy: $selectedAcademy, selectedAcademyClass: $selectedAcademyClass, selectedStudent: $selectedStudent, selectedStatus: $selectedStatus, page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusQueryCopyWith<$Res> implements $StudentStatusQueryCopyWith<$Res> {
  factory _$StudentStatusQueryCopyWith(_StudentStatusQuery value, $Res Function(_StudentStatusQuery) _then) = __$StudentStatusQueryCopyWithImpl;
@override @useResult
$Res call({
 List<Academy> academies, List<AcademyClass> classes, List<Student> students, Academy? selectedAcademy, AcademyClass? selectedAcademyClass, Student? selectedStudent, StudentRosterStatus? selectedStatus, int page, int pageSize
});




}
/// @nodoc
class __$StudentStatusQueryCopyWithImpl<$Res>
    implements _$StudentStatusQueryCopyWith<$Res> {
  __$StudentStatusQueryCopyWithImpl(this._self, this._then);

  final _StudentStatusQuery _self;
  final $Res Function(_StudentStatusQuery) _then;

/// Create a copy of StudentStatusQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? academies = null,Object? classes = null,Object? students = null,Object? selectedAcademy = freezed,Object? selectedAcademyClass = freezed,Object? selectedStudent = freezed,Object? selectedStatus = freezed,Object? page = null,Object? pageSize = null,}) {
  return _then(_StudentStatusQuery(
academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<Student>,selectedAcademy: freezed == selectedAcademy ? _self.selectedAcademy : selectedAcademy // ignore: cast_nullable_to_non_nullable
as Academy?,selectedAcademyClass: freezed == selectedAcademyClass ? _self.selectedAcademyClass : selectedAcademyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass?,selectedStudent: freezed == selectedStudent ? _self.selectedStudent : selectedStudent // ignore: cast_nullable_to_non_nullable
as Student?,selectedStatus: freezed == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as StudentRosterStatus?,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
