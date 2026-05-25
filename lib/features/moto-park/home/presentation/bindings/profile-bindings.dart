import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/profile-controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(
        ProfileController(profileInformationCase: Get.find()));
  }
}
