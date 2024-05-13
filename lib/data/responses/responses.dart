import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'message')
  String? message;
}

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: '_id')
  String? id;
  String? countryCode;
  int? phoneNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? role;
  String? photo;
  String? ipAddress;
  bool? isProfileComplete;
  bool? isMobileVerified;
  bool? isDeleted;

  UserDataResponse({
    required this.id,
    this.countryCode,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.gender,
    this.role,
    this.photo,
    this.ipAddress,
    this.isProfileComplete,
    this.isMobileVerified,
    this.isDeleted,
  });

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'accessToken')
  String? accessToken;
  @JsonKey(name: 'user')
  UserDataResponse? user;

  DataResponse({this.accessToken, this.user});
  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  AuthenticationResponse({this.data});
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
