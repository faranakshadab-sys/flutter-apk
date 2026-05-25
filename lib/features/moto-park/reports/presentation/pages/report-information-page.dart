import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/number-utility.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-header.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-plate-input.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-time-line.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-report-image-slider.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-report-phone-input.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/controllers/report-information-controller.dart';

class ReportInformationPage extends GetView<ReportInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppHeader(),
        body: GetBuilder<ReportInformationController>(builder: (controller) {
          return AppLoading(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      AppReportPhoneInput(
                        onAddPhoneNumber: controller.addPlateIdentity,
                        phones: controller.phones,
                        onDeletePhone: controller.deletePlateIdentity,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppReportImageSlider(
                        images: controller.reportInformation?.images ?? [],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AppFilledButton(
                            onTab: () async {
                              FocusScope.of(context).unfocus();
                              controller.updatePlate();
                            },
                            title: "edit-button".tr,
                            width: Get.size.width * 0.2,
                            height: Get.size.width * 0.12,
                            isRequestRunning: false,
                            enabled: controller.isEditedPlateNumber,
                          ),
                          RepaintBoundary(
                            key: controller.plateKey,
                            child: AppPlateInput(
                              width: Get.size.width * 0.5,
                              height: Get.size.width * 0.12,
                              plateNumber1: controller.plateNumber1,
                              plateNumber2: controller.plateNumber2,
                              plateNumber3: controller.plateNumber3,
                              plateNumber4: controller.plateNumber4,
                              onChangePlateNumber1:
                                  controller.updatePlateNumber1,
                              onChangePlateNumber2:
                                  controller.updatePlateNumber2,
                              onChangePlateNumber3:
                                  controller.updatePlateNumber3,
                              onChangePlateNumber4:
                                  controller.updatePlateNumber4,
                              isDataChanged: controller.isDataChanged,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      AppTimeLine(
                        enterTime: controller
                                .reportInformation?.firstImageTakenAt
                                .split(" ")
                                .last ??
                            "",
                        exitTime: controller.reportInformation?.lastImageTakenAt
                                .split(" ")
                                .last ??
                            "",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        controller.reportInformation?.totalParkTime ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        controller.reportInformation?.totalParkTimeText ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: Get.size.width * 0.9,
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  blurRadius: 23,
                                  spreadRadius: -5,
                                  offset: Offset(0, 15))
                            ]),
                        child: Text(
                          controller.reportInformation?.address ?? "",
                          style: TextStyle(color: Color(0xffF5F8FF)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            NumberUtility.format(controller
                                    .reportInformation?.totalAmount
                                    .toString() ??
                                ""),
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "rial-text".tr,
                            style: TextStyle(
                                color: Color(0xff969BA3), fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      AppFilledButton(
                        onTab: () async {
                          if (controller.reportInformation != null &&
                              controller.reportInformation!.totalAmount > 0) {
                            await controller.channel.sendTransaction(
                                totalAmount: controller
                                    .reportInformation!.totalAmount
                                    .toString());
                          } else {
                            SnackbarUtility.showSnackbar(
                                message: "payment-zero-error".tr);
                          }
                        },
                        title: "pay-button".tr,
                        isRequestRunning: false,
                        enabled:
                            controller.reportInformation?.paymentStatus == 1,
                      )
                    ],
                  ),
                ),
              ),
              loading: controller.loading);
        }));
  }
}
