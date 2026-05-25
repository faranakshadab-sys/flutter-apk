import 'package:dartz/dartz.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';

abstract class AuthenticationLocalDatasource {
  Future<Either<AppExceptions, bool>> saveUserInformation({
    required String accessToken,
    required String refreshToken,
  });
}
