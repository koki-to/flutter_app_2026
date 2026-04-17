// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_gate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthGateState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthGateState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthGateState()';
  }
}

/// @nodoc
class $AuthGateStateCopyWith<$Res> {
  $AuthGateStateCopyWith(AuthGateState _, $Res Function(AuthGateState) __);
}

/// Adds pattern-matching-related methods to [AuthGateState].
extension AuthGateStatePatterns on AuthGateState {
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
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthGateStateUnKnown value)? unknown,
    TResult Function(AuthGateStateAuthenticated value)? authenticated,
    TResult Function(AuthGateStateUnAuthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown() when unknown != null:
        return unknown(_that);
      case AuthGateStateAuthenticated() when authenticated != null:
        return authenticated(_that);
      case AuthGateStateUnAuthenticated() when unauthenticated != null:
        return unauthenticated(_that);
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
  TResult map<TResult extends Object?>({
    required TResult Function(AuthGateStateUnKnown value) unknown,
    required TResult Function(AuthGateStateAuthenticated value) authenticated,
    required TResult Function(AuthGateStateUnAuthenticated value)
        unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown():
        return unknown(_that);
      case AuthGateStateAuthenticated():
        return authenticated(_that);
      case AuthGateStateUnAuthenticated():
        return unauthenticated(_that);
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
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthGateStateUnKnown value)? unknown,
    TResult? Function(AuthGateStateAuthenticated value)? authenticated,
    TResult? Function(AuthGateStateUnAuthenticated value)? unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown() when unknown != null:
        return unknown(_that);
      case AuthGateStateAuthenticated() when authenticated != null:
        return authenticated(_that);
      case AuthGateStateUnAuthenticated() when unauthenticated != null:
        return unauthenticated(_that);
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
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(User firebaseUser, UserProfile? profile)? authenticated,
    TResult Function()? unauthenticated,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown() when unknown != null:
        return unknown();
      case AuthGateStateAuthenticated() when authenticated != null:
        return authenticated(_that.firebaseUser, _that.profile);
      case AuthGateStateUnAuthenticated() when unauthenticated != null:
        return unauthenticated();
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
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(User firebaseUser, UserProfile? profile)
        authenticated,
    required TResult Function() unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown():
        return unknown();
      case AuthGateStateAuthenticated():
        return authenticated(_that.firebaseUser, _that.profile);
      case AuthGateStateUnAuthenticated():
        return unauthenticated();
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
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unknown,
    TResult? Function(User firebaseUser, UserProfile? profile)? authenticated,
    TResult? Function()? unauthenticated,
  }) {
    final _that = this;
    switch (_that) {
      case AuthGateStateUnKnown() when unknown != null:
        return unknown();
      case AuthGateStateAuthenticated() when authenticated != null:
        return authenticated(_that.firebaseUser, _that.profile);
      case AuthGateStateUnAuthenticated() when unauthenticated != null:
        return unauthenticated();
      case _:
        return null;
    }
  }
}

/// @nodoc

class AuthGateStateUnKnown implements AuthGateState {
  const AuthGateStateUnKnown();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthGateStateUnKnown);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthGateState.unknown()';
  }
}

/// @nodoc

class AuthGateStateAuthenticated implements AuthGateState {
  const AuthGateStateAuthenticated({required this.firebaseUser, this.profile});

  final User firebaseUser;
  final UserProfile? profile;

  /// Create a copy of AuthGateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthGateStateAuthenticatedCopyWith<AuthGateStateAuthenticated>
      get copyWith =>
          _$AuthGateStateAuthenticatedCopyWithImpl<AuthGateStateAuthenticated>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthGateStateAuthenticated &&
            (identical(other.firebaseUser, firebaseUser) ||
                other.firebaseUser == firebaseUser) &&
            (identical(other.profile, profile) || other.profile == profile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, firebaseUser, profile);

  @override
  String toString() {
    return 'AuthGateState.authenticated(firebaseUser: $firebaseUser, profile: $profile)';
  }
}

/// @nodoc
abstract mixin class $AuthGateStateAuthenticatedCopyWith<$Res>
    implements $AuthGateStateCopyWith<$Res> {
  factory $AuthGateStateAuthenticatedCopyWith(AuthGateStateAuthenticated value,
          $Res Function(AuthGateStateAuthenticated) _then) =
      _$AuthGateStateAuthenticatedCopyWithImpl;
  @useResult
  $Res call({User firebaseUser, UserProfile? profile});

  $UserProfileCopyWith<$Res>? get profile;
}

/// @nodoc
class _$AuthGateStateAuthenticatedCopyWithImpl<$Res>
    implements $AuthGateStateAuthenticatedCopyWith<$Res> {
  _$AuthGateStateAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthGateStateAuthenticated _self;
  final $Res Function(AuthGateStateAuthenticated) _then;

  /// Create a copy of AuthGateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? firebaseUser = null,
    Object? profile = freezed,
  }) {
    return _then(AuthGateStateAuthenticated(
      firebaseUser: null == firebaseUser
          ? _self.firebaseUser
          : firebaseUser // ignore: cast_nullable_to_non_nullable
              as User,
      profile: freezed == profile
          ? _self.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as UserProfile?,
    ));
  }

  /// Create a copy of AuthGateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
      return null;
    }

    return $UserProfileCopyWith<$Res>(_self.profile!, (value) {
      return _then(_self.copyWith(profile: value));
    });
  }
}

/// @nodoc

class AuthGateStateUnAuthenticated implements AuthGateState {
  const AuthGateStateUnAuthenticated();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthGateStateUnAuthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthGateState.unauthenticated()';
  }
}

// dart format on
