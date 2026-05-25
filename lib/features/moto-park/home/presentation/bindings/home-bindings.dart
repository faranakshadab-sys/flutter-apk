import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/controllers/user-controller.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/home-controller.dart';

class MotoParkHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MotoParkHomeController>(MotoParkHomeController(
        getReportsCase: Get.find(),
        detectPlateBase64Case: Get.find(),
        detectPlateBytesCase: Get.find(),
        submitPaymentStatusCase: Get.find(),
        getPlateIdentitiesCase: Get.find(),
        updatePlateCase: Get.find(),
        addPlateIdentityCase: Get.find(),
        deletePlateIdentityCase: Get.find(),
        uniqueIdentifier: Get.find<UserController>().uniqueIdentifier));
  }
}
