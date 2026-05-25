import 'dart:typed_data';

import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-connectivity.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/core/utilities/plate-detection-dio.dart';
import 'package:parkingandroid/features/parking/common/data/DTO/server-response.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/create-enter-report-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/detected-plate-dto.dart';
import 'package:parkingandroid/features/parking/home/data/DTO/submit-exit-report-dto.dart';
import 'package:parkingandroid/features/parking/home/data/data-source/remote-datasource.dart';

import '../DTO/profile-dto.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  Future<Either<AppExceptions, DetectedPlateDTO?>> detectPlateBytes({
    required Uint8List image,
  }) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = Dio.FormData.fromMap({
          'Image': Dio.MultipartFile.fromBytes(image, filename: 'test.jpg'),
        });
        var response =
            await PlateDetectionDio.instance.post("api/lpr", data: data);

        ServerResponse<DetectedPlateDTO> objectResponse =
            ServerResponse.fromJson(response.data);

        if (objectResponse.isSucceeded) {
          return Right(objectResponse.apiData);
        } else {
          return Left(
              ServerException(message: objectResponse.apiErrors.join("-")));
        }
      } else {
        return Left(
            DissconnectException(message: "dissconnect-error-message".tr));
      }
    } on Dio.DioError catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, ProfileDTO>> profileInformation() async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var response = await AppDio.instance.get(
          "api/Profile/Get",
        );

        ServerResponse<ProfileDTO> objectResponse =
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
    } on Dio.DioError catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, CreateEnterReportDTO>> createEnterReport(
      {required String phoneNumber,
      required String plateImage,
      required String plateNumber}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "phoneNumber": phoneNumber,
          "image": plateImage,
          "plate": plateNumber
        };

        var response =
            await AppDio.instance.post("api/Report/Create", data: data);

        ServerResponse<CreateEnterReportDTO> objectResponse =
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
    } on Dio.DioError catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, SubmitExitReportDTO>> submitExitReport(
      {required String id, required int paymentType}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {"id": id};

        var response =
            await AppDio.instance.post("api/Report/Exit", data: data);

        ServerResponse<SubmitExitReportDTO> objectResponse =
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
    } on Dio.DioError catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }
}
