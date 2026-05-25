import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/features/moto-park/reports/data/DTO/report-information-dto.dart';

abstract class ReportRemoteDatasource {
  Future<Either<AppExceptions, ReportInformationDTO>> reportInformation(
      {required int reportId});
}
