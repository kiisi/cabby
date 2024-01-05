part of 'otp_verification_bloc.dart';

class OtpVerificationState {
  final String? otp;
  final FormSubmissionStatus formStatus;

  OtpVerificationState({
    this.otp,
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
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
