// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detected-plate-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectedPlateDTO _$DetectedPlateDTOFromJson(Map<String, dynamic> json) =>
    DetectedPlateDTO(
      base64Image: json['base64Image'] as String,
      plateNumber: json['plateNumber'] as String,
    );

Map<String, dynamic> _$DetectedPlateDTOToJson(DetectedPlateDTO instance) =>
    <String, dynamic>{
      'plateNumber': instance.plateNumber,
      'base64Image': instance.base64Image,
    };
