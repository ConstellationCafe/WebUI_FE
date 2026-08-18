// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatusState {

 bool get isLoading; bool get isProcessing; List<Academy> get academies; List<AcademyClass> get classes; List<AcademyStudent> get students; List<Subject> get subjects; String? get selectedAcademyId; String? get selectedClassName; String? get selectedStudentId; StudentStatusType? get selectedStatusType; List<String> get selectedSubjectIds; String get reason; String? get errorMessage;
/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusStateCopyWith<StudentStatusState> get copyWith => _$StudentStatusStateCopyWithImpl<StudentStatusState>(this as StudentStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.students, students)&&const DeepCollectionEquality().equals(other.subjects, subjects)&&(identical(other.selectedAcademyId, selectedAcademyId) || other.selectedAcademyId == selectedAcademyId)&&(identical(other.selectedClassName, selectedClassName) || other.selectedClassName == selectedClassName)&&(identical(other.selectedStudentId, selectedStudentId) || other.selectedStudentId == selectedStudentId)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&const DeepCollectionEquality().equals(other.selectedSubjectIds, selectedSubjectIds)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(students),const DeepCollectionEquality().hash(subjects),selectedAcademyId,selectedClassName,selectedStudentId,selectedStatusType,const DeepCollectionEquality().hash(selectedSubjectIds),reason,errorMessage);

@override
String toString() {
  return 'StudentStatusState(isLoading: $isLoading, isProcessing: $isProcessing, academies: $academies, classes: $classes, students: $students, subjects: $subjects, selectedAcademyId: $selectedAcademyId, selectedClassName: $selectedClassName, selectedStudentId: $selectedStudentId, selectedStatusType: $selectedStatusType, selectedSubjectIds: $selectedSubjectIds, reason: $reason, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StudentStatusStateCopyWith<$Res>  {
  factory $StudentStatusStateCopyWith(StudentStatusState value, $Res Function(StudentStatusState) _then) = _$StudentStatusStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isProcessing, List<Academy> academies, List<AcademyClass> classes, List<AcademyStudent> students, List<Subject> subjects, String? selectedAcademyId, String? selectedClassName, String? selectedStudentId, StudentStatusType? selectedStatusType, List<String> selectedSubjectIds, String reason, String? errorMessage
});




}
/// @nodoc
class _$StudentStatusStateCopyWithImpl<$Res>
    implements $StudentStatusStateCopyWith<$Res> {
  _$StudentStatusStateCopyWithImpl(this._self, this._then);

  final StudentStatusState _self;
  final $Res Function(StudentStatusState) _then;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isProcessing = null,Object? academies = null,Object? classes = null,Object? students = null,Object? subjects = null,Object? selectedAcademyId = freezed,Object? selectedClassName = freezed,Object? selectedStudentId = freezed,Object? selectedStatusType = freezed,Object? selectedSubjectIds = null,Object? reason = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<AcademyStudent>,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademyId: freezed == selectedAcademyId ? _self.selectedAcademyId : selectedAcademyId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassName: freezed == selectedClassName ? _self.selectedClassName : selectedClassName // ignore: cast_nullable_to_non_nullable
as String?,selectedStudentId: freezed == selectedStudentId ? _self.selectedStudentId : selectedStudentId // ignore: cast_nullable_to_non_nullable
as String?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as StudentStatusType?,selectedSubjectIds: null == selectedSubjectIds ? _self.selectedSubjectIds : selectedSubjectIds // ignore: cast_nullable_to_non_nullable
as List<String>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentStatusState].
extension StudentStatusStatePatterns on StudentStatusState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatusState value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatusState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatusState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  List<Academy> academies,  List<AcademyClass> classes,  List<AcademyStudent> students,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassName,  String? selectedStudentId,  StudentStatusType? selectedStatusType,  List<String> selectedSubjectIds,  String reason,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademyId,_that.selectedClassName,_that.selectedStudentId,_that.selectedStatusType,_that.selectedSubjectIds,_that.reason,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isProcessing,  List<Academy> academies,  List<AcademyClass> classes,  List<AcademyStudent> students,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassName,  String? selectedStudentId,  StudentStatusType? selectedStatusType,  List<String> selectedSubjectIds,  String reason,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StudentStatusState():
return $default(_that.isLoading,_that.isProcessing,_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademyId,_that.selectedClassName,_that.selectedStudentId,_that.selectedStatusType,_that.selectedSubjectIds,_that.reason,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isProcessing,  List<Academy> academies,  List<AcademyClass> classes,  List<AcademyStudent> students,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassName,  String? selectedStudentId,  StudentStatusType? selectedStatusType,  List<String> selectedSubjectIds,  String reason,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatusState() when $default != null:
return $default(_that.isLoading,_that.isProcessing,_that.academies,_that.classes,_that.students,_that.subjects,_that.selectedAcademyId,_that.selectedClassName,_that.selectedStudentId,_that.selectedStatusType,_that.selectedSubjectIds,_that.reason,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatusState implements StudentStatusState {
  const _StudentStatusState({this.isLoading = false, this.isProcessing = false, final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<AcademyStudent> students = const [], final  List<Subject> subjects = const [], this.selectedAcademyId, this.selectedClassName, this.selectedStudentId, this.selectedStatusType, final  List<String> selectedSubjectIds = const [], this.reason = '', this.errorMessage}): _academies = academies,_classes = classes,_students = students,_subjects = subjects,_selectedSubjectIds = selectedSubjectIds;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isProcessing;
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

 final  List<AcademyStudent> _students;
@override@JsonKey() List<AcademyStudent> get students {
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

@override final  String? selectedAcademyId;
@override final  String? selectedClassName;
@override final  String? selectedStudentId;
@override final  StudentStatusType? selectedStatusType;
 final  List<String> _selectedSubjectIds;
@override@JsonKey() List<String> get selectedSubjectIds {
  if (_selectedSubjectIds is EqualUnmodifiableListView) return _selectedSubjectIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedSubjectIds);
}

@override@JsonKey() final  String reason;
@override final  String? errorMessage;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusStateCopyWith<_StudentStatusState> get copyWith => __$StudentStatusStateCopyWithImpl<_StudentStatusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatusState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isProcessing, isProcessing) || other.isProcessing == isProcessing)&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._students, _students)&&const DeepCollectionEquality().equals(other._subjects, _subjects)&&(identical(other.selectedAcademyId, selectedAcademyId) || other.selectedAcademyId == selectedAcademyId)&&(identical(other.selectedClassName, selectedClassName) || other.selectedClassName == selectedClassName)&&(identical(other.selectedStudentId, selectedStudentId) || other.selectedStudentId == selectedStudentId)&&(identical(other.selectedStatusType, selectedStatusType) || other.selectedStatusType == selectedStatusType)&&const DeepCollectionEquality().equals(other._selectedSubjectIds, _selectedSubjectIds)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isProcessing,const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_students),const DeepCollectionEquality().hash(_subjects),selectedAcademyId,selectedClassName,selectedStudentId,selectedStatusType,const DeepCollectionEquality().hash(_selectedSubjectIds),reason,errorMessage);

