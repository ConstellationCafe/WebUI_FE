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

 bool get isLoading; List<LessonRecordSummary> get records; DateTime? get selectedDate; String? get selectedTime; String? get selectedSubject; String? get selectedTeacherId; String? get errorMessage;
/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordListStateCopyWith<LessonRecordListState> get copyWith => _$LessonRecordListStateCopyWithImpl<LessonRecordListState>(this as LessonRecordListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.records, records)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.selectedSubject, selectedSubject) || other.selectedSubject == selectedSubject)&&(identical(other.selectedTeacherId, selectedTeacherId) || other.selectedTeacherId == selectedTeacherId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(records),selectedDate,selectedTime,selectedSubject,selectedTeacherId,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, records: $records, selectedDate: $selectedDate, selectedTime: $selectedTime, selectedSubject: $selectedSubject, selectedTeacherId: $selectedTeacherId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $LessonRecordListStateCopyWith<$Res>  {
  factory $LessonRecordListStateCopyWith(LessonRecordListState value, $Res Function(LessonRecordListState) _then) = _$LessonRecordListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<LessonRecordSummary> records, DateTime? selectedDate, String? selectedTime, String? selectedSubject, String? selectedTeacherId, String? errorMessage
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? records = null,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? selectedSubject = freezed,Object? selectedTeacherId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordSummary>,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as String?,selectedSubject: freezed == selectedSubject ? _self.selectedSubject : selectedSubject // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<LessonRecordSummary> records,  DateTime? selectedDate,  String? selectedTime,  String? selectedSubject,  String? selectedTeacherId,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.records,_that.selectedDate,_that.selectedTime,_that.selectedSubject,_that.selectedTeacherId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<LessonRecordSummary> records,  DateTime? selectedDate,  String? selectedTime,  String? selectedSubject,  String? selectedTeacherId,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState():
return $default(_that.isLoading,_that.records,_that.selectedDate,_that.selectedTime,_that.selectedSubject,_that.selectedTeacherId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<LessonRecordSummary> records,  DateTime? selectedDate,  String? selectedTime,  String? selectedSubject,  String? selectedTeacherId,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordListState() when $default != null:
return $default(_that.isLoading,_that.records,_that.selectedDate,_that.selectedTime,_that.selectedSubject,_that.selectedTeacherId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordListState implements LessonRecordListState {
  const _LessonRecordListState({this.isLoading = false, final  List<LessonRecordSummary> records = const [], this.selectedDate, this.selectedTime, this.selectedSubject, this.selectedTeacherId, this.errorMessage}): _records = records;
  

@override@JsonKey() final  bool isLoading;
 final  List<LessonRecordSummary> _records;
@override@JsonKey() List<LessonRecordSummary> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

@override final  DateTime? selectedDate;
@override final  String? selectedTime;
@override final  String? selectedSubject;
@override final  String? selectedTeacherId;
@override final  String? errorMessage;

/// Create a copy of LessonRecordListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordListStateCopyWith<_LessonRecordListState> get copyWith => __$LessonRecordListStateCopyWithImpl<_LessonRecordListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._records, _records)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.selectedSubject, selectedSubject) || other.selectedSubject == selectedSubject)&&(identical(other.selectedTeacherId, selectedTeacherId) || other.selectedTeacherId == selectedTeacherId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_records),selectedDate,selectedTime,selectedSubject,selectedTeacherId,errorMessage);

@override
String toString() {
  return 'LessonRecordListState(isLoading: $isLoading, records: $records, selectedDate: $selectedDate, selectedTime: $selectedTime, selectedSubject: $selectedSubject, selectedTeacherId: $selectedTeacherId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordListStateCopyWith<$Res> implements $LessonRecordListStateCopyWith<$Res> {
  factory _$LessonRecordListStateCopyWith(_LessonRecordListState value, $Res Function(_LessonRecordListState) _then) = __$LessonRecordListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<LessonRecordSummary> records, DateTime? selectedDate, String? selectedTime, String? selectedSubject, String? selectedTeacherId, String? errorMessage
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
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? records = null,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? selectedSubject = freezed,Object? selectedTeacherId = freezed,Object? errorMessage = freezed,}) {
  return _then(_LessonRecordListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordSummary>,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as String?,selectedSubject: freezed == selectedSubject ? _self.selectedSubject : selectedSubject // ignore: cast_nullable_to_non_nullable
as String?,selectedTeacherId: freezed == selectedTeacherId ? _self.selectedTeacherId : selectedTeacherId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
