part of 'otp_verification_bloc.dart';

class OtpVerificationState {
  final String? otp;
  final String? countryCode;
  final String? phoneNumber;
  final String? email;
  final FormSubmissionStatus formStatus;

  OtpVerificationState({
    this.otp,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.formStatus = const FormInitialStatus(),
  });

  bool get isFormValid => otp?.length == 6;

  OtpVerificationState copyWith(
      {String? otp,
      String? countryCode,
      String? phoneNumber,
      String? email,
      FormSubmissionStatus? formStatus}) {
    return OtpVerificationState(
      otp: otp ?? this.otp,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
