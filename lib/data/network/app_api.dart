import 'package:cabby/app/constants.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/auth/get-started')
  Future<AuthenticationResponse> getStarted({
    @Field("countryCode") required String countryCode,
    @Field("phoneNumber") required String phoneNumber,
  });

  @POST('/auth/otp-verify')
  Future<AuthenticationResponse> otpVerify({
    @Field("countryCode") required String countryCode,
    @Field("phoneNumber") required String phoneNumber,
    @Field("otp") required String otp,
  });

  @POST('/auth/get-started/user-info')
  Future<AuthenticationResponse> getStartedUserInfo({
    @Field("countryCode") required String countryCode,
    @Field("phoneNumber") required String phoneNumber,
    @Field("firstName") required String firstName,
    @Field("lastName") required String lastName,
    @Field("gender") required String gender,
  });
}
