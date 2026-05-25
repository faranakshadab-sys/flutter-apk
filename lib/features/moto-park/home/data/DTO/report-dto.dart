import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:parkingandroid/features/common/data/DTO/report-image-dto.dart';

part 'report-dto.g.dart';

@JsonSerializable()
class ReportDTO extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final int imagesCount;
  final String totalParkTime;
  final double longitude;
  final double latitude;
  final String mapUrl;
  final String createdAt;
  final int averageAccuracy;
  final List<ReportImage> images;
  final String address;
  final String lastImageTakenAt;
  final String firstImageTakenAt;
  final int debtAmount;
  final int currentAmount;
  final int totalAmount;
  final String paymentStatusText;
  final int paymentStatus;
  final String totalParkTimeText;
  final bool isMobileNumberRegistered;

  ReportDTO(
      {required this.averageAccuracy,
      required this.createdAt,
      required this.id,
      required this.images,
      required this.imagesCount,
      required this.latitude,
      required this.longitude,
      required this.mapUrl,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4,
      required this.totalParkTime,
      required this.address,
      required this.lastImageTakenAt,
      required this.firstImageTakenAt,
      required this.debtAmount,
      required this.currentAmount,
      required this.totalAmount,
      required this.paymentStatus,
      required this.totalParkTimeText,
      required this.isMobileNumberRegistered,
      required this.paymentStatusText});

  factory ReportDTO.fromJson(Map<String, dynamic> json) =>
      _$ReportDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReportDTOToJson(this);

  @override
  List<Object?> get props => [
        this.averageAccuracy,
        this.createdAt,
        this.id,
        this.images,
        this.imagesCount,
        this.latitude,
        this.longitude,
        this.mapUrl,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4,
        this.totalParkTime,
        this.address,
        this.lastImageTakenAt,
        this.firstImageTakenAt,
        this.debtAmount,
        this.currentAmount,
        this.totalAmount,
        this.paymentStatus,
        this.isMobileNumberRegistered,
        this.paymentStatusText
      ];
}
