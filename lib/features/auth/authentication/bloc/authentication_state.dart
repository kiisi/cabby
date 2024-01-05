part of 'authentication_bloc.dart';

class AuthenticationState {
  String? phoneNumber;
  String countryCode;
  final FormSubmissionStatus formStatus;

  AuthenticationState({
    this.phoneNumber,
    this.countryCode = '+234',
    this.formStatus = const FormInitialStatus(),
  });

  String? get phoneNumberErrorText =>
      phoneNumber != null && phoneNumber!.isEmpty
          ? "Invalid phone number"
          : null;

  bool get isFormValid => _validatePhoneNumber(phoneNumber);

  bool _validatePhoneNumber(String? phoneNumber) {
    return phoneNumber != null && phoneNumber.isNotEmpty;
  }

  AuthenticationState copyWith({
    String? phoneNumber,
    String? countryCode,
    FormSubmissionStatus? formStatus,
  }) {
    return AuthenticationState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
