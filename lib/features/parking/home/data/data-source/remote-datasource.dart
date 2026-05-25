import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/create-enter-report-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/detected-plate-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/submit-exit-report-dto.dart';

import '../DTO/profile-dto.dart';

abstract class HomeRemoteDatasource {
  Future<Either<AppExceptions, DetectedPlateDTO?>> detectPlateBytes(
      {required Uint8List image});

  Future<Either<AppExceptions, CreateEnterReportDTO>> createEnterReport(
      {required String phoneNumber,
      required String plateImage,
      required String plateNumber});

  Future<Either<AppExceptions, SubmitExitReportDTO>> submitExitReport(
      {required String id, required int paymentType});

  Future<Either<AppExceptions, ProfileDTO>> profileInformation();
}
