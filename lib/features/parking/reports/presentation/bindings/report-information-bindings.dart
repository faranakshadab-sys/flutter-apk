import 'package:get/get.dart';

import '../controllers/report-information-controller.dart';

class ReportInformationBindings extends Bindings {
  final int reportId;

  ReportInformationBindings({required this.reportId});

  @override
  void dependencies() {
    Get.put<ReportInformationController>(ReportInformationController(
      reportId: reportId,
      reportInformationCase: Get.find(),
      addPlateIdentityCase: Get.find(),
      getPlateIdentitiesCase: Get.find(),
      submitPaymentStatusCase: Get.find(),
    ));
  }
}
