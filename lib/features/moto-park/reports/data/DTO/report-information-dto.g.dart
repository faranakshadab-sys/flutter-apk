// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report-information-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportInformationDTO _$ReportInformationDTOFromJson(
        Map<String, dynamic> json) =>
    ReportInformationDTO(
      averageAccuracy: json['averageAccuracy'] as int,
      city: json['city'] as String,
      county: json['county'] as String,
      createdAt: json['createdAt'] as String,
      endTime: json['endTime'] as String,
      fullAddress: json['fullAddress'] as String,
      id: json['id'] as int,
      images: (json['images'] as List<dynamic>)
          .map((e) => ReportImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      imagesCount: json['imagesCount'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      mapUrl: json['mapUrl'] as String,
      neighborhood: json['neighborhood'] as String,
      plateNumberPart1: json['plateNumberPart1'] as int,
      plateNumberPart2: json['plateNumberPart2'] as String,
      plateNumberPart3: json['plateNumberPart3'] as int,
      plateNumberPart4: json['plateNumberPart4'] as int,
      province: json['province'] as String,
      region: json['region'] as String,
      startTime: json['startTime'] as String,
      totalParkTime: json['totalParkTime'] as String,
      paymentStatus: json['paymentStatus'] as int,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      totalParkTimeText: json['totalParkTimeText'] as String,
      isMobileNumberRegistered: json['isMobileNumberRegistered'] as bool,
      paymentStatusText: json['paymentStatusText'] as String,
    );

Map<String, dynamic> _$ReportInformationDTOToJson(
        ReportInformationDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plateNumberPart1': instance.plateNumberPart1,
      'plateNumberPart2': instance.plateNumberPart2,
      'plateNumberPart3': instance.plateNumberPart3,
      'plateNumberPart4': instance.plateNumberPart4,
      'province': instance.province,
      'county': instance.county,
      'city': instance.city,
      'region': instance.region,
      'neighborhood': instance.neighborhood,
      'fullAddress': instance.fullAddress,
      'imagesCount': instance.imagesCount,
      'totalParkTime': instance.totalParkTime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'mapUrl': instance.mapUrl,
      'createdAt': instance.createdAt,
      'averageAccuracy': instance.averageAccuracy,
      'images': instance.images,
      'paymentStatusText': instance.paymentStatusText,
      'paymentStatus': instance.paymentStatus,
      'totalParkTimeText': instance.totalParkTimeText,
      'totalAmount': instance.totalAmount,
      'isMobileNumberRegistered': instance.isMobileNumberRegistered,
    };
