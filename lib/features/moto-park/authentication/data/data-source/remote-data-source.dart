import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/DTO/login-dto.dart';

abstract class AuthenticationRemoteDatasource {
  Future<Either<AppExceptions, LoginDTO>> login(
      {required String username, required String password});
}
