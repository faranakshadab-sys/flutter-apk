import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../models/plate-identity-model.dart';
import '../repositories/common-repository.dart';

class GetPlateIdentitiesCase extends AppUseCase<
    Either<AppFailure, List<PlateIdentityModel>>,
    GetPlateIdentitiesCaseParams> {
  final CommonRepository repository;

  GetPlateIdentitiesCase({required this.repository});

  @override
  Future<Either<AppFailure, List<PlateIdentityModel>>> call(
      {required GetPlateIdentitiesCaseParams params}) async {
    return await repository.getPlateIdentity(
      page: params.page,
      pageSize: params.pageSize,
      ownerFirstName: params.ownerFirstName,
      ownerLastName: params.ownerLastName,
      ownerMobileNumber: params.ownerMobileNumber,
      plateNumberPart1: params.plateNumberPart1,
      plateNumberPart2: params.plateNumberPart2,
      plateNumberPart3: params.plateNumberPart3,
      plateNumberPart4: params.plateNumberPart4,
    );
  }
}

class GetPlateIdentitiesCaseParams extends Equatable {
  final int page;
  final int pageSize;
  final int plateNumberPart1;
  final String plateNumberPart2;
  final int plateNumberPart3;
  final int plateNumberPart4;
  final String? ownerMobileNumber;
  final String? ownerFirstName;
  final String? ownerLastName;

  GetPlateIdentitiesCaseParams(
      {required this.page,
      required this.pageSize,
      required this.plateNumberPart1,
      required this.plateNumberPart2,
      required this.plateNumberPart3,
      required this.plateNumberPart4,
      this.ownerFirstName,
      this.ownerLastName,
      this.ownerMobileNumber});

  @override
  List<Object?> get props => [
        this.page,
        this.pageSize,
        this.plateNumberPart1,
        this.plateNumberPart2,
        this.plateNumberPart3,
        this.plateNumberPart4,
        this.ownerFirstName,
        this.ownerLastName,
        this.ownerMobileNumber
      ];
}
