// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_status_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentStatusView {

 Student get student; Academy get academy; AcademyClass get academyClass; StudentRosterStatus get status; DateTime? get changedAt; String? get reason;
/// Create a copy of StudentStatusView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentStatusViewCopyWith<StudentStatusView> get copyWith => _$StudentStatusViewCopyWithImpl<StudentStatusView>(this as StudentStatusView, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentStatusView&&(identical(other.student, student) || other.student == student)&&(identical(other.academy, academy) || other.academy == academy)&&(identical(other.academyClass, academyClass) || other.academyClass == academyClass)&&(identical(other.status, status) || other.status == status)&&(identical(other.changedAt, changedAt) || other.changedAt == changedAt)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,student,academy,academyClass,status,changedAt,reason);

@override
String toString() {
  return 'StudentStatusView(student: $student, academy: $academy, academyClass: $academyClass, status: $status, changedAt: $changedAt, reason: $reason)';
}


}

/// @nodoc
abstract mixin class $StudentStatusViewCopyWith<$Res>  {
  factory $StudentStatusViewCopyWith(StudentStatusView value, $Res Function(StudentStatusView) _then) = _$StudentStatusViewCopyWithImpl;
@useResult
$Res call({
 Student student, Academy academy, AcademyClass academyClass, StudentRosterStatus status, DateTime? changedAt, String? reason
});




}
/// @nodoc
class _$StudentStatusViewCopyWithImpl<$Res>
    implements $StudentStatusViewCopyWith<$Res> {
  _$StudentStatusViewCopyWithImpl(this._self, this._then);

  final StudentStatusView _self;
  final $Res Function(StudentStatusView) _then;

/// Create a copy of StudentStatusView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? student = null,Object? academy = null,Object? academyClass = null,Object? status = null,Object? changedAt = freezed,Object? reason = freezed,}) {
  return _then(_self.copyWith(
student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as Student,academy: null == academy ? _self.academy : academy // ignore: cast_nullable_to_non_nullable
as Academy,academyClass: null == academyClass ? _self.academyClass : academyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudentRosterStatus,changedAt: freezed == changedAt ? _self.changedAt : changedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentStatusView].
extension StudentStatusViewPatterns on StudentStatusView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentStatusView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentStatusView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentStatusView value)  $default,){
final _that = this;
switch (_that) {
case _StudentStatusView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentStatusView value)?  $default,){
final _that = this;
switch (_that) {
case _StudentStatusView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Student student,  Academy academy,  AcademyClass academyClass,  StudentRosterStatus status,  DateTime? changedAt,  String? reason)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentStatusView() when $default != null:
return $default(_that.student,_that.academy,_that.academyClass,_that.status,_that.changedAt,_that.reason);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Student student,  Academy academy,  AcademyClass academyClass,  StudentRosterStatus status,  DateTime? changedAt,  String? reason)  $default,) {final _that = this;
switch (_that) {
case _StudentStatusView():
return $default(_that.student,_that.academy,_that.academyClass,_that.status,_that.changedAt,_that.reason);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Student student,  Academy academy,  AcademyClass academyClass,  StudentRosterStatus status,  DateTime? changedAt,  String? reason)?  $default,) {final _that = this;
switch (_that) {
case _StudentStatusView() when $default != null:
return $default(_that.student,_that.academy,_that.academyClass,_that.status,_that.changedAt,_that.reason);case _:
  return null;

}
}

}

/// @nodoc


class _StudentStatusView implements StudentStatusView {
  const _StudentStatusView({required this.student, required this.academy, required this.academyClass, required this.status, this.changedAt, this.reason});
  

@override final  Student student;
@override final  Academy academy;
@override final  AcademyClass academyClass;
@override final  StudentRosterStatus status;
@override final  DateTime? changedAt;
@override final  String? reason;

/// Create a copy of StudentStatusView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentStatusViewCopyWith<_StudentStatusView> get copyWith => __$StudentStatusViewCopyWithImpl<_StudentStatusView>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentStatusView&&(identical(other.student, student) || other.student == student)&&(identical(other.academy, academy) || other.academy == academy)&&(identical(other.academyClass, academyClass) || other.academyClass == academyClass)&&(identical(other.status, status) || other.status == status)&&(identical(other.changedAt, changedAt) || other.changedAt == changedAt)&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,student,academy,academyClass,status,changedAt,reason);

@override
String toString() {
  return 'StudentStatusView(student: $student, academy: $academy, academyClass: $academyClass, status: $status, changedAt: $changedAt, reason: $reason)';
}


}

/// @nodoc
abstract mixin class _$StudentStatusViewCopyWith<$Res> implements $StudentStatusViewCopyWith<$Res> {
  factory _$StudentStatusViewCopyWith(_StudentStatusView value, $Res Function(_StudentStatusView) _then) = __$StudentStatusViewCopyWithImpl;
@override @useResult
$Res call({
 Student student, Academy academy, AcademyClass academyClass, StudentRosterStatus status, DateTime? changedAt, String? reason
});




}
/// @nodoc
class __$StudentStatusViewCopyWithImpl<$Res>
    implements _$StudentStatusViewCopyWith<$Res> {
  __$StudentStatusViewCopyWithImpl(this._self, this._then);

  final _StudentStatusView _self;
  final $Res Function(_StudentStatusView) _then;

/// Create a copy of StudentStatusView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? student = null,Object? academy = null,Object? academyClass = null,Object? status = null,Object? changedAt = freezed,Object? reason = freezed,}) {
  return _then(_StudentStatusView(
student: null == student ? _self.student : student // ignore: cast_nullable_to_non_nullable
as Student,academy: null == academy ? _self.academy : academy // ignore: cast_nullable_to_non_nullable
as Academy,academyClass: null == academyClass ? _self.academyClass : academyClass // ignore: cast_nullable_to_non_nullable
as AcademyClass,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudentRosterStatus,changedAt: freezed == changedAt ? _self.changedAt : changedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
