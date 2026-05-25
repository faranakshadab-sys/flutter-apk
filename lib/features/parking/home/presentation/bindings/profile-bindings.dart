import 'package:get/get.dart';

import '../controllers/profile-controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(
        ProfileController(profileInformationCase: Get.find()));
  }
}
