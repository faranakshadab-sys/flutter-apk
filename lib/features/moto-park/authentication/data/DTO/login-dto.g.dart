// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDTO _$LoginDTOFromJson(Map<String, dynamic> json) => LoginDTO(
      accessToken: json['accessToken'] as String,
      accessTokenExpireTime: json['accessTokenExpireTime'] as int,
      fullName: json['fullName'] as String,
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpireTime: json['refreshTokenExpireTime'] as int,
      roleName: json['roleName'] as String,
      uniqueIdentifier: json['uniqueIdentifier'] as String,
      userId: json['userId'] as int,
    );

Map<String, dynamic> _$LoginDTOToJson(LoginDTO instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'accessTokenExpireTime': instance.accessTokenExpireTime,
      'refreshTokenExpireTime': instance.refreshTokenExpireTime,
      'userId': instance.userId,
      'fullName': instance.fullName,
      'roleName': instance.roleName,
      'uniqueIdentifier': instance.uniqueIdentifier,
    };
