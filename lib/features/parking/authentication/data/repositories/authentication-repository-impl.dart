import 'package:parkingandroid/core/exceptions/app-exception.dart';

import 'package:parkingandroid/core/exceptions/app-failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/model/login-model.dart';
import '../../domain/repositories/authentication-repository.dart';
import '../data-sources/local-data-source.dart';
import '../data-sources/remote-data-source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDatasource remoteDatasource;
  final AuthenticationLocalDatasource localDatasource;

  AuthenticationRepositoryImpl(
      {required this.remoteDatasource, required this.localDatasource});

  @override
  Future<Either<AppFailure, LoginModel>> login(
      {required String username, required String password}) async {
    var response =
        await remoteDatasource.login(username: username, password: password);

    return response.fold((exception) {
      if (exception is LocalException) {
        return Left(LocalFailure(
            message: exception.message, statusCode: exception.statusCode));
      }

      if (exception is DissconnectException) {
        return Left(DissconnectFailure(
            message: exception.message, statusCode: exception.statusCode));
      }

      if (exception is DioException) {
        return Left(DioFailure(
            message: exception.message, statusCode: exception.statusCode));
      }

      return Left(ServerFailure(
          message: exception.message, statusCode: exception.statusCode));
    }, (success) {
      LoginModel response = LoginModel(
          fullName: success.fullName,
          roleName: success.roleName,
          uniqueIdentifier: success.uniqueIdentifier,
          accessToken: success.accessToken,
          refreshToken: success.refreshToken);

      return Right(response);
    });
  }

  @override
  Future<Either<AppFailure, bool>> saveUserInformation({
    required String accessToken,
    required String refreshToken,
  }) async {
    var response = await localDatasource.saveUserInformation(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );

    return response.fold(
        (exception) => Left(LocalFailure(message: exception.message)),
        (succes) => Right(succes));
  }
}
