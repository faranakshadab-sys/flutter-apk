import 'package:get/get.dart';
import '../controllers/home-controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
          detectPlateBytesCase: Get.find(), createEnterReportCase: Get.find()),
      permanent: true,
    );
  }
}
