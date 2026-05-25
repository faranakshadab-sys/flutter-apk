import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-qr-view.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/plate-view.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/home-controller.dart';

import 'information-time.dart';

class PrintReceiptView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        width: Get.width,
        height: Get.height,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              InformationDateAndTime(),
              SizedBox(
                height: 25,
              ),
              AppQrCode(
                  reportId: controller.createdReport?.id,
                  onCreateQrCode: controller.onChangeLastReportQrCode),
              SizedBox(
                height: 20,
              ),
              PlateView(
                  width: Get.width * 0.8,
                  plateNumber1: controller.plateNumberPart1,
                  plateNumber2: controller.plateNumberPart2,
                  plateNumber3: controller.plateNumberPart3,
                  plateNumber4: controller.plateNumberPart4),
              Spacer(),
              AppFilledButton(
                  isRequestRunning: false,
                  onTab: () {},
                  title: "print-receipt-text".tr),
              SizedBox(
                height: 40,
              ),
            ]),
      );
    });
  }
}
