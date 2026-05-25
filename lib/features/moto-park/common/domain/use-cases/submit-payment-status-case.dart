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
        refrenceId: params.refrenceId);
  }
}

class SubmitPaymentStatusCaseParams extends Equatable {
  final int reportId;
  final int totalAmount;
  final String refrenceId;

  SubmitPaymentStatusCaseParams(
      {required this.reportId,
      required this.totalAmount,
      required this.refrenceId});

  @override
  List<Object?> get props => [this.reportId, this.totalAmount];
}
