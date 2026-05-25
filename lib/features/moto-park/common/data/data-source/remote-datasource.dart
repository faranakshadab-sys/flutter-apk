import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';

import '../../../home/data/DTO/report-dto.dart';
import '../DTO/add-plate-identity-dto.dart';
import '../DTO/plate-identity-dto.dart';
import '../DTO/reports-dto.dart';

abstract class CommonRemoteDatasource {
  Future<Either<AppExceptions, ReportsDTO>> getReport(
      {required int page,
      required int pageSize,
      int? plateNumberPart1,
      String? plateNumberPart2,
      int? plateNumberPart3,
      int? plateNumberPart4,
      String? date});

  Future<Either<AppExceptions, PlateIdentityDTO>> getPlateIdentity(
      {required int page,
      required int pageSize,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      String? ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName});

  Future<Either<AppExceptions, AddPlateIdentityDTO>> addPlateIdentity(
      {required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      required String ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName});

  Future<Either<AppExceptions, bool>> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String refrenceId});

  Future<Either<AppExceptions, ReportDTO>> updateReport(
      {required int id,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4});

  Future<Either<AppExceptions, int>> deletePlateIdentity({required int id});
}
