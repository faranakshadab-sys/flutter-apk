import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/parking/home/domain/models/detected-plate-model.dart';
import '../repositories/home-repository.dart';

class DetectPlateBytesCase extends AppUseCase<
    Either<AppFailure, DetectedPlateModel?>, DetectPlateBytesCaseParams> {
  final HomeRepository repository;

  DetectPlateBytesCase({required this.repository});

  @override
  Future<Either<AppFailure, DetectedPlateModel?>> call(
      {required DetectPlateBytesCaseParams params}) async {
    return await repository.detectPlateBytes(
      image: params.image,
    );
  }
}

class DetectPlateBytesCaseParams extends Equatable {
  final Uint8List image;

  DetectPlateBytesCaseParams({
    required this.image,
  });

  @override
  List<Object?> get props => [this.image];
}
