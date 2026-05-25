import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../models/report-view-model.dart';
import '../repositories/common-repository.dart';

class UpdatePlateCase extends AppUseCase<Either<AppFailure, ReportViewModel>,
    UpdatePlateCaseParams> {
  final CommonRepository repository;

  UpdatePlateCase({required this.repository});

  @override
  Future<Either<AppFailure, ReportViewModel>> call(
      {required UpdatePlateCaseParams params}) async {
    return await repository.updateReport(
        id: params.id,
        plateNumberPart1: params.plateNumberPart1,
        plateNumberPart2: params.plateNumberPart2,
        plateNumberPart3: params.plateNumberPart3,
        plateNumberPart4: params.plateNumberPart4);
  }
}

class UpdatePlateCaseParams extends Equatable {
  final int id;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;

  UpdatePlateCaseParams(
      {required this.id,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4});

  @override
  List<Object?> get props => [
        this.id,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4
      ];
}
