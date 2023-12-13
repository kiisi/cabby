part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.setPhoneNumber(String updatedPhoneNumber) =
      _SetPhoneNumber;
  const factory AuthenticationEvent.processButtonPressed() =
      _ProcessButtonPressed;
}
