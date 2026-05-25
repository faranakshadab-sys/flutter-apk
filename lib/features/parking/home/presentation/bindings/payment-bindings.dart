import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/payment-controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PaymentController(
        submitPaymentStatusCase: Get.find(),
        reportInformationCase: Get.find()));
  }
}
