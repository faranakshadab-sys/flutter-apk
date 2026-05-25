import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../models/profile-model.dart';
import '../repositories/home-repository.dart';

class ProfileInformationCase extends AppUseCase<
    Either<AppFailure, ProfileModel>, ProfileInformationCaseParams> {
  final HomeRepository repository;

  ProfileInformationCase({required this.repository});

  @override
  Future<Either<AppFailure, ProfileModel>> call(
      {required ProfileInformationCaseParams params}) async {
    return await repository.profileInformation();
  }
}

class ProfileInformationCaseParams extends Equatable {
  @override
  List<Object?> get props => [];
}
