// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report-image-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportImage _$ReportImageFromJson(Map<String, dynamic> json) => ReportImage(
      accuracy: json['accuracy'] as int,
      camera: json['camera'] as int,
      createdAt: json['createdAt'] as String,
      id: json['id'] as int,
      mainImage: json['mainImage'] as String,
      plateImage: json['plateImage'] as String,
    );

Map<String, dynamic> _$ReportImageToJson(ReportImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accuracy': instance.accuracy,
      'mainImage': instance.mainImage,
      'plateImage': instance.plateImage,
      'camera': instance.camera,
      'createdAt': instance.createdAt,
    };
