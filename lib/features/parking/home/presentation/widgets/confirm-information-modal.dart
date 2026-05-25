import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/home-controller.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/confirm-information-view.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/print-receipt-view.dart';

class ConfirmInformationModal extends StatelessWidget {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SafeArea(
          child: Container(
        width: Get.width,
        height: Get.height,
        child: PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ConfirmInformationView(),
              PrintReceiptView(),
            ]),
      ));
    });
  }
}
