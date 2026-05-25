import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../../../common/domain/models/report-view-model.dart';
import '../repositories/home-repository.dart';


class DetectPlateBytesCase extends AppUseCase<
    Either<AppFailure, ReportViewModel?>, DetectPlateBytesCaseParams> {
  final HomeRepository repository;

  DetectPlateBytesCase({required this.repository});

  @override
  Future<Either<AppFailure, ReportViewModel?>> call(
      {required DetectPlateBytesCaseParams params}) async {
    return await repository.detectPlateBytes(
        image: params.image,
        lat: params.lat,
        long: params.long,
        uniqueIdentifier: params.uniqueIdentifier);
  }
}

class DetectPlateBytesCaseParams extends Equatable {
  final Uint8List image;
  final double lat;
  final double long;
  final String uniqueIdentifier;

  DetectPlateBytesCaseParams(
      {required this.image,
      required this.lat,
      required this.long,
      required this.uniqueIdentifier});

  @override
  List<Object?> get props =>
      [this.image, this.lat, this.long, this.uniqueIdentifier];
}
