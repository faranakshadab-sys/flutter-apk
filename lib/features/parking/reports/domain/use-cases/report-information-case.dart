import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../model/report-information-model.dart';
import '../repositories/report-repository.dart';

class ReportInformationCase extends AppUseCase<
    Either<AppFailure, ReportInformationModel>, ReportInformationCaseParams> {
  final ReportRepository repository;

  ReportInformationCase({required this.repository});

  @override
  Future<Either<AppFailure, ReportInformationModel>> call(
      {required ReportInformationCaseParams params}) async {
    return await repository.reportInformation(reportId: params.reportId);
  }
}

class ReportInformationCaseParams extends Equatable {
  final int reportId;

  ReportInformationCaseParams({required this.reportId});

  @override
  List<Object?> get props => [this.reportId];
}
