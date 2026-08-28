// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_status_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherStatusList {

 List<StatusView> get items; int get totalCount; int get enrolledCount; int get retirementCount; int get disciplinaryCount; int get currentPage; int get totalPages;
/// Create a copy of TeacherStatusList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherStatusListCopyWith<TeacherStatusList> get copyWith => _$TeacherStatusListCopyWithImpl<TeacherStatusList>(this as TeacherStatusList, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherStatusList&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.enrolledCount, enrolledCount) || other.enrolledCount == enrolledCount)&&(identical(other.retirementCount, retirementCount) || other.retirementCount == retirementCount)&&(identical(other.disciplinaryCount, disciplinaryCount) || other.disciplinaryCount == disciplinaryCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,enrolledCount,retirementCount,disciplinaryCount,currentPage,totalPages);

@override
String toString() {
  return 'TeacherStatusList(items: $items, totalCount: $totalCount, enrolledCount: $enrolledCount, retirementCount: $retirementCount, disciplinaryCount: $disciplinaryCount, currentPage: $currentPage, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class $TeacherStatusListCopyWith<$Res>  {
  factory $TeacherStatusListCopyWith(TeacherStatusList value, $Res Function(TeacherStatusList) _then) = _$TeacherStatusListCopyWithImpl;
@useResult
$Res call({
 List<StatusView> items, int totalCount, int enrolledCount, int retirementCount, int disciplinaryCount, int currentPage, int totalPages
});




}
/// @nodoc
class _$TeacherStatusListCopyWithImpl<$Res>
    implements $TeacherStatusListCopyWith<$Res> {
  _$TeacherStatusListCopyWithImpl(this._self, this._then);

  final TeacherStatusList _self;
  final $Res Function(TeacherStatusList) _then;

/// Create a copy of TeacherStatusList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? enrolledCount = null,Object? retirementCount = null,Object? disciplinaryCount = null,Object? currentPage = null,Object? totalPages = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<StatusView>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,enrolledCount: null == enrolledCount ? _self.enrolledCount : enrolledCount // ignore: cast_nullable_to_non_nullable
as int,retirementCount: null == retirementCount ? _self.retirementCount : retirementCount // ignore: cast_nullable_to_non_nullable
as int,disciplinaryCount: null == disciplinaryCount ? _self.disciplinaryCount : disciplinaryCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TeacherStatusList].
extension TeacherStatusListPatterns on TeacherStatusList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherStatusList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherStatusList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherStatusList value)  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherStatusList value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherStatusList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StatusView> items,  int totalCount,  int enrolledCount,  int retirementCount,  int disciplinaryCount,  int currentPage,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherStatusList() when $default != null:
return $default(_that.items,_that.totalCount,_that.enrolledCount,_that.retirementCount,_that.disciplinaryCount,_that.currentPage,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StatusView> items,  int totalCount,  int enrolledCount,  int retirementCount,  int disciplinaryCount,  int currentPage,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusList():
return $default(_that.items,_that.totalCount,_that.enrolledCount,_that.retirementCount,_that.disciplinaryCount,_that.currentPage,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StatusView> items,  int totalCount,  int enrolledCount,  int retirementCount,  int disciplinaryCount,  int currentPage,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _TeacherStatusList() when $default != null:
return $default(_that.items,_that.totalCount,_that.enrolledCount,_that.retirementCount,_that.disciplinaryCount,_that.currentPage,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherStatusList implements TeacherStatusList {
  const _TeacherStatusList({final  List<StatusView> items = const [], this.totalCount = 0, this.enrolledCount = 0, this.retirementCount = 0, this.disciplinaryCount = 0, this.currentPage = 1, this.totalPages = 1}): _items = items;
  

 final  List<StatusView> _items;
@override@JsonKey() List<StatusView> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int enrolledCount;
@override@JsonKey() final  int retirementCount;
@override@JsonKey() final  int disciplinaryCount;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalPages;

/// Create a copy of TeacherStatusList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherStatusListCopyWith<_TeacherStatusList> get copyWith => __$TeacherStatusListCopyWithImpl<_TeacherStatusList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherStatusList&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.enrolledCount, enrolledCount) || other.enrolledCount == enrolledCount)&&(identical(other.retirementCount, retirementCount) || other.retirementCount == retirementCount)&&(identical(other.disciplinaryCount, disciplinaryCount) || other.disciplinaryCount == disciplinaryCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,enrolledCount,retirementCount,disciplinaryCount,currentPage,totalPages);

@override
String toString() {
  return 'TeacherStatusList(items: $items, totalCount: $totalCount, enrolledCount: $enrolledCount, retirementCount: $retirementCount, disciplinaryCount: $disciplinaryCount, currentPage: $currentPage, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$TeacherStatusListCopyWith<$Res> implements $TeacherStatusListCopyWith<$Res> {
  factory _$TeacherStatusListCopyWith(_TeacherStatusList value, $Res Function(_TeacherStatusList) _then) = __$TeacherStatusListCopyWithImpl;
@override @useResult
$Res call({
 List<StatusView> items, int totalCount, int enrolledCount, int retirementCount, int disciplinaryCount, int currentPage, int totalPages
});




}
/// @nodoc
class __$TeacherStatusListCopyWithImpl<$Res>
    implements _$TeacherStatusListCopyWith<$Res> {
  __$TeacherStatusListCopyWithImpl(this._self, this._then);

  final _TeacherStatusList _self;
  final $Res Function(_TeacherStatusList) _then;

/// Create a copy of TeacherStatusList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? enrolledCount = null,Object? retirementCount = null,Object? disciplinaryCount = null,Object? currentPage = null,Object? totalPages = null,}) {
  return _then(_TeacherStatusList(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<StatusView>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,enrolledCount: null == enrolledCount ? _self.enrolledCount : enrolledCount // ignore: cast_nullable_to_non_nullable
as int,retirementCount: null == retirementCount ? _self.retirementCount : retirementCount // ignore: cast_nullable_to_non_nullable
as int,disciplinaryCount: null == disciplinaryCount ? _self.disciplinaryCount : disciplinaryCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
