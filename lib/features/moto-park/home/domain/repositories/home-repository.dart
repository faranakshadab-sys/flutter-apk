import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/report-view-model.dart';
import 'package:parkingandroid/features/moto-park/home/domain/models/profile-model.dart';

abstract class HomeRepository {
  Future<Either<AppFailure, ReportViewModel?>> detectPlateBase64(
      {required String image,
      required double lat,
      required double long,
      required String uniqueIdentifier});

  Future<Either<AppFailure, ReportViewModel?>> detectPlateBytes(
      {required Uint8List image,
      required double lat,
      required double long,
      required String uniqueIdentifier});

  Future<Either<AppFailure, ProfileModel>> profileInformation();
}
