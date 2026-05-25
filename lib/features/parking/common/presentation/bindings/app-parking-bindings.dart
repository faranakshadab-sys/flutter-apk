import 'package:get/get.dart';
import 'package:parkingandroid/core/constance/strings.dart';
import 'package:parkingandroid/core/utilities/app-dio.dart';
import 'package:parkingandroid/features/parking/common/domain/use-cases/check-report-id-case.dart';
import 'package:parkingandroid/features/parking/home/domain/use-cases/create-enter-report-case.dart';
import 'package:parkingandroid/features/parking/home/domain/use-cases/submit-exit-report-case.dart';
import '../../../authentication/data/data-sources/local-data-source-impl.dart';
import '../../../authentication/data/data-sources/local-data-source.dart';
import '../../../authentication/data/data-sources/remote-data-source-impl.dart';
import '../../../authentication/data/data-sources/remote-data-source.dart';
import '../../../authentication/data/repositories/authentication-repository-impl.dart';
import '../../../authentication/domain/repositories/authentication-repository.dart';
import '../../../authentication/domain/use-cases/login-case.dart';
import '../../../authentication/domain/use-cases/save-information-case.dart';
import '../../../home/data/data-source/remote-datasource-impl.dart';
import '../../../home/data/data-source/remote-datasource.dart';
import '../../../home/data/repositories/home-repository-impl.dart';
import '../../../home/domain/repositories/home-repository.dart';
import '../../../home/domain/use-cases/detect-plate-bytes-case.dart';
import '../../../home/domain/use-cases/profile-information-case.dart';
import '../../../reports/data/data-source/remote-datasource-impl.dart';
import '../../../reports/data/data-source/remote-datasource.dart';
import '../../../reports/data/repositories/report-repository-impl.dart';
import '../../../reports/domain/repositories/report-repository.dart';
import '../../../reports/domain/use-cases/report-information-case.dart';
import '../../data/data-source/remote-datasource-impl.dart';
import '../../data/data-source/remote-datasource.dart';
import '../../data/repositories/common-repository-impl.dart';
import '../../domain/repositories/common-repository.dart';
import '../../domain/use-cases/add-plate-identity-case.dart';
import '../../domain/use-cases/get-plate-identities-case.dart';
import '../../domain/use-cases/get-reports-case.dart';
import '../../domain/use-cases/submit-payment-status-case.dart';

class AppParkingBindings implements Bindings {
  @override
  Future dependencies() async {
    Get.put<AuthenticationRemoteDatasource>(
        AuthenticationRemoteDatasourceImpl());

    Get.put<AuthenticationLocalDatasource>(AuthenticationLocalDatasourceImpl());

    Get.put<AuthenticationRepository>(AuthenticationRepositoryImpl(
        remoteDatasource: Get.find<AuthenticationRemoteDatasource>(),
        localDatasource: Get.find<AuthenticationLocalDatasource>()));

    Get.put<SaveUserInformationCase>(SaveUserInformationCase(
        repository: Get.find<AuthenticationRepository>()));

    Get.put<LoginCase>(
        LoginCase(repository: Get.find<AuthenticationRepository>()));

    Get.put<CommonRemoteDatasource>(CommonRemoteDatasourceImpl());

    Get.put<CommonRepository>(
        CommonRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<GetReportsCase>(GetReportsCase(repository: Get.find()));

    Get.put<GetPlateIdentitiesCase>(
        GetPlateIdentitiesCase(repository: Get.find()));

    Get.put<AddPlateIdentityCase>(AddPlateIdentityCase(repository: Get.find()));

    Get.put<SubmitPaymentStatusCase>(
        SubmitPaymentStatusCase(repository: Get.find()));

    Get.put<HomeRemoteDatasource>(HomeRemoteDatasourceImpl());

    Get.put<HomeRepository>(HomeRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<DetectPlateBytesCase>(DetectPlateBytesCase(repository: Get.find()));

    Get.put<ProfileInformationCase>(
        ProfileInformationCase(repository: Get.find()));

    Get.put<ReportRemoteDatasource>(ReportRemoteDatasourceImpl());

    Get.put<ReportRepository>(
        ReportRepositoryImpl(remoteDatasource: Get.find()));

    Get.put<ReportInformationCase>(
        ReportInformationCase(repository: Get.find()));

    Get.put<ExitVehicleCase>(ExitVehicleCase(repository: Get.find()));

    Get.put<CreateEnterReportCase>(
        CreateEnterReportCase(repository: Get.find()));

    Get.put<SubmitExitReportCase>(SubmitExitReportCase(repository: Get.find()));

    await AppDio.init(url: LOCALPARKINGDOMAIN);
  }
}
