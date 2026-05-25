import 'package:get/get.dart';

import '../controllers/reports-controller.dart';

class ReportsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ReportsController>(ReportsController(getReportsCase: Get.find()));
  }
}
