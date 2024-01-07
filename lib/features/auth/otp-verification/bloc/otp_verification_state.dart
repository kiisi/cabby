part of 'otp_verification_bloc.dart';

class OtpVerificationState {
  final String? otp;
  final String? countryCode;
  final String? phoneNumber;
  final FormSubmissionStatus formStatus;

  OtpVerificationState({
    this.otp,
    this.countryCode,
    this.phoneNumber,
    this.formStatus = const FormInitialStatus(),
  });

  bool get isFormValid => otp?.length == 6;

  OtpVerificationState copyWith(
      {String? otp,
      String? countryCode,
      String? phoneNumber,
      FormSubmissionStatus? formStatus}) {
    return OtpVerificationState(
      otp: otp ?? this.otp,
      countryCode: countryCode ?? this.countryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
