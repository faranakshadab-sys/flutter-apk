import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-connectivity.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/parking/common/data/DTO/server-response.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/parking/common/data/data-source/remote-datasource.dart';

import '../DTO/add-plate-identity-dto.dart';
import '../DTO/plate-identity-dto.dart';
import '../DTO/reports-dto.dart';

class CommonRemoteDatasourceImpl extends CommonRemoteDatasource {
  @override
  Future<Either<AppExceptions, ReportsDTO>> getReport(
      {required int page,
      required int pageSize,
      int? plateNumberPart1,
      String? plateNumberPart2,
      int? plateNumberPart3,
      int? plateNumberPart4,
      String? date}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "page": page,
          "pageSize": pageSize,
          "plateNumberPart1": plateNumberPart1,
          "plateNumberPart2": plateNumberPart2,
          "plateNumberPart3": plateNumberPart3,
          "plateNumberPart4": plateNumberPart4,
          "date": date
        };

        var response =
            await AppDio.instance.post("api/Report/GetAll", data: data);

        ServerResponse<ReportsDTO> objectResponse =
            ServerResponse.fromJson(response.data!);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData!);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(
            DissconnectException(message: "dissconnect-error-message".tr));
      }
    } on DioError catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, AddPlateIdentityDTO>> addPlateIdentity(
      {required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      required String ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "plateNumberPart1": plateNumberPart1,
          "plateNumberPart2": plateNumberPart2,
          "plateNumberPart3": plateNumberPart3,
          "plateNumberPart4": plateNumberPart4,
          "ownerMobileNumber": ownerMobileNumber,
          "ownerFirstName": ownerFirstName,
          "ownerLastName": ownerLastName
        };

        var response =
            await AppDio.instance.post("api/PlateIdentity/Create", data: data);

        ServerResponse<AddPlateIdentityDTO> objectResponse =
            ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData!);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(
            DissconnectException(message: "dissconnect-error-message".tr));
      }
    } on DioError catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, PlateIdentityDTO>> getPlateIdentity(
      {required int page,
      required int pageSize,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      String? ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "page": page,
          "pageSize": pageSize,
          "plateNumberPart1": plateNumberPart1,
          "plateNumberPart2": plateNumberPart2,
          "plateNumberPart3": plateNumberPart3,
          "plateNumberPart4": plateNumberPart4,
          "ownerMobileNumber": ownerMobileNumber,
          "ownerFirstName": ownerFirstName,
          "ownerLastName": ownerLastName
        };

        var response =
            await AppDio.instance.post("api/PlateIdentity/GetAll", data: data);

        ServerResponse<PlateIdentityDTO> objectResponse =
            ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData!);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(
            DissconnectException(message: "dissconnect-error-message".tr));
      }
    } on DioError catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, bool>> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String referenceId}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "reportId": reportId,
          "totalAmount": totalAmount,
          "refrenceId": referenceId
        };

        var response =
            await AppDio.instance.post("api/Payment/Create", data: data);

        ServerResponse objectResponse = ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.isSucceeded);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(
            DissconnectException(message: "dissconnect-error-message".tr));
      }
    } on DioError catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, Report>> exitVehicle({required int id}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {"reportId": id};

        var response = await AppDio.instance.post("", data: data);

        ServerResponse<Report> objectResponse =
            ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData!);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(ServerException(message: "dissconnect-error-message".tr));
      }
    } on DioError catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }
}
