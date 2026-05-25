// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-enter-report-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateEnterReportDTO _$CreateEnterReportDTOFromJson(
        Map<String, dynamic> json) =>
    CreateEnterReportDTO(
      id: json['id'] as String,
      entryDate: json['entryDate'] as String,
      parkingAddress: json['parkingAddress'] as String,
      parkingName: json['parkingName'] as String,
      parkingPhone: json['parkingPhone'] as String,
    );

Map<String, dynamic> _$CreateEnterReportDTOToJson(
        CreateEnterReportDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entryDate': instance.entryDate,
      'parkingName': instance.parkingName,
      'parkingAddress': instance.parkingAddress,
      'parkingPhone': instance.parkingPhone,
    };
