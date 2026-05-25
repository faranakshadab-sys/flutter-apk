import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';

import '../DTO/profile-dto.dart';
import '../DTO/report-dto.dart';

abstract class HomeRemoteDatasource {
  Future<Either<AppExceptions, ReportDTO?>> detectPlateBase64(
      {required String image,
      required double lat,
      required double long,
      required String uniqueIdentifier});

  Future<Either<AppExceptions, ReportDTO?>> detectPlateBytes(
      {required Uint8List image,
      required double lat,
      required double long,
      required String uniqueIdentifier});

  Future<Either<AppExceptions, ProfileDTO>> profileInformation();
}
