import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';

import '../model/login-model.dart';

abstract class AuthenticationRepository {
  Future<Either<AppFailure, LoginModel>> login(
      {required String username, required String password});

  Future<Either<AppFailure, bool>> saveUserInformation({
    required String accessToken,
    required String refreshToken,
  });
}
