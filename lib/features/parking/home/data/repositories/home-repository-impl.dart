import 'dart:typed_data';

import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/parking/home/domain/models/create-enter-report-model.dart';
import 'package:parkingandroid/features/parking/home/domain/models/detected-plate-model.dart';
import 'package:parkingandroid/features/parking/home/domain/models/submit-exit-report-model.dart';
import '../../domain/models/profile-model.dart';
import '../../domain/repositories/home-repository.dart';
import '../data-source/remote-datasource.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, DetectedPlateModel?>> detectPlateBytes({
    required Uint8List image,
  }) async {
    var response = await remoteDatasource.detectPlateBytes(
      image: image,
    );

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
      if (success != null) {
        DetectedPlateModel model = DetectedPlateModel(
            base64Image: success.base64Image, plateNumber: success.plateNumber);

        return Right(model);
      } else {
        return Right(null);
      }
    });
  }

  @override
  Future<Either<AppFailure, ProfileModel>> profileInformation() async {
    var response = await remoteDatasource.profileInformation();

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
      ProfileModel model = ProfileModel(
          firstName: success.firstName,
          lastLoginAt: success.lastLoginAt,
          lastName: success.lastName,
          roleName: success.roleName,
          username: success.username);

      return Right(model);
    });
  }

  @override
  Future<Either<AppFailure, CreateEnterReportModel>> createEnterReport(
      {required String phoneNumber,
      required String plateImage,
      required String plateNumber}) async {
    var response = await remoteDatasource.createEnterReport(
        phoneNumber: phoneNumber,
        plateImage: plateImage,
        plateNumber: plateNumber);

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
      CreateEnterReportModel model = CreateEnterReportModel(
          id: success.id,
          entryDate: success.entryDate,
          parkingAddress: success.parkingAddress,
          parkingName: success.parkingName,
          parkingPhone: success.parkingPhone);
      return Right(model);
    });
  }

  @override
  Future<Either<AppFailure, SubmitExitReportModel>> submitExitReport(
      {required String id, required int paymentType}) async {
    var response = await remoteDatasource.submitExitReport(
        id: id, paymentType: paymentType);

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
      SubmitExitReportModel model = SubmitExitReportModel();
      return Right(model);
    });
  }
}
