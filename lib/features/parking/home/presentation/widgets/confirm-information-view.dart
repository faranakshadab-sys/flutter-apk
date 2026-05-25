import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-plate-input.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-text-filed.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/home-controller.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/information-time.dart';

class ConfirmInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: GetBuilder<HomeController>(
        builder: (controller) {
          return Container(
            width: Get.width,
            height: Get.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.width * 0.02),
            child: AppScrollView(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppFilledButton(
                        isRequestRunning: false,
                        onTab: () {
                          Get.back();
                        },
                        title: "confirm-information-modal-cancele".tr,
                        color: Color(0xffD32F2F),
                        width: Get.width * 0.2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFiled(
                        hintText: "0912 345 6789",
                        labelText: "parking-create-report-phone".tr,
                        onChangeValue: (value) {},
                        value: "",
                        controller: TextEditingController()),
                    SizedBox(
                      height: 20,
                    ),
                    Image.memory(
                      base64Decode(controller.base64),
                      fit: BoxFit.cover,
                      height: Get.height * 0.45,
                      width: Get.width * 0.9,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RepaintBoundary(
                      key: controller.plateKey,
                      child: AppPlateInput(
                        plateNumber1: controller.plateNumberPart1,
                        plateNumber2: controller.plateNumberPart2,
                        plateNumber3: controller.plateNumberPart3,
                        plateNumber4: controller.plateNumberPart4,
                        onChangePlateNumber1: controller.updatePlatePartNumber1,
                        onChangePlateNumber2: controller.updatePlatePartNumber2,
                        onChangePlateNumber3: controller.updatePlatePartNumber3,
                        onChangePlateNumber4: controller.updatePlatePartNumber4,
                        width: Get.width * 0.8,
                        height: 50,
                        isDataChanged: controller.isDataChanged,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppFilledButton(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        isRequestRunning: false,
                        onTab: () {
                          controller.pageController.animateToPage(2,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.linearToEaseOut);
                        },
                        title: "confirm-information-modal-submit".tr)
                  ]),
            ),
          );
        },
      ),
    );
  }
}
