// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthenticationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String updatedPhoneNumber) setPhoneNumber,
    required TResult Function() processButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult? Function()? processButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult Function()? processButtonPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetPhoneNumber value) setPhoneNumber,
    required TResult Function(_ProcessButtonPressed value) processButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult? Function(_ProcessButtonPressed value)? processButtonPressed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult Function(_ProcessButtonPressed value)? processButtonPressed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationEventCopyWith<$Res> {
  factory $AuthenticationEventCopyWith(
          AuthenticationEvent value, $Res Function(AuthenticationEvent) then) =
      _$AuthenticationEventCopyWithImpl<$Res, AuthenticationEvent>;
}

/// @nodoc
class _$AuthenticationEventCopyWithImpl<$Res, $Val extends AuthenticationEvent>
    implements $AuthenticationEventCopyWith<$Res> {
  _$AuthenticationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SetPhoneNumberImplCopyWith<$Res> {
  factory _$$SetPhoneNumberImplCopyWith(_$SetPhoneNumberImpl value,
          $Res Function(_$SetPhoneNumberImpl) then) =
      __$$SetPhoneNumberImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String updatedPhoneNumber});
}

/// @nodoc
class __$$SetPhoneNumberImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res, _$SetPhoneNumberImpl>
    implements _$$SetPhoneNumberImplCopyWith<$Res> {
  __$$SetPhoneNumberImplCopyWithImpl(
      _$SetPhoneNumberImpl _value, $Res Function(_$SetPhoneNumberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updatedPhoneNumber = null,
  }) {
    return _then(_$SetPhoneNumberImpl(
      null == updatedPhoneNumber
          ? _value.updatedPhoneNumber
          : updatedPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetPhoneNumberImpl implements _SetPhoneNumber {
  const _$SetPhoneNumberImpl(this.updatedPhoneNumber);

  @override
  final String updatedPhoneNumber;

  @override
  String toString() {
    return 'AuthenticationEvent.setPhoneNumber(updatedPhoneNumber: $updatedPhoneNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetPhoneNumberImpl &&
            (identical(other.updatedPhoneNumber, updatedPhoneNumber) ||
                other.updatedPhoneNumber == updatedPhoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, updatedPhoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetPhoneNumberImplCopyWith<_$SetPhoneNumberImpl> get copyWith =>
      __$$SetPhoneNumberImplCopyWithImpl<_$SetPhoneNumberImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String updatedPhoneNumber) setPhoneNumber,
    required TResult Function() processButtonPressed,
  }) {
    return setPhoneNumber(updatedPhoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult? Function()? processButtonPressed,
  }) {
    return setPhoneNumber?.call(updatedPhoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult Function()? processButtonPressed,
    required TResult orElse(),
  }) {
    if (setPhoneNumber != null) {
      return setPhoneNumber(updatedPhoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetPhoneNumber value) setPhoneNumber,
    required TResult Function(_ProcessButtonPressed value) processButtonPressed,
  }) {
    return setPhoneNumber(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult? Function(_ProcessButtonPressed value)? processButtonPressed,
  }) {
    return setPhoneNumber?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult Function(_ProcessButtonPressed value)? processButtonPressed,
    required TResult orElse(),
  }) {
    if (setPhoneNumber != null) {
      return setPhoneNumber(this);
    }
    return orElse();
  }
}

abstract class _SetPhoneNumber implements AuthenticationEvent {
  const factory _SetPhoneNumber(final String updatedPhoneNumber) =
      _$SetPhoneNumberImpl;

  String get updatedPhoneNumber;
  @JsonKey(ignore: true)
  _$$SetPhoneNumberImplCopyWith<_$SetPhoneNumberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessButtonPressedImplCopyWith<$Res> {
  factory _$$ProcessButtonPressedImplCopyWith(_$ProcessButtonPressedImpl value,
          $Res Function(_$ProcessButtonPressedImpl) then) =
      __$$ProcessButtonPressedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProcessButtonPressedImplCopyWithImpl<$Res>
    extends _$AuthenticationEventCopyWithImpl<$Res, _$ProcessButtonPressedImpl>
    implements _$$ProcessButtonPressedImplCopyWith<$Res> {
  __$$ProcessButtonPressedImplCopyWithImpl(_$ProcessButtonPressedImpl _value,
      $Res Function(_$ProcessButtonPressedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProcessButtonPressedImpl implements _ProcessButtonPressed {
  const _$ProcessButtonPressedImpl();

  @override
  String toString() {
    return 'AuthenticationEvent.processButtonPressed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessButtonPressedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String updatedPhoneNumber) setPhoneNumber,
    required TResult Function() processButtonPressed,
  }) {
    return processButtonPressed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult? Function()? processButtonPressed,
  }) {
    return processButtonPressed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String updatedPhoneNumber)? setPhoneNumber,
    TResult Function()? processButtonPressed,
    required TResult orElse(),
  }) {
    if (processButtonPressed != null) {
      return processButtonPressed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetPhoneNumber value) setPhoneNumber,
    required TResult Function(_ProcessButtonPressed value) processButtonPressed,
  }) {
    return processButtonPressed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult? Function(_ProcessButtonPressed value)? processButtonPressed,
  }) {
    return processButtonPressed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetPhoneNumber value)? setPhoneNumber,
    TResult Function(_ProcessButtonPressed value)? processButtonPressed,
    required TResult orElse(),
  }) {
    if (processButtonPressed != null) {
      return processButtonPressed(this);
    }
    return orElse();
  }
}

