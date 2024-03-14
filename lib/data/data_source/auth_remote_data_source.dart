import 'package:cabby/data/network/app_api.dart';
import 'package:cabby/data/request/auth_request.dart';
import 'package:cabby/data/responses/responses.dart';

abstract interface class AuthenticationRemoteDataSource {
  Future<AuthenticationResponse> getStarted(
      GetStartedRequest getStartedRequest);
  Future<AuthenticationResponse> otpVerifyRequest(
      OtpVerifyRequest otpVerifyRequest);
  Future<AuthenticationResponse> getStartedUserInfo(
      GetStartedUserInfoRequest getStartedUserInfoRequest);
  Future<AuthenticationResponse> userAuth();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final AppServiceClient _appServiceClient;

  AuthenticationRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> getStarted(
      GetStartedRequest getStartedRequest) async {
    return await _appServiceClient.getStarted(
      countryCode: getStartedRequest.countryCode,
      phoneNumber: getStartedRequest.phoneNumber,
    );
  }

  @override
  Future<AuthenticationResponse> otpVerifyRequest(
      OtpVerifyRequest otpVerifyRequest) async {
    return await _appServiceClient.otpVerify(
      countryCode: otpVerifyRequest.countryCode,
      phoneNumber: otpVerifyRequest.phoneNumber,
      otp: otpVerifyRequest.otp,
    );
  }

  @override
  Future<AuthenticationResponse> getStartedUserInfo(
      GetStartedUserInfoRequest getStartedUserInfoRequest) async {
    return await _appServiceClient.getStartedUserInfo(
      countryCode: getStartedUserInfoRequest.countryCode,
      phoneNumber: getStartedUserInfoRequest.phoneNumber,
      firstName: getStartedUserInfoRequest.firstName,
      lastName: getStartedUserInfoRequest.lastName,
      gender: getStartedUserInfoRequest.gender,
    );
  }

  @override
  Future<AuthenticationResponse> userAuth() async {
    return await _appServiceClient.userAuth();
  }
}
