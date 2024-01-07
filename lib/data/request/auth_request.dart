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

class GetStartedUserInfoRequest {
  final String phoneNumber;
  final String countryCode;
  final String firstName;
  final String lastName;
  final String gender;

  GetStartedUserInfoRequest({
    required this.phoneNumber,
    required this.countryCode,
    required this.firstName,
    required this.lastName,
    required this.gender,
  });
}
