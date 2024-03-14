import 'package:cabby/core/common/constants.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  @GET('/auth/user-auth')
  Future<AuthenticationResponse> userAuth();
}

@RestApi(baseUrl: Constant.googleMapBaseUrl)
abstract class GoogleMapsServiceClient {
  factory GoogleMapsServiceClient(Dio dio, {String baseUrl}) =
      _GoogleMapsServiceClient;

  @GET('/geocode/json')
  Future<dynamic> reverseGeoCode({
    @Query("latlng") required String latlng,
    @Query("key") required String key,
  });

  @GET('/place/autocomplete/json')
  Future<dynamic> autoCompleteSearch({
    @Query("input") required String input,
    @Query("key") required String key,
  });

  @GET('/place/details/json')
  Future<dynamic> placeDirectionDetails({
    @Query("place_id") required String placeId,
    @Query("key") required String key,
  });
}
