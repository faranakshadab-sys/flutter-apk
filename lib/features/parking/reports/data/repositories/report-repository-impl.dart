import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:parkingandroid/core/exceptions/app-failure.dart';
import 'package:dartz/dartz.dart';

import '../../../common/domain/models/report-view-model.dart';
import '../../domain/model/report-information-model.dart';
import '../../domain/repositories/report-repository.dart';
import '../data-source/remote-datasource.dart';

class ReportRepositoryImpl extends ReportRepository {
  final ReportRemoteDatasource remoteDatasource;

  ReportRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<AppFailure, ReportInformationModel>> reportInformation(
      {required int reportId}) async {
    var response = await remoteDatasource.reportInformation(reportId: reportId);

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

      ReportInformationModel model = ReportInformationModel(
          createdAt: success.createdAt,
          firstImageTakenAt: success.images.first.createdAt,
          id: success.id,
          images: images,
          imagesCount: success.imagesCount,
          lastImageTakenAt: success.images.last.createdAt,
          latitude: success.latitude,
          longitude: success.longitude,
          paymentStatus: success.paymentStatus,
          plateNumberPart1: success.plateNumberPart1,
          plateNumberPart2: success.plateNumberPart2,
          plateNumberPart3: success.plateNumberPart3,
          plateNumberPart4: success.plateNumberPart4,
          totalAmount: success.totalAmount.toInt(),
          totalParkTime: success.totalParkTime,
          totalParkTimeText: success.totalParkTimeText,
          address: success.fullAddress,
          isMobileNumberRegistered: success.isMobileNumberRegistered,
          paymentStatusText: success.paymentStatusText);

      return Right(model);
    });
  }
}
