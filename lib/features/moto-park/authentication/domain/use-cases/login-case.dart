import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:parkingandroid/core/utilities/app-use-case.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/models/login-model.dart';

import '../repositories/authentication-repository.dart';

class LoginCase
    extends AppUseCase<Either<AppFailure, LoginModel>, LoginCaseParams> {
  final AuthenticationRepository repository;

  LoginCase({required this.repository});

  @override
  Future<Either<AppFailure, LoginModel>> call(
      {required LoginCaseParams params}) async {
    return await repository.login(
        username: params.username, password: params.password);
  }
}

class LoginCaseParams extends Equatable {
  final String username;
  final String password;

  LoginCaseParams({required this.password, required this.username});

  @override
  List<Object?> get props => [this.password, this.username];
}
