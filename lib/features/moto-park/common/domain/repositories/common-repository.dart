import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/add-plate-identity-model.dart';

import '../models/plate-identity-model.dart';
import '../models/report-view-model.dart';

abstract class CommonRepository {
  Future<Either<AppFailure, List<ReportViewModel>>> getReports(
      {required int page,
      required int pageSize,
      int? plateNumberPart1,
      String? plateNumberPart2,
      int? plateNumberPart3,
      int? plateNumberPart4,
      String? date});

  Future<Either<AppFailure, List<PlateIdentityModel>>> getPlateIdentity(
      {required int page,
      required int pageSize,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      String? ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName});

  Future<Either<AppFailure, AddPlateIdentityModel>> addPlateIdentity(
      {required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      required String ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName});

  Future<Either<AppFailure, bool>> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String refrenceId});

  Future<Either<AppFailure, ReportViewModel>> updateReport(
      {required int id,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4});

  Future<Either<AppFailure, int>> deletePlateIdentity({required int id});
}