abstract class _ProcessButtonPressed implements AuthenticationEvent {
  const factory _ProcessButtonPressed() = _$ProcessButtonPressedImpl;
}

/// @nodoc
mixin _$AuthenticationState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationSuccess value) success,
    required TResult Function(AuthenticationError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationSuccess value)? success,
    TResult? Function(AuthenticationError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationSuccess value)? success,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationStateCopyWith(
          AuthenticationState value, $Res Function(AuthenticationState) then) =
      _$AuthenticationStateCopyWithImpl<$Res, AuthenticationState>;
}

/// @nodoc
class _$AuthenticationStateCopyWithImpl<$Res, $Val extends AuthenticationState>
    implements $AuthenticationStateCopyWith<$Res> {
  _$AuthenticationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$InitialImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'AuthenticationState.initial(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return initial(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? error,
  }) {
    return initial?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationSuccess value) success,
    required TResult Function(AuthenticationError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationSuccess value)? success,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationSuccess value)? success,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements AuthenticationState {
  const factory _Initial({required final String phoneNumber}) = _$InitialImpl;

  String get phoneNumber;
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationLoadingImplCopyWith<$Res> {
  factory _$$AuthenticationLoadingImplCopyWith(
          _$AuthenticationLoadingImpl value,
          $Res Function(_$AuthenticationLoadingImpl) then) =
      __$$AuthenticationLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationLoadingImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationLoadingImpl>
    implements _$$AuthenticationLoadingImplCopyWith<$Res> {
  __$$AuthenticationLoadingImplCopyWithImpl(_$AuthenticationLoadingImpl _value,
      $Res Function(_$AuthenticationLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationLoadingImpl implements AuthenticationLoading {
  const _$AuthenticationLoadingImpl();

  @override
  String toString() {
    return 'AuthenticationState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationSuccess value) success,
    required TResult Function(AuthenticationError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationSuccess value)? success,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationSuccess value)? success,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthenticationLoading implements AuthenticationState {
  const factory AuthenticationLoading() = _$AuthenticationLoadingImpl;
}

/// @nodoc
abstract class _$$AuthenticationSuccessImplCopyWith<$Res> {
  factory _$$AuthenticationSuccessImplCopyWith(
          _$AuthenticationSuccessImpl value,
          $Res Function(_$AuthenticationSuccessImpl) then) =
      __$$AuthenticationSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationSuccessImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationSuccessImpl>
    implements _$$AuthenticationSuccessImplCopyWith<$Res> {
  __$$AuthenticationSuccessImplCopyWithImpl(_$AuthenticationSuccessImpl _value,
      $Res Function(_$AuthenticationSuccessImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationSuccessImpl implements AuthenticationSuccess {
  const _$AuthenticationSuccessImpl();

  @override
  String toString() {
    return 'AuthenticationState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationSuccess value) success,
    required TResult Function(AuthenticationError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationSuccess value)? success,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationSuccess value)? success,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AuthenticationSuccess implements AuthenticationState {
  const factory AuthenticationSuccess() = _$AuthenticationSuccessImpl;
}

/// @nodoc
abstract class _$$AuthenticationErrorImplCopyWith<$Res> {
  factory _$$AuthenticationErrorImplCopyWith(_$AuthenticationErrorImpl value,
          $Res Function(_$AuthenticationErrorImpl) then) =
      __$$AuthenticationErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthenticationErrorImplCopyWithImpl<$Res>
    extends _$AuthenticationStateCopyWithImpl<$Res, _$AuthenticationErrorImpl>
    implements _$$AuthenticationErrorImplCopyWith<$Res> {
  __$$AuthenticationErrorImplCopyWithImpl(_$AuthenticationErrorImpl _value,
      $Res Function(_$AuthenticationErrorImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AuthenticationErrorImpl implements AuthenticationError {
  const _$AuthenticationErrorImpl();

  @override
  String toString() {
    return 'AuthenticationState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(AuthenticationLoading value) loading,
    required TResult Function(AuthenticationSuccess value) success,
    required TResult Function(AuthenticationError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(AuthenticationLoading value)? loading,
    TResult? Function(AuthenticationSuccess value)? success,
    TResult? Function(AuthenticationError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(AuthenticationLoading value)? loading,
    TResult Function(AuthenticationSuccess value)? success,
    TResult Function(AuthenticationError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthenticationError implements AuthenticationState {
  const factory AuthenticationError() = _$AuthenticationErrorImpl;
}
