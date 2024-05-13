import 'package:cabby/core/common/constants.dart';
import 'package:cabby/data/responses/responses.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/auth/get-started')
  Future<AuthenticationResponse> getStarted({
    @Field("countryCode") required String countryCode,
    @Field("phoneNumber") required String phoneNumber,
    @Field("email") required String email,
  });

  @POST('/auth/otp-verify')
  Future<AuthenticationResponse> otpVerify({
    @Field("otp") required String otp,
    @Field("email") required String email,
  });

  @POST('/auth/get-started/user-info')
  Future<AuthenticationResponse> getStartedUserInfo({
    @Field("email") required String email,
    @Field("firstName") required String firstName,
    @Field("lastName") required String lastName,
    @Field("gender") required String gender,
  });

  @GET('/auth/user-auth')
  Future<AuthenticationResponse> userAuth();

  @GET('/passenger/estimated-fare')
  Future<dynamic> estimatedFare({
    @Query("distance") required double distance,
    @Query("duration") required double duration,
  });
}

@RestApi(baseUrl: Constant.googleMapBaseUrl)
abstract class GoogleMapsServiceClient {
  factory GoogleMapsServiceClient(Dio dio, {String baseUrl}) =
      _GoogleMapsServiceClient;

  @GET('/geocode/json')
  @Headers(<String, dynamic>{
    'X-Android-Package': 'com.cabby.app',
    'X-Android-Cert': 'BD04FF355619EB922F25D2A37E171C6D327E3E38',
  })
  Future<dynamic> reverseGeoCode({
    @Query("latlng") required String latlng,
    @Query("key") String key = Constant.googleMapApiKey,
  });

  @GET('/place/autocomplete/json')
  @Headers(<String, dynamic>{
    'X-Android-Package': 'com.cabby.app',
    'X-Android-Cert': 'BD04FF355619EB922F25D2A37E171C6D327E3E38',
  })
  Future<dynamic> autoCompleteSearch({
    @Query("input") required String input,
    @Query("key") String key = Constant.googleMapApiKey,
  });

  @GET('/place/details/json')
  @Headers(<String, dynamic>{
    'X-Android-Package': 'com.cabby.app',
    'X-Android-Cert': 'BD04FF355619EB922F25D2A37E171C6D327E3E38',
  })
  Future<dynamic> placeLocationDetails({
    @Query("place_id") required String placeId,
    @Query("key") String key = Constant.googleMapApiKey,
  });

  @GET('/directions/json')
  @Headers(<String, dynamic>{
    'X-Android-Package': 'com.cabby.app',
    'X-Android-Cert': 'BD04FF355619EB922F25D2A37E171C6D327E3E38',
  })
  Future<dynamic> placeLocationDirection({
    @Query("destination") required String destination,
    @Query("origin") required String origin,
    @Query("key") String key = Constant.googleMapApiKey,
  });
}

@RestApi(baseUrl: Constant.googleMapRouteBaseUrl)
abstract class GoogleMapsRouteServiceClient {
  factory GoogleMapsRouteServiceClient(Dio dio, {String baseUrl}) =
      _GoogleMapsRouteServiceClient;

  @POST('')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': Constant.googleMapApiKey,
    'X-Goog-FieldMask':
        'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline,routes.travelAdvisory.tollInfo'
  })
  Future<dynamic> getRoute({
    @Field("origin") required Map<String, dynamic> origin,
    @Field("destination") required Map<String, dynamic> destination,
    @Field("travelMode") String travelMode = "DRIVE",
    @Field("routingPreference") String routingPreference = "TRAFFIC_AWARE",
    @Field("computeAlternativeRoutes") bool computeAlternativeRoutes = false,
    @Field("routeModifiers") dynamic routeModifiers = const {
      "avoidTolls": false,
      "avoidHighways": false,
      "avoidFerries": true
    },
    @Field("languageCode") String languageCode = "en-US",
  });
}
