class GetStartedRequest {
  final String phoneNumber;
  final String countryCode;

  GetStartedRequest({
    required this.phoneNumber,
    required this.countryCode,
  });
}

class OtpVerifyRequest {
  final String phoneNumber;
  final String countryCode;
  final String otp;

  OtpVerifyRequest({
    required this.phoneNumber,
    required this.countryCode,
    required this.otp,
  });
}
