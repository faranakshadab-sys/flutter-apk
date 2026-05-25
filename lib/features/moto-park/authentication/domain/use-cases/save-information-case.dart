import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';

import '../repositories/authentication-repository.dart';

class SaveUserInformationCase extends AppUseCase<Either<AppFailure, bool>,
    SaveUserInformationCaseParams> {
  final AuthenticationRepository repository;

  SaveUserInformationCase({required this.repository});

  @override
  Future<Either<AppFailure, bool>> call(
      {required SaveUserInformationCaseParams params}) async {
    return await repository.saveUserInformation(
        accessToken: params.accessToken,
        refreshToken: params.refreshToken,
        uniqueIdentifier: params.uniqueIdentifier);
  }
}

class SaveUserInformationCaseParams extends Equatable {
  final String accessToken;
  final String refreshToken;
  final String uniqueIdentifier;

  SaveUserInformationCaseParams(
      {required this.accessToken,
      required this.refreshToken,
      required this.uniqueIdentifier});

  @override
  List<Object?> get props =>
      [this.accessToken, this.refreshToken, this.uniqueIdentifier];
}
