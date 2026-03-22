// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'global_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlobalState {
  @JsonKey(name: 'discordId')
  String get userId;
  String get globalName;
  List<String> get roles;
  @JsonKey(name: 'avatar')
  String get avatarUrl;

  /// Create a copy of GlobalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GlobalStateCopyWith<GlobalState> get copyWith =>
      _$GlobalStateCopyWithImpl<GlobalState>(this as GlobalState, _$identity);

  /// Serializes this GlobalState to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GlobalState &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.globalName, globalName) ||
                other.globalName == globalName) &&
            const DeepCollectionEquality().equals(other.roles, roles) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, globalName,
      const DeepCollectionEquality().hash(roles), avatarUrl);

  @override
  String toString() {
    return 'GlobalState(userId: $userId, globalName: $globalName, roles: $roles, avatarUrl: $avatarUrl)';
  }
}

/// @nodoc
abstract mixin class $GlobalStateCopyWith<$Res> {
  factory $GlobalStateCopyWith(
          GlobalState value, $Res Function(GlobalState) _then) =
      _$GlobalStateCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'discordId') String userId,
      String globalName,
      List<String> roles,
      @JsonKey(name: 'avatar') String avatarUrl});
}

/// @nodoc
class _$GlobalStateCopyWithImpl<$Res> implements $GlobalStateCopyWith<$Res> {
  _$GlobalStateCopyWithImpl(this._self, this._then);

  final GlobalState _self;
  final $Res Function(GlobalState) _then;

  /// Create a copy of GlobalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? globalName = null,
    Object? roles = null,
    Object? avatarUrl = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      globalName: null == globalName
          ? _self.globalName
          : globalName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _self.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: null == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [GlobalState].
extension GlobalStatePatterns on GlobalState {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GlobalState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GlobalState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GlobalState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GlobalState():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GlobalState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GlobalState() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'discordId') String userId,
            String globalName,
            List<String> roles,
            @JsonKey(name: 'avatar') String avatarUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GlobalState() when $default != null:
        return $default(
            _that.userId, _that.globalName, _that.roles, _that.avatarUrl);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'discordId') String userId,
            String globalName,
            List<String> roles,
            @JsonKey(name: 'avatar') String avatarUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GlobalState():
        return $default(
            _that.userId, _that.globalName, _that.roles, _that.avatarUrl);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'discordId') String userId,
            String globalName,
            List<String> roles,
            @JsonKey(name: 'avatar') String avatarUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GlobalState() when $default != null:
        return $default(
            _that.userId, _that.globalName, _that.roles, _that.avatarUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GlobalState implements GlobalState {
  const _GlobalState(
      {@JsonKey(name: 'discordId') required this.userId,
      required this.globalName,
      required final List<String> roles,
      @JsonKey(name: 'avatar') required this.avatarUrl})
      : _roles = roles;
  factory _GlobalState.fromJson(Map<String, dynamic> json) =>
      _$GlobalStateFromJson(json);

  @override
  @JsonKey(name: 'discordId')
  final String userId;
  @override
  final String globalName;
  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  @JsonKey(name: 'avatar')
  final String avatarUrl;

  /// Create a copy of GlobalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GlobalStateCopyWith<_GlobalState> get copyWith =>
      __$GlobalStateCopyWithImpl<_GlobalState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GlobalStateToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GlobalState &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.globalName, globalName) ||
                other.globalName == globalName) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, globalName,
      const DeepCollectionEquality().hash(_roles), avatarUrl);

  @override
  String toString() {
    return 'GlobalState(userId: $userId, globalName: $globalName, roles: $roles, avatarUrl: $avatarUrl)';
  }
}

/// @nodoc
abstract mixin class _$GlobalStateCopyWith<$Res>
    implements $GlobalStateCopyWith<$Res> {
  factory _$GlobalStateCopyWith(
          _GlobalState value, $Res Function(_GlobalState) _then) =
      __$GlobalStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'discordId') String userId,
      String globalName,
      List<String> roles,
      @JsonKey(name: 'avatar') String avatarUrl});
}

/// @nodoc
class __$GlobalStateCopyWithImpl<$Res> implements _$GlobalStateCopyWith<$Res> {
  __$GlobalStateCopyWithImpl(this._self, this._then);

  final _GlobalState _self;
  final $Res Function(_GlobalState) _then;

  /// Create a copy of GlobalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? globalName = null,
    Object? roles = null,
    Object? avatarUrl = null,
  }) {
    return _then(_GlobalState(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      globalName: null == globalName
          ? _self.globalName
          : globalName // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _self._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: null == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
