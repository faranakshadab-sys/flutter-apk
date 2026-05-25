import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/authentication/presentation/controllers/login-controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(
        loginCase: Get.find(), saveUserInformationCase: Get.find()));
  }
}
