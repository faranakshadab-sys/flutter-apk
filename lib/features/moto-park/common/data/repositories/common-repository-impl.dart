import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:dartz/dartz.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/add-plate-identity-model.dart';

import '../../domain/models/plate-identity-model.dart';
import '../../domain/models/report-view-model.dart';
import '../../domain/repositories/common-repository.dart';
import '../data-source/remote-datasource.dart';

class CommonRepositoryImpl extends CommonRepository {
  final CommonRemoteDatasource remoteDatasource;

  CommonRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, List<ReportViewModel>>> getReports(
      {required int page,
      required int pageSize,
      int? plateNumberPart1,
      String? plateNumberPart2,
      int? plateNumberPart3,
      int? plateNumberPart4,
      String? date}) async {
    var response = await remoteDatasource.getReport(
        page: page,
        pageSize: pageSize,
        date: date,
        plateNumberPart1: plateNumberPart1,
        plateNumberPart2: plateNumberPart2,
        plateNumberPart3: plateNumberPart3,
        plateNumberPart4: plateNumberPart4);

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
      List<ReportViewModel> reports = [];

      for (var item in success.items) {
        List<ReportImageViewModel> images = [];

        for (var image in item.images) {
          ReportImageViewModel model = ReportImageViewModel(
              createdAt: image.createdAt,
              id: image.id,
              mainImage: image.mainImage,
              plateImage: image.plateImage);

          images.add(model);
        }

        ReportViewModel model = ReportViewModel(
            createdAt: item.createdAt,
            currentAmount: item.currentAmount,
            debtAmount: item.debtAmount,
            firstImageTakenAt: item.firstImageTakenAt,
            id: item.id,
            images: images,
            imagesCount: item.imagesCount,
            lastImageTakenAt: item.lastImageTakenAt,
            latitude: item.latitude,
            longitude: item.longitude,
            paymentStatus: item.paymentStatus,
            plateNumberPart1: item.plateNumberPart1,
            plateNumberPart2: item.plateNumberPart2,
            plateNumberPart3: item.plateNumberPart3,
            plateNumberPart4: item.plateNumberPart4,
            totalAmount: item.totalAmount,
            totalParkTime: item.totalParkTime,
            totalParkTimeText: item.totalParkTimeText,
            address: item.address,
            isMobileNumberRegistered: item.isMobileNumberRegistered,
            paymentStatusText: item.paymentStatusText);

        reports.add(model);
      }

      return Right(reports);
    });
  }

  @override
  Future<Either<AppFailure, AddPlateIdentityModel>> addPlateIdentity(
      {required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      required String ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName}) async {
    var response = await remoteDatasource.addPlateIdentity(
        plateNumberPart1: plateNumberPart1,
        plateNumberPart2: plateNumberPart2,
        plateNumberPart3: plateNumberPart3,
        plateNumberPart4: plateNumberPart4,
        ownerMobileNumber: ownerMobileNumber,
        ownerFirstName: ownerFirstName,
        ownerLastName: ownerLastName);

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
      AddPlateIdentityModel model = AddPlateIdentityModel(id: success.id);

      return Right(model);
    });
  }

  @override
  Future<Either<AppFailure, List<PlateIdentityModel>>> getPlateIdentity(
      {required int page,
      required int pageSize,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4,
      String? ownerMobileNumber,
      String? ownerFirstName,
      String? ownerLastName}) async {
    var response = await remoteDatasource.getPlateIdentity(
        page: page,
        pageSize: pageSize,
        ownerFirstName: ownerFirstName,
        ownerLastName: ownerLastName,
        ownerMobileNumber: ownerMobileNumber,
        plateNumberPart1: plateNumberPart1,
        plateNumberPart2: plateNumberPart2,
        plateNumberPart3: plateNumberPart3,
        plateNumberPart4: plateNumberPart4);

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
      List<PlateIdentityModel> models = [];

      for (var item in success.items) {
        PlateIdentityModel model = PlateIdentityModel(
            id: item.id,
            ownerFirstName: item.ownerFirstName,
            ownerLastName: item.ownerLastName,
            ownerMobileNumber: item.ownerMobileNumber,
            plateNumberPart1: item.plateNumberPart1,
            plateNumberPart2: item.plateNumberPart2,
            plateNumberPart3: item.plateNumberPart3,
            plateNumberPart4: item.plateNumberPart4);

        models.add(model);
      }

      return Right(models);
    });
  }

  @override
  Future<Either<AppFailure, bool>> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String refrenceId}) async {
    var response = await remoteDatasource.submitPaymentStatus(
        reportId: reportId, totalAmount: totalAmount, refrenceId: refrenceId);

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
      return Right(success);
    });
  }

  @override
  Future<Either<AppFailure, ReportViewModel>> updateReport(
      {required int id,
      required int plateNumberPart1,
      required String plateNumberPart2,
      required int plateNumberPart3,
      required int plateNumberPart4}) async {
    var response = await remoteDatasource.updateReport(
      id: id,
      plateNumberPart1: plateNumberPart1,
      plateNumberPart2: plateNumberPart2,
      plateNumberPart3: plateNumberPart3,
      plateNumberPart4: plateNumberPart4,
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
    });
  }

  @override
  Future<Either<AppFailure, int>> deletePlateIdentity({required int id}) async {
    var response = await remoteDatasource.deletePlateIdentity(id: id);

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
      return Right(success);
    });
  }
}
