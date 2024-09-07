part of 'welcome_user_bloc.dart';

class WelcomeUserState {
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? countryCode;
  final String? phoneNumber;
  final FormSubmissionStatus formStatus;

  WelcomeUserState({
    this.firstName,
    this.lastName,
    this.gender,
    this.countryCode,
    this.phoneNumber,
    this.formStatus = const FormInitialStatus(),
  });

  WelcomeUserState copyWith(
      {String? firstName,
      String? lastName,
      String? gender,
      String? countryCode,
      String? phoneNumber,
      FormSubmissionStatus? formStatus}) {
    return WelcomeUserState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
