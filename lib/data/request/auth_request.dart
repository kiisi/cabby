class GetStartedRequest {
  final String phoneNumber;
  final String email;
  final String countryCode;

  GetStartedRequest({
    required this.phoneNumber,
    required this.email,
    required this.countryCode,
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

  GetStartedUserInfoRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
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
