part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial({required String phoneNumber}) =
      _Initial;
  const factory AuthenticationState.loading() = AuthenticationLoading;
  const factory AuthenticationState.success() = AuthenticationSuccess;
  const factory AuthenticationState.error() = AuthenticationError;
}
