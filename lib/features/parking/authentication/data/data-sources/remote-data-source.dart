import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import '../DTO/login-dto.dart';

abstract class AuthenticationRemoteDatasource {
  Future<Either<AppExceptions, LoginDTO>> login(
      {required String username, required String password});
}
