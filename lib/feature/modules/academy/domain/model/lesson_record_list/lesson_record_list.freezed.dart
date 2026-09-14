// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_record_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LessonRecordList {

 List<LessonRecordView> get records;
/// Create a copy of LessonRecordList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonRecordListCopyWith<LessonRecordList> get copyWith => _$LessonRecordListCopyWithImpl<LessonRecordList>(this as LessonRecordList, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonRecordList&&const DeepCollectionEquality().equals(other.records, records));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(records));

@override
String toString() {
  return 'LessonRecordList(records: $records)';
}


}

/// @nodoc
abstract mixin class $LessonRecordListCopyWith<$Res>  {
  factory $LessonRecordListCopyWith(LessonRecordList value, $Res Function(LessonRecordList) _then) = _$LessonRecordListCopyWithImpl;
@useResult
$Res call({
 List<LessonRecordView> records
});




}
/// @nodoc
class _$LessonRecordListCopyWithImpl<$Res>
    implements $LessonRecordListCopyWith<$Res> {
  _$LessonRecordListCopyWithImpl(this._self, this._then);

  final LessonRecordList _self;
  final $Res Function(LessonRecordList) _then;

/// Create a copy of LessonRecordList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? records = null,}) {
  return _then(_self.copyWith(
records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordView>,
  ));
}

}


/// Adds pattern-matching-related methods to [LessonRecordList].
extension LessonRecordListPatterns on LessonRecordList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LessonRecordList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LessonRecordList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LessonRecordList value)  $default,){
final _that = this;
switch (_that) {
case _LessonRecordList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LessonRecordList value)?  $default,){
final _that = this;
switch (_that) {
case _LessonRecordList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<LessonRecordView> records)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LessonRecordList() when $default != null:
return $default(_that.records);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<LessonRecordView> records)  $default,) {final _that = this;
switch (_that) {
case _LessonRecordList():
return $default(_that.records);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<LessonRecordView> records)?  $default,) {final _that = this;
switch (_that) {
case _LessonRecordList() when $default != null:
return $default(_that.records);case _:
  return null;

}
}

}

/// @nodoc


class _LessonRecordList implements LessonRecordList {
  const _LessonRecordList({final  List<LessonRecordView> records = const []}): _records = records;
  

 final  List<LessonRecordView> _records;
@override@JsonKey() List<LessonRecordView> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}


/// Create a copy of LessonRecordList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LessonRecordListCopyWith<_LessonRecordList> get copyWith => __$LessonRecordListCopyWithImpl<_LessonRecordList>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LessonRecordList&&const DeepCollectionEquality().equals(other._records, _records));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records));

@override
String toString() {
  return 'LessonRecordList(records: $records)';
}


}

/// @nodoc
abstract mixin class _$LessonRecordListCopyWith<$Res> implements $LessonRecordListCopyWith<$Res> {
  factory _$LessonRecordListCopyWith(_LessonRecordList value, $Res Function(_LessonRecordList) _then) = __$LessonRecordListCopyWithImpl;
@override @useResult
$Res call({
 List<LessonRecordView> records
});




}
/// @nodoc
class __$LessonRecordListCopyWithImpl<$Res>
    implements _$LessonRecordListCopyWith<$Res> {
  __$LessonRecordListCopyWithImpl(this._self, this._then);

  final _LessonRecordList _self;
  final $Res Function(_LessonRecordList) _then;

/// Create a copy of LessonRecordList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? records = null,}) {
  return _then(_LessonRecordList(
records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<LessonRecordView>,
  ));
}


}

// dart format on
