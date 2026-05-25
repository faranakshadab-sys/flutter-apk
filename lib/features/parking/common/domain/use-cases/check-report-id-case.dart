import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/parking/common/domain/models/report-view-model.dart';
import 'package:parkingandroid/features/parking/common/domain/repositories/common-repository.dart';

class ExitVehicleCase extends AppUseCase<Either<AppFailure, ReportViewModel>,
    ExitVehicleCaseParams> {
  final CommonRepository repository;

  ExitVehicleCase({required this.repository});

  @override
  Future<Either<AppFailure, ReportViewModel>> call(
      {required ExitVehicleCaseParams params}) async {
    return await repository.exitVehicle(id: params.reportId);
  }
}

class ExitVehicleCaseParams extends Equatable {
  final int reportId;

  ExitVehicleCaseParams({required this.reportId});

  @override
  List<Object?> get props => [this.reportId];
}
