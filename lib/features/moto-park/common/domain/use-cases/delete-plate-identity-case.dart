import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/repositories/common-repository.dart';

class DeletePlateIdentityCase
    extends AppUseCase<Either<AppFailure, int>, DeletePlateIdentityCaseParams> {
  final CommonRepository repository;

  DeletePlateIdentityCase({required this.repository});

  @override
  Future<Either<AppFailure, int>> call(
      {required DeletePlateIdentityCaseParams params}) async {
    return await repository.deletePlateIdentity(id: params.id);
  }
}

class DeletePlateIdentityCaseParams extends Equatable {
  final int id;

  DeletePlateIdentityCaseParams({required this.id});

  @override
  List<Object?> get props => [this.id];
}
