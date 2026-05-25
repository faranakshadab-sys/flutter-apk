import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:parkingandroid/features/common/data/DTO/report-image-dto.dart';
part 'report-information-dto.g.dart';

@JsonSerializable()
class ReportInformationDTO extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final String province;
  final String county;
  final String city;
  final String region;
  final String neighborhood;
  final String fullAddress;
  final int imagesCount;
  final String totalParkTime;
  final double longitude;
  final double latitude;
  final String startTime;
  final String endTime;
  final String mapUrl;
  final String createdAt;
  final int averageAccuracy;
  final List<ReportImage> images;
  final String paymentStatusText;
  final int paymentStatus;
  final String totalParkTimeText;
  final double totalAmount;
  final bool isMobileNumberRegistered;

  ReportInformationDTO(
      {required this.averageAccuracy,
      required this.city,
      required this.county,
      required this.createdAt,
      required this.endTime,
      required this.fullAddress,
      required this.id,
      required this.images,
      required this.imagesCount,
      required this.latitude,
      required this.longitude,
      required this.mapUrl,
      required this.neighborhood,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4,
      required this.province,
      required this.region,
      required this.startTime,
      required this.totalParkTime,
      required this.paymentStatus,
      required this.totalAmount,
      required this.totalParkTimeText,
      required this.isMobileNumberRegistered,
      required this.paymentStatusText});

  factory ReportInformationDTO.fromJson(Map<String, dynamic> json) =>
      _$ReportInformationDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ReportInformationDTOToJson(this);

  @override
  List<Object?> get props => [
        this.averageAccuracy,
        this.city,
        this.county,
        this.createdAt,
        this.endTime,
        this.fullAddress,
        this.id,
        this.images,
        this.imagesCount,
        this.latitude,
        this.longitude,
        this.mapUrl,
        this.neighborhood,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4,
        this.province,
        this.region,
        this.startTime,
        this.totalParkTime,
        this.paymentStatus,
        this.isMobileNumberRegistered,
        this.paymentStatusText
      ];
}
