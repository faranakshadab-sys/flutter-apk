import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../models/add-plate-identity-model.dart';
import '../repositories/common-repository.dart';

class AddPlateIdentityCase extends AppUseCase<
    Either<AppFailure, AddPlateIdentityModel>, AddPlateIdentityCaseParams> {
  final CommonRepository repository;

  AddPlateIdentityCase({required this.repository});

  @override
  Future<Either<AppFailure, AddPlateIdentityModel>> call(
      {required AddPlateIdentityCaseParams params}) async {
    return await repository.addPlateIdentity(
        plateNumberPart1: params.plateNumberPart1,
        plateNumberPart2: params.plateNumberPart2,
        plateNumberPart3: params.plateNumberPart3,
        plateNumberPart4: params.plateNumberPart4,
        ownerMobileNumber: params.ownerMobileNumber,
        ownerFirstName: params.ownerFirstName,
        ownerLastName: params.ownerLastName);
  }
}

class AddPlateIdentityCaseParams extends Equatable {
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final String ownerMobileNumber;
  final String? ownerFirstName;
  final String? ownerLastName;

  AddPlateIdentityCaseParams(
      {required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4,
      required this.ownerMobileNumber,
      this.ownerFirstName,
      this.ownerLastName});

  @override
  List<Object?> get props => [
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4,
        this.ownerMobileNumber,
        this.ownerFirstName,
        this.ownerLastName
      ];
}
