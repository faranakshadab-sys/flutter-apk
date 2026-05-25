import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../models/report-view-model.dart';
import '../repositories/common-repository.dart';

class GetReportsCase extends AppUseCase<
    Either<AppFailure, List<ReportViewModel>>, GetReportsCaseParams> {
  final CommonRepository repository;

  GetReportsCase({required this.repository});

  @override
  Future<Either<AppFailure, List<ReportViewModel>>> call(
      {required GetReportsCaseParams params}) async {
    return await repository.getReports(
        page: params.page,
        pageSize: params.pageSize,
        date: params.date,
        plateNumberPart1: params.plateNumberPart1,
        plateNumberPart2: params.plateNumberPart2,
        plateNumberPart3: params.plateNumberPart3,
        plateNumberPart4: params.plateNumberPart4);
  }
}

class GetReportsCaseParams extends Equatable {
  final int page;
  final int pageSize;
  final int? plateNumberPart1;
  final String? plateNumberPart2;
  final int? plateNumberPart3;
  final int? plateNumberPart4;
  final String? date;

  GetReportsCaseParams(
      {required this.page,
      required this.pageSize,
      this.date,
      this.plateNumberPart1,
      this.plateNumberPart2,
      this.plateNumberPart3,
      this.plateNumberPart4});

  @override
  List<Object?> get props => [
        this.page,
        this.pageSize,
        this.date,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4
      ];
}
