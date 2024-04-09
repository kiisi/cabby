part of 'authentication_bloc.dart';

class AuthenticationState {
  String? phoneNumber;
  String? email;
  String countryCode;
  final FormSubmissionStatus formStatus;

  AuthenticationState({
    this.phoneNumber,
    this.countryCode = '+234',
    this.email,
    this.formStatus = const FormInitialStatus(),
  });

  String? get phoneNumberErrorText => phoneNumber == null
      ? null
      : phoneNumber!.trim().isNotEmpty
          ? null
          : "Invalid phone number";

  String? get emailErrorText => email == null
      ? null
      : email!.trim().isNotEmpty
          ? null
          : "Invalid email";

  bool get isFormValid =>
      _validatePhoneNumber(phoneNumber) && _validateEmail(email);

  bool _validatePhoneNumber(String? phoneNumber) {
    return phoneNumber != null && phoneNumber.isNotEmpty;
  }

  bool _validateEmail(String? email) {
    return email != null && email.isNotEmpty;
  }

  AuthenticationState copyWith({
    String? phoneNumber,
    String? countryCode,
    String? email,
    FormSubmissionStatus? formStatus,
  }) {
    return AuthenticationState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      countryCode: countryCode ?? this.countryCode,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
