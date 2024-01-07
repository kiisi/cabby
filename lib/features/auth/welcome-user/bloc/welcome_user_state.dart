part of 'welcome_user_bloc.dart';

class WelcomeUserState {
  final String? firstName;
  final String? lastName;
  final String? gender;
  final FormSubmissionStatus formStatus;

  String? get firstNameErrorText =>
      firstName != null && firstName!.isEmpty ? "First name is required" : null;

  String? get lastNameErrorText =>
      lastName != null && lastName!.isEmpty ? "Last name is required" : null;

  String? get genderErrorText =>
      gender != null && gender!.isEmpty ? "Select a gender" : null;

  WelcomeUserState({
    this.firstName,
    this.lastName,
    this.gender,
    this.formStatus = const FormInitialStatus(),
  });

  WelcomeUserState copyWith(
      {String? firstName,
      String? lastName,
      String? gender,
      FormSubmissionStatus? formStatus}) {
    return WelcomeUserState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
