// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordListState {

 bool get isLoading; bool get isFilterLoading; List<LessonRecordSummary> get records; List<Academy> get academies; List<AcademyClass> get classes; List<Subject> get subjects; String? get selectedAcademyId; String? get selectedClassId; String? get selectedSubjectId; DateTime? get selectedDate; String? get selectedTime; String? get selectedTeacherId; String? get errorMessage;
/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordListStateCopyWith<LessonRecordListState> get copyWith => _$LessonRecordListStateCopyWithImpl<LessonRecordListState>(this as LessonRecordListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&const DeepCollectionEquality().equals(other.records, records)&&const DeepCollectionEquality().equals(other.academies, academies)&&const DeepCollectionEquality().equals(other.classes, classes)&&const DeepCollectionEquality().equals(other.subjects, subjects)&&(identical(other.selectedAcademyId, selectedAcademyId) || other.selectedAcademyId == selectedAcademyId)&&(identical(other.selectedClassId, selectedClassId) || other.selectedClassId == selectedClassId)&&(identical(other.selectedSubjectId, selectedSubjectId) || other.selectedSubjectId == selectedSubjectId)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.selectedTeacherId, selectedTeacherId) || other.selectedTeacherId == selectedTeacherId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,const DeepCollectionEquality().hash(records),const DeepCollectionEquality().hash(academies),const DeepCollectionEquality().hash(classes),const DeepCollectionEquality().hash(subjects),selectedAcademyId,selectedClassId,selectedSubjectId,selectedDate,selectedTime,selectedTeacherId,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, records: $records, academies: $academies, classes: $classes, subjects: $subjects, selectedAcademyId: $selectedAcademyId, selectedClassId: $selectedClassId, selectedSubjectId: $selectedSubjectId, selectedDate: $selectedDate, selectedTime: $selectedTime, selectedTeacherId: $selectedTeacherId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonRecordListStateCopyWith<$Res>  {
  factory $LessonRecordListStateCopyWith(LessonRecordListState value, $Res Function(LessonRecordListState) _then) = _$LessonRecordListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isFilterLoading, List<LessonRecordSummary> records, List<Academy> academies, List<AcademyClass> classes, List<Subject> subjects, String? selectedAcademyId, String? selectedClassId, String? selectedSubjectId, DateTime? selectedDate, String? selectedTime, String? selectedTeacherId, String? errorMessage
});




}
/// @nodoc
class _$LessonRecordListStateCopyWithImpl<$Res>
    implements $LessonRecordListStateCopyWith<$Res> {
  _$LessonRecordListStateCopyWithImpl(this._self, this._then);

  final LessonRecordListState _self;
  final $Res Function(LessonRecordListState) _then;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? records = null,Object? academies = null,Object? classes = null,Object? subjects = null,Object? selectedAcademyId = freezed,Object? selectedClassId = freezed,Object? selectedSubjectId = freezed,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? selectedTeacherId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordSummary>,academies: null == academies ? _self.academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self.classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademyId: freezed == selectedAcademyId ? _self.selectedAcademyId : selectedAcademyId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassId: freezed == selectedClassId ? _self.selectedClassId : selectedClassId // ignore: cast_nullable_to_non_nullable
as String?,selectedSubjectId: freezed == selectedSubjectId ? _self.selectedSubjectId : selectedSubjectId // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as String?,selectedTeacherId: freezed == selectedTeacherId ? _self.selectedTeacherId : selectedTeacherId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonRecordListState].
extension LessonRecordListStatePatterns on LessonRecordListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordListState value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordListState value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  List<LessonRecordSummary> records,  List<Academy> academies,  List<AcademyClass> classes,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassId,  String? selectedSubjectId,  DateTime? selectedDate,  String? selectedTime,  String? selectedTeacherId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.records,_that.academies,_that.classes,_that.subjects,_that.selectedAcademyId,_that.selectedClassId,_that.selectedSubjectId,_that.selectedDate,_that.selectedTime,_that.selectedTeacherId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isFilterLoading,  List<LessonRecordSummary> records,  List<Academy> academies,  List<AcademyClass> classes,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassId,  String? selectedSubjectId,  DateTime? selectedDate,  String? selectedTime,  String? selectedTeacherId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState():
return $default(_that.isLoading,_that.isFilterLoading,_that.records,_that.academies,_that.classes,_that.subjects,_that.selectedAcademyId,_that.selectedClassId,_that.selectedSubjectId,_that.selectedDate,_that.selectedTime,_that.selectedTeacherId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isFilterLoading,  List<LessonRecordSummary> records,  List<Academy> academies,  List<AcademyClass> classes,  List<Subject> subjects,  String? selectedAcademyId,  String? selectedClassId,  String? selectedSubjectId,  DateTime? selectedDate,  String? selectedTime,  String? selectedTeacherId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.isFilterLoading,_that.records,_that.academies,_that.classes,_that.subjects,_that.selectedAcademyId,_that.selectedClassId,_that.selectedSubjectId,_that.selectedDate,_that.selectedTime,_that.selectedTeacherId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordListState implements LessonRecordListState {
  const _LessonRecordListState({this.isLoading = false, this.isFilterLoading = false, final  List<LessonRecordSummary> records = const [], final  List<Academy> academies = const [], final  List<AcademyClass> classes = const [], final  List<Subject> subjects = const [], this.selectedAcademyId, this.selectedClassId, this.selectedSubjectId, this.selectedDate, this.selectedTime, this.selectedTeacherId, this.errorMessage}): _records = records,_academies = academies,_classes = classes,_subjects = subjects;
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isFilterLoading;
 final  List<LessonRecordSummary> _records;
@override@JsonKey() List<LessonRecordSummary> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

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

 final  List<Subject> _subjects;
@override@JsonKey() List<Subject> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}

@override final  String? selectedAcademyId;
@override final  String? selectedClassId;
@override final  String? selectedSubjectId;
@override final  DateTime? selectedDate;
@override final  String? selectedTime;
@override final  String? selectedTeacherId;
@override final  String? errorMessage;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordListStateCopyWith<_LessonRecordListState> get copyWith => __$LessonRecordListStateCopyWithImpl<_LessonRecordListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isFilterLoading, isFilterLoading) || other.isFilterLoading == isFilterLoading)&&const DeepCollectionEquality().equals(other._records, _records)&&const DeepCollectionEquality().equals(other._academies, _academies)&&const DeepCollectionEquality().equals(other._classes, _classes)&&const DeepCollectionEquality().equals(other._subjects, _subjects)&&(identical(other.selectedAcademyId, selectedAcademyId) || other.selectedAcademyId == selectedAcademyId)&&(identical(other.selectedClassId, selectedClassId) || other.selectedClassId == selectedClassId)&&(identical(other.selectedSubjectId, selectedSubjectId) || other.selectedSubjectId == selectedSubjectId)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.selectedTeacherId, selectedTeacherId) || other.selectedTeacherId == selectedTeacherId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isFilterLoading,const DeepCollectionEquality().hash(_records),const DeepCollectionEquality().hash(_academies),const DeepCollectionEquality().hash(_classes),const DeepCollectionEquality().hash(_subjects),selectedAcademyId,selectedClassId,selectedSubjectId,selectedDate,selectedTime,selectedTeacherId,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, isFilterLoading: $isFilterLoading, records: $records, academies: $academies, classes: $classes, subjects: $subjects, selectedAcademyId: $selectedAcademyId, selectedClassId: $selectedClassId, selectedSubjectId: $selectedSubjectId, selectedDate: $selectedDate, selectedTime: $selectedTime, selectedTeacherId: $selectedTeacherId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordListStateCopyWith<$Res> implements $LessonRecordListStateCopyWith<$Res> {
  factory _$LessonRecordListStateCopyWith(_LessonRecordListState value, $Res Function(_LessonRecordListState) _then) = __$LessonRecordListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isFilterLoading, List<LessonRecordSummary> records, List<Academy> academies, List<AcademyClass> classes, List<Subject> subjects, String? selectedAcademyId, String? selectedClassId, String? selectedSubjectId, DateTime? selectedDate, String? selectedTime, String? selectedTeacherId, String? errorMessage
});




}
/// @nodoc
class __$LessonRecordListStateCopyWithImpl<$Res>
    implements _$LessonRecordListStateCopyWith<$Res> {
  __$LessonRecordListStateCopyWithImpl(this._self, this._then);

  final _LessonRecordListState _self;
  final $Res Function(_LessonRecordListState) _then;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isFilterLoading = null,Object? records = null,Object? academies = null,Object? classes = null,Object? subjects = null,Object? selectedAcademyId = freezed,Object? selectedClassId = freezed,Object? selectedSubjectId = freezed,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? selectedTeacherId = freezed,Object? errorMessage = freezed,}) {
  return _then(_LessonRecordListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isFilterLoading: null == isFilterLoading ? _self.isFilterLoading : isFilterLoading // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordSummary>,academies: null == academies ? _self._academies : academies // ignore: cast_nullable_to_non_nullable
as List<Academy>,classes: null == classes ? _self._classes : classes // ignore: cast_nullable_to_non_nullable
as List<AcademyClass>,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<Subject>,selectedAcademyId: freezed == selectedAcademyId ? _self.selectedAcademyId : selectedAcademyId // ignore: cast_nullable_to_non_nullable
as String?,selectedClassId: freezed == selectedClassId ? _self.selectedClassId : selectedClassId // ignore: cast_nullable_to_non_nullable
as String?,selectedSubjectId: freezed == selectedSubjectId ? _self.selectedSubjectId : selectedSubjectId // ignore: cast_nullable_to_non_nullable
as String?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as String?,selectedTeacherId: freezed == selectedTeacherId ? _self.selectedTeacherId : selectedTeacherId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
