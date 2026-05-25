import 'dart:typed_data';

import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/report-view-model.dart';
import 'package:parkingandroid/features/moto-park/home/domain/models/profile-model.dart';
import 'package:parkingandroid/features/moto-park/home/domain/repositories/home-repository.dart';

import '../data-source/remote-datasource.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, ReportViewModel?>> detectPlateBase64(
      {required String image,
      required double lat,
      required double long,
      required String uniqueIdentifier}) async {
    var response = await remoteDatasource.detectPlateBase64(
        image: image, lat: lat, long: long, uniqueIdentifier: uniqueIdentifier);

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
        List<ReportImageViewModel> images = [];

        for (var image in success.images) {
          ReportImageViewModel model = ReportImageViewModel(
              createdAt: image.createdAt,
              id: image.id,
              mainImage: image.mainImage,
              plateImage: image.plateImage);

          images.add(model);
        }

        ReportViewModel model = ReportViewModel(
          createdAt: success.createdAt,
          currentAmount: success.currentAmount,
          debtAmount: success.debtAmount,
          firstImageTakenAt: success.firstImageTakenAt,
          id: success.id,
          images: images,
          imagesCount: success.imagesCount,
          lastImageTakenAt: success.lastImageTakenAt,
          latitude: success.latitude,
          longitude: success.longitude,
          paymentStatus: success.paymentStatus,
          plateNumberPart1: success.plateNumberPart1,
          plateNumberPart2: success.plateNumberPart2,
          plateNumberPart3: success.plateNumberPart3,
          plateNumberPart4: success.plateNumberPart4,
          totalAmount: success.totalAmount,
          totalParkTime: success.totalParkTime,
          totalParkTimeText: success.totalParkTimeText,
          address: success.address,
          isMobileNumberRegistered: success.isMobileNumberRegistered,
          paymentStatusText: success.paymentStatusText,
        );

        return Right(model);
      } else {
        return Right(null);
      }
    });
  }

  @override
  Future<Either<AppFailure, ReportViewModel?>> detectPlateBytes(
      {required Uint8List image,
      required double lat,
      required double long,
      required String uniqueIdentifier}) async {
    var response = await remoteDatasource.detectPlateBytes(
        image: image, lat: lat, long: long, uniqueIdentifier: uniqueIdentifier);

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
        List<ReportImageViewModel> images = [];

        for (var image in success.images) {
          ReportImageViewModel model = ReportImageViewModel(
              createdAt: image.createdAt,
              id: image.id,
              mainImage: image.mainImage,
              plateImage: image.plateImage);

          images.add(model);
        }

        ReportViewModel model = ReportViewModel(
            createdAt: success.createdAt,
            currentAmount: success.currentAmount,
            debtAmount: success.debtAmount,
            firstImageTakenAt: success.firstImageTakenAt,
            id: success.id,
            images: images,
            imagesCount: success.imagesCount,
            lastImageTakenAt: success.lastImageTakenAt,
            latitude: success.latitude,
            longitude: success.longitude,
            paymentStatus: success.paymentStatus,
            plateNumberPart1: success.plateNumberPart1,
            plateNumberPart2: success.plateNumberPart2,
            plateNumberPart3: success.plateNumberPart3,
            plateNumberPart4: success.plateNumberPart4,
            totalAmount: success.totalAmount,
            totalParkTime: success.totalParkTime,
            totalParkTimeText: success.totalParkTimeText,
            address: success.address,
            isMobileNumberRegistered: success.isMobileNumberRegistered,
            paymentStatusText: success.paymentStatusText);

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
}
