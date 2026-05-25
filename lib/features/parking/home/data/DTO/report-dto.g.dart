// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportDTO _$ReportDTOFromJson(Map<String, dynamic> json) => ReportDTO(
      averageAccuracy: json['averageAccuracy'] as int,
      createdAt: json['createdAt'] as String,
      id: json['id'] as int,
      images: (json['images'] as List<dynamic>)
          .map((e) => ReportImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      imagesCount: json['imagesCount'] as int,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      mapUrl: json['mapUrl'] as String,
      plateNumberPart1: json['plateNumberPart1'] as int,
      plateNumberPart2: json['plateNumberPart2'] as String,
      plateNumberPart3: json['plateNumberPart3'] as int,
      plateNumberPart4: json['plateNumberPart4'] as int,
      totalParkTime: json['totalParkTime'] as String,
      address: json['address'] as String,
      lastImageTakenAt: json['lastImageTakenAt'] as String,
      firstImageTakenAt: json['firstImageTakenAt'] as String,
      debtAmount: json['debtAmount'] as int,
      currentAmount: json['currentAmount'] as int,
      totalAmount: json['totalAmount'] as int,
      paymentStatus: json['paymentStatus'] as int,
      totalParkTimeText: json['totalParkTimeText'] as String,
      isMobileNumberRegistered: json['isMobileNumberRegistered'] as bool,
      paymentStatusText: json['paymentStatusText'] as String,
    );

Map<String, dynamic> _$ReportDTOToJson(ReportDTO instance) => <String, dynamic>{
      'id': instance.id,
      'plateNumberPart1': instance.plateNumberPart1,
      'plateNumberPart2': instance.plateNumberPart2,
      'plateNumberPart3': instance.plateNumberPart3,
      'plateNumberPart4': instance.plateNumberPart4,
      'imagesCount': instance.imagesCount,
      'totalParkTime': instance.totalParkTime,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'mapUrl': instance.mapUrl,
      'createdAt': instance.createdAt,
      'averageAccuracy': instance.averageAccuracy,
      'images': instance.images,
      'address': instance.address,
      'lastImageTakenAt': instance.lastImageTakenAt,
      'firstImageTakenAt': instance.firstImageTakenAt,
      'debtAmount': instance.debtAmount,
      'currentAmount': instance.currentAmount,
      'totalAmount': instance.totalAmount,
      'paymentStatusText': instance.paymentStatusText,
      'paymentStatus': instance.paymentStatus,
      'totalParkTimeText': instance.totalParkTimeText,
      'isMobileNumberRegistered': instance.isMobileNumberRegistered,
    };
