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
      email: getStartedRequest.email,
    );
  }

  @override
  Future<AuthenticationResponse> otpVerifyRequest(
      OtpVerifyRequest otpVerifyRequest) async {
    return await _appServiceClient.otpVerify(
      otp: otpVerifyRequest.otp,
      email: otpVerifyRequest.email,
    );
  }

  @override
  Future<AuthenticationResponse> getStartedUserInfo(
      GetStartedUserInfoRequest getStartedUserInfoRequest) async {
    return await _appServiceClient.getStartedUserInfo(
      firstName: getStartedUserInfoRequest.firstName,
      lastName: getStartedUserInfoRequest.lastName,
      gender: getStartedUserInfoRequest.gender,
      email: getStartedUserInfoRequest.email,
      countryCode: getStartedUserInfoRequest.countryCode,
      phoneNumber: getStartedUserInfoRequest.phoneNumber,
    );
  }

  @override
  Future<AuthenticationResponse> userAuth() async {
    return await _appServiceClient.userAuth();
  }
}
