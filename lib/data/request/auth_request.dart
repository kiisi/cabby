class GetStartedRequest {
  final String email;

  GetStartedRequest({
    required this.email,
  });
}

class OtpVerifyRequest {
  final String otp;
  final String email;

  OtpVerifyRequest({
    required this.otp,
    required this.email,
  });
}

class GetStartedUserInfoRequest {
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String countryCode;
  final String phoneNumber;

  GetStartedUserInfoRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.countryCode,
    required this.phoneNumber,
  });
}

class EstimatedFareRequest {
  final double distance;
  final double duration;

  EstimatedFareRequest({
    required this.duration,
    required this.distance,
  });
}
