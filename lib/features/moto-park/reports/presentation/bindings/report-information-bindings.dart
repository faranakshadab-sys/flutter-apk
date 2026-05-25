import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/controllers/report-information-controller.dart';

class ReportInformationBindings extends Bindings {
  final int reportId;

  ReportInformationBindings({required this.reportId});
  @override
  void dependencies() {
    Get.put<ReportInformationController>(ReportInformationController(
        reportId: reportId,
        addPlateIdentityCase: Get.find(),
        getPlateIdentitiesCase: Get.find(),
        reportInformationCase: Get.find(),
        submitPaymentStatusCase: Get.find(),
        updatePlateCase: Get.find(),
        deletePlateIdentityCase: Get.find()));
  }
}
