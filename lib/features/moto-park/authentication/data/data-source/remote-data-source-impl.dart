import 'package:dio/dio.dart' hide DioException;
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-connectivity.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/DTO/login-dto.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/data-source/remote-data-source.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/server-response.dart';

class AuthenticationRemoteDatasourceImpl
    extends AuthenticationRemoteDatasource {
  @override
  Future<Either<AppExceptions, LoginDTO>> login(
      {required String username, required String password}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {"username": username, "password": password};

        var response =
            await AppDio.instance.post("api/Identity/Login", data: data);

        ServerResponse<LoginDTO> objectResponse =
            ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData!);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(DissconnectException(
          message: "dissconnect-error-message".tr,
        ));
      }
    } on DioException catch (e) {
      return Left(DioException(message: e.message ?? ""));
    } catch (e) {
      return Left(ServerException(message: e.toString()));
    }
  }
}
