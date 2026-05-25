import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../repositories/common-repository.dart';

class SubmitPaymentStatusCase extends AppUseCase<Either<AppFailure, bool>,
    SubmitPaymentStatusCaseParams> {
  final CommonRepository repository;

  SubmitPaymentStatusCase({required this.repository});

  @override
  Future<Either<AppFailure, bool>> call(
      {required SubmitPaymentStatusCaseParams params}) async {
    return await repository.submitPaymentStatus(
        reportId: params.reportId,
        totalAmount: params.totalAmount,
        referenceId: params.referenceId);
  }
}

class SubmitPaymentStatusCaseParams extends Equatable {
  final int reportId;
  final int totalAmount;
  final String referenceId;

  SubmitPaymentStatusCaseParams(
      {required this.reportId,
      required this.totalAmount,
      required this.referenceId});

  @override
  List<Object?> get props =>
      [this.reportId, this.totalAmount, this.referenceId];
}
