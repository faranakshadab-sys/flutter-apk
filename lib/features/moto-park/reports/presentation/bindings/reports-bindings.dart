import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/controllers/reports-controller.dart';

class ReportsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ReportsController>(ReportsController(getReportsCase: Get.find()));
  }
}
