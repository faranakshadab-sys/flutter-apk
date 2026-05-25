import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/qr-code-scanner-controller.dart';

class QrCodeScannerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(QrCodeScannerController(submitExitReportCase: Get.find()));
  }
}
