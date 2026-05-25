import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-connectivity.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/moto-park/reports/data/DTO/report-information-dto.dart';
import 'package:parkingandroid/features/moto-park/reports/data/data-source/remote-datasource.dart';
import 'package:parkingandroid/features/moto-park/common/data/DTO/server-response.dart';
import 'package:parkingandroid/core/exceptions/app-exception.dart';
import 'package:dartz/dartz.dart';

class ReportRemoteDatasourceImpl extends ReportRemoteDatasource {
  @override
  Future<Either<AppExceptions, ReportInformationDTO>> reportInformation(
      {required int reportId}) async {
    try {
      if (await AppConnectivity.checkInternet()) {
        Dio.Response<Map<String, dynamic>> response =
            await AppDio.instance.get("api/Report/GetById?Id=$reportId");
        ServerResponse<ReportInformationDTO> objectResponse =
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
    } on Dio.DioError catch (exception) {
      return Left(DioException(message: exception.message ?? ""));
    } catch (exception) {
      return Left(ServerException(message: exception.toString()));
    }
  }
}
