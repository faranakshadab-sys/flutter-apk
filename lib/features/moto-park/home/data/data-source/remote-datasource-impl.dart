import 'dart:typed_data';

import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-connectivity.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/server-response.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/moto-park/home/data/data-source/remote-datasource.dart';

import '../DTO/profile-dto.dart';
import '../DTO/report-dto.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  @override
  Future<Either<AppExceptions, ReportDTO?>> detectPlateBase64(
      {required String image,
      required double lat,
      required double long,
      required String uniqueIdentifier}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = {
          "image": image,
          "longitude": long,
          "latitude": lat,
          "uniqueIdentifier": uniqueIdentifier
        };

        var response = await AppDio.instance
            .post("api/Detection/DetectBase64", data: data);

        ServerResponse<ReportDTO> objectResponse =
            ServerResponse.fromJson(response.data!);

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
    } on Dio.DioException catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }

  @override
  Future<Either<AppExceptions, ReportDTO?>> detectPlateBytes(
      {required Uint8List image,
      required double lat,
      required double long,
      required String uniqueIdentifier}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        var data = Dio.FormData.fromMap({
          'Image': Dio.MultipartFile.fromBytes(image, filename: 'test.jpg'),
          "Longitude": long,
          "Latitude": lat,
          "UniqueIdentifier": uniqueIdentifier
        });

        var response =
            await AppDio.instance.post("api/Detection/DetectBytes", data: data);

        ServerResponse<ReportDTO> objectResponse =
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
    } on Dio.DioException catch (exception) {
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
    } on Dio.DioException catch (exception) {
      return Left(DioException(message: exception.message.toString()));
    } catch (exception) {
      return Left(LocalException(message: exception.toString()));
    }
  }
}
