import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/report-view-model.dart';

import '../repositories/home-repository.dart';

class DetectPlateBase64Case extends AppUseCase<
    Either<AppFailure, ReportViewModel?>, DetectPlateBase64CaseParams> {
  final HomeRepository repository;

  DetectPlateBase64Case({required this.repository});

  @override
  Future<Either<AppFailure, ReportViewModel?>> call(
      {required DetectPlateBase64CaseParams params}) async {
    return await repository.detectPlateBase64(
        image: params.image,
        lat: params.lat,
        long: params.long,
        uniqueIdentifier: params.uniqueIdentifier);
  }
}

class DetectPlateBase64CaseParams extends Equatable {
  final String uniqueIdentifier;
  final double lat;
  final double long;
  final String image;

  DetectPlateBase64CaseParams(
      {required this.image,
      required this.lat,
      required this.long,
      required this.uniqueIdentifier});

  @override
  List<Object?> get props =>
      [this.image, this.lat, this.long, this.uniqueIdentifier];
}
