import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/parking/home/domain/models/create-enter-report-model.dart';
import 'package:parkingandroid/features/parking/home/domain/repositories/home-repository.dart';

class CreateEnterReportCase extends AppUseCase<
    Either<AppFailure, CreateEnterReportModel>, CreateEnterReportCaseParams> {
  final HomeRepository repository;

  CreateEnterReportCase({required this.repository});

  @override
  Future<Either<AppFailure, CreateEnterReportModel>> call(
      {required CreateEnterReportCaseParams params}) async {
    return await repository.createEnterReport(
        phoneNumber: params.phoneNumber,
        plateImage: params.image,
        plateNumber: params.plateNumber);
  }
}

class CreateEnterReportCaseParams extends Equatable {
  final String image;
  final String phoneNumber;
  final String plateNumber;

  CreateEnterReportCaseParams(
      {required this.image,
      required this.phoneNumber,
      required this.plateNumber});

  @override
  List<Object?> get props => [this.image, this.phoneNumber, this.plateNumber];
}
