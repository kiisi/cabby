part of 'otp_verification_bloc.dart';

@immutable
abstract class OtpVerificationEvent {}

class OtpInputs extends OtpVerificationEvent {}

class OtpVerificationSetOtp extends OtpVerificationEvent {
  final String? otp;
  OtpVerificationSetOtp({required this.otp});
}

class OtpVerificationSubmission extends OtpVerificationEvent {}
