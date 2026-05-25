// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDTO _$ProfileDTOFromJson(Map<String, dynamic> json) => ProfileDTO(
      createdAt: json['createdAt'] as String,
      firstName: json['firstName'] as String,
      id: json['id'] as int,
      lastLoginAt: json['lastLoginAt'] as String,
      lastName: json['lastName'] as String,
      roleName: json['roleName'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$ProfileDTOToJson(ProfileDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roleName': instance.roleName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'username': instance.username,
      'createdAt': instance.createdAt,
      'lastLoginAt': instance.lastLoginAt,
    };
