import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/features/parking/home/domain/models/create-enter-report-model.dart';
import 'package:parkingandroid/features/parking/home/domain/models/detected-plate-model.dart';
import 'package:parkingandroid/features/parking/home/domain/models/submit-exit-report-model.dart';
import '../models/profile-model.dart';

abstract class HomeRepository {
  Future<Either<AppFailure, DetectedPlateModel?>> detectPlateBytes(
      {required Uint8List image});

  Future<Either<AppFailure, ProfileModel>> profileInformation();

  Future<Either<AppFailure, CreateEnterReportModel>> createEnterReport(
      {required String phoneNumber,
      required String plateImage,
      required String plateNumber});

  Future<Either<AppFailure, SubmitExitReportModel>> submitExitReport(
      {required String id, required int paymentType});
}
