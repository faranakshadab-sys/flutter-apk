import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/parking/home/domain/models/submit-exit-report-model.dart';
import 'package:parkingandroid/features/parking/home/domain/repositories/home-repository.dart';

class SubmitExitReportCase extends AppUseCase<
    Either<AppFailure, SubmitExitReportModel>, SubmitExitReportCaseParams> {
  final HomeRepository repository;

  SubmitExitReportCase({required this.repository});

  @override
  Future<Either<AppFailure, SubmitExitReportModel>> call(
      {required SubmitExitReportCaseParams params}) async {
    return await repository.submitExitReport(
        id: params.id, paymentType: params.paymentType);
  }
}

class SubmitExitReportCaseParams extends Equatable {
  final String id;
  final int paymentType;

  SubmitExitReportCaseParams({required this.id, required this.paymentType});

  @override
  List<Object?> get props => [this.id, this.paymentType];
}
