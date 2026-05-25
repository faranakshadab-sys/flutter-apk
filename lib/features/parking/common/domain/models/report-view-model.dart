import 'package:equatable/equatable.dart';

class ReportViewModel extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final int imagesCount;
  final String totalParkTime;
  final double longitude;
  final double latitude;
  final String createdAt;
  final String lastImageTakenAt;
  final String firstImageTakenAt;
  final int debtAmount;
  final int currentAmount;
  final int totalAmount;
  final int paymentStatus;
  final String paymentStatusText;
  final String totalParkTimeText;
  final String address;
  final List<ReportImageViewModel> images;
  final bool isMobileNumberRegistered;

  ReportViewModel(
      {required this.createdAt,
      required this.currentAmount,
      required this.debtAmount,
      required this.firstImageTakenAt,
      required this.id,
      required this.images,
      required this.imagesCount,
      required this.lastImageTakenAt,
      required this.latitude,
      required this.longitude,
      required this.paymentStatus,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4,
      required this.totalAmount,
      required this.totalParkTime,
      required this.totalParkTimeText,
      required this.address,
      required this.isMobileNumberRegistered,
      required this.paymentStatusText});

  @override
  List<Object?> get props => [
        this.createdAt,
        this.currentAmount,
        this.debtAmount,
        this.firstImageTakenAt,
        this.id,
        this.images,
        this.imagesCount,
        this.lastImageTakenAt,
        this.latitude,
        this.longitude,
        this.paymentStatus,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4,
        this.totalAmount,
        this.totalParkTime,
        this.totalParkTimeText,
        this.address,
        this.paymentStatusText
      ];
}

class ReportImageViewModel extends Equatable {
  final int id;
  final String mainImage;
  final String plateImage;
  final String createdAt;

  ReportImageViewModel(
      {required this.createdAt,
      required this.id,
      required this.mainImage,
      required this.plateImage});

  @override
  List<Object?> get props =>
      [this.createdAt, this.id, this.mainImage, this.plateImage];
}
