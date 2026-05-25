import 'package:get/get.dart';
import 'package:parkingandroid/core/constance/strings.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/data-source/remote-data-source-impl.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/data-source/remote-data-source.dart';
import 'package:parkingandroid/features/moto-park/authentication/data/repositories/authentication-repository-impl.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/repositories/authentication-repository.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/use-cases/login-case.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/use-cases/save-information-case.dart';
import 'package:parkingandroid/features/moto-park/common/data/data-source/remote-datasource-impl.dart';
import 'package:parkingandroid/features/moto-park/common/data/data-source/remote-datasource.dart';
import 'package:parkingandroid/features/moto-park/common/data/repositories/common-repository-impl.dart';
import 'package:parkingandroid/features/moto-park/common/domain/repositories/common-repository.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/add-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/delete-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/get-plate-identities-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/get-reports-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/submit-payment-status-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/update-plate-case.dart';
import 'package:parkingandroid/features/moto-park/home/data/data-source/remote-datasource-impl.dart';
import 'package:parkingandroid/features/moto-park/home/data/data-source/remote-datasource.dart';
import 'package:parkingandroid/features/moto-park/home/data/repository/home-repository-impl.dart';
import 'package:parkingandroid/features/moto-park/home/domain/repositories/home-repository.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/detect-plate-base64-case.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/detect-plate-bytes-case.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/profile-information-case.dart';
import 'package:parkingandroid/features/moto-park/reports/data/data-source/remote-datasource-impl.dart';
import 'package:parkingandroid/features/moto-park/reports/data/data-source/remote-datasource.dart';
import 'package:parkingandroid/features/moto-park/reports/data/repositories/report-repository-impl.dart';
import 'package:parkingandroid/features/moto-park/reports/domain/repositories/report-repository.dart';
import 'package:parkingandroid/features/moto-park/reports/domain/use-cases/report-information-case.dart';

class AppMotoParkBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put<AuthenticationRemoteDatasource>(
        AuthenticationRemoteDatasourceImpl());

    Get.put<AuthenticationRepository>(AuthenticationRepositoryImpl(
        localDatasource: Get.find(), remoteDatasource: Get.find()));

    Get.put(LoginCase(repository: Get.find()));

    Get.put<SaveUserInformationCase>(
        SaveUserInformationCase(repository: Get.find()));

    Get.put<CommonRemoteDatasource>(CommonRemoteDatasourceImpl());

    Get.put<CommonRepository>(
        CommonRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<GetReportsCase>(GetReportsCase(repository: Get.find()));

    Get.put<GetPlateIdentitiesCase>(
        GetPlateIdentitiesCase(repository: Get.find()));

    Get.put<AddPlateIdentityCase>(AddPlateIdentityCase(repository: Get.find()));

    Get.put<SubmitPaymentStatusCase>(
        SubmitPaymentStatusCase(repository: Get.find()));

    Get.put<UpdatePlateCase>(UpdatePlateCase(repository: Get.find()));

    Get.put<HomeRemoteDatasource>(HomeRemoteDatasourceImpl());

    Get.put<HomeRepository>(HomeRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<DetectPlateBase64Case>(
        DetectPlateBase64Case(repository: Get.find()));

    Get.put<DetectPlateBytesCase>(DetectPlateBytesCase(repository: Get.find()));

    Get.put<ProfileInformationCase>(
        ProfileInformationCase(repository: Get.find()));

    Get.put<ReportRemoteDatasource>(ReportRemoteDatasourceImpl());

    Get.put<ReportRepository>(
        ReportRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<ReportInformationCase>(
        ReportInformationCase(repository: Get.find()));

    Get.put<DeletePlateIdentityCase>(
        DeletePlateIdentityCase(repository: Get.find()));

    await AppDio.init(url: REMOTEMOTOPARKDOMAIN);
  }
}