@override
String toString() {
  return 'StudentStatusState(isLoading: $isLoading, isProcessing: $isProcessing, academies: $academies, classes: $classes, students: $students, subjects: $subjects, selectedAcademyId: $selectedAcademyId, selectedClassName: $selectedClassName, selectedStudentId: $selectedStudentId, selectedStatusType: $selectedStatusType, selectedSubjectIds: $selectedSubjectIds, reason: $reason, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusStateCopyWith<$Res> implements $StudentStatusStateCopyWith<$Res> {
  factory _$StudentStatusStateCopyWith(_StudentStatusState value, $Res Function(_StudentStatusState) _then) = __$StudentStatusStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isProcessing, List<Academy> academies, List<AcademyClass> classes, List<AcademyStudent> students, List<Subject> subjects, String? selectedAcademyId, String? selectedClassName, String? selectedStudentId, StudentStatusType? selectedStatusType, List<String> selectedSubjectIds, String reason, String? errorMessage
});




}
/// @nodoc
class __$StudentStatusStateCopyWithImpl<$Res>
    implements _$StudentStatusStateCopyWith<$Res> {
  __$StudentStatusStateCopyWithImpl(this._self, this._then);

  final _StudentStatusState _self;
  final $Res Function(_StudentStatusState) _then;

/// Create a copy of StudentStatusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isProcessing = null,Object? academies = null,Object? classes = null,Object? students = null,Object? subjects = null,Object? selectedAcademyId = freezed,Object? selectedClassName = freezed,Object? selectedStudentId = freezed,Object? selectedStatusType = freezed,Object? selectedSubjectIds = null,Object? reason = null,Object? errorMessage = freezed,}) {
  return _then(_StudentStatusState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isProcessing: null == isProcessing ? _self.isProcessing : isProcessing // ignore: cast_nullable_to_non_nullable
as bool,academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<AcademyStudent>,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademyId: freezed == selectedAcademyId ? _self.selectedAcademyId : selectedAcademyId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassName: freezed == selectedClassName ? _self.selectedClassName : selectedClassName // ignore: cast_nullable_to_non_nullable
as String?,selectedStudentId: freezed == selectedStudentId ? _self.selectedStudentId : selectedStudentId // ignore: cast_nullable_to_non_nullable
as String?,selectedStatusType: freezed == selectedStatusType ? _self.selectedStatusType : selectedStatusType // ignore: cast_nullable_to_non_nullable
as StudentStatusType?,selectedSubjectIds: null == selectedSubjectIds ? _self._selectedSubjectIds : selectedSubjectIds // ignore: cast_nullable_to_non_nullable
as List<String>,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
