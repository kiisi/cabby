part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationSetPhoneNumber extends AuthenticationEvent {
  final String? phoneNumber;
  AuthenticationSetPhoneNumber({required this.phoneNumber});
}

class AuthenticationSetEmail extends AuthenticationEvent {
  final String? email;
  AuthenticationSetEmail({required this.email});
}

class AuthenticationSetCountryCode extends AuthenticationEvent {
  final String countryCode;
  AuthenticationSetCountryCode({required this.countryCode});
}

class AuthenticationSubmission extends AuthenticationEvent {}
