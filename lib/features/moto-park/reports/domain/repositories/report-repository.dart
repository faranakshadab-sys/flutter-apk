import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/features/moto-park/reports/domain/models/report-information-model.dart';

abstract class ReportRepository {
  Future<Either<AppFailure, ReportInformationModel>> reportInformation(
      {required int reportId});
}
