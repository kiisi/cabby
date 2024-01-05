// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as String?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      id: json['_id'] as String?,
      countryCode: json['countryCode'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      role: json['role'] as String?,
      photo: json['photo'] as String?,
      ipAddress: json['ipAddress'] as String?,
      isProfileComplete: json['isProfileComplete'] as bool?,
      isMobileVerified: json['isMobileVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'countryCode': instance.countryCode,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'role': instance.role,
      'photo': instance.photo,
      'ipAddress': instance.ipAddress,
      'isProfileComplete': instance.isProfileComplete,
      'isMobileVerified': instance.isMobileVerified,
      'isDeleted': instance.isDeleted,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : UserDataResponse.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      data: json['data'] == null
          ? null
          : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
