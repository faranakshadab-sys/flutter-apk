import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/number-utility.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-plate-input.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-time-line.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-report-image-slider.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-report-phone-input.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/home-controller.dart';

class ReportBottomSheet extends GetWidget<MotoParkHomeController> {
  final ReceiptPlatformChannel channel = ReceiptPlatformChannel();

  final DraggableScrollableController draggableScrollableController;

  ReportBottomSheet({required this.draggableScrollableController});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
      initialChildSize: .1,
      minChildSize: .1,
      maxChildSize: 1,
      expand: true,
      controller: draggableScrollableController,
      snap: true,
      snapSizes: [
        1,
      ],
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24)),
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    buildBottomSheetHeader(context),
                    SizedBox(
                      height: 20,
                    ),
                    buildBottomSheetBody(context, channel)
                  ],
                ),
              ),
            ));
      },
    );
  }

  GetBuilder buildBottomSheetBody(
      BuildContext context, ReceiptPlatformChannel channel) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<MotoParkHomeController>(builder: (controller) {
      return Container(
        width: size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppReportPhoneInput(
              onAddPhoneNumber: controller.addPlateIdentity,
              phones: controller.phoneNumbers,
              onDeletePhone: controller.deletePlateIdentity,
            ),
            SizedBox(
              height: 25,
            ),
            AppReportImageSlider(
              images: controller.lastReport?.images ?? [],
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
                  width: size.width * 0.2,
                  height: size.width * 0.12,
                  isRequestRunning: false,
                  enabled: controller.isEditedPlateNumber,
                ),
                RepaintBoundary(
                  key: controller.plateKey,
                  child: AppPlateInput(
                    width: size.width * 0.5,
                    height: size.width * 0.12,
                    plateNumber1:
                        controller.lastReport?.plateNumberPart1.toString() ??
                            "",
                    plateNumber2: controller.lastReport?.plateNumberPart2 ?? "",
                    plateNumber3:
                        controller.lastReport?.plateNumberPart3.toString() ??
                            "",
                    plateNumber4:
                        controller.lastReport?.plateNumberPart4.toString() ??
                            "",
                    onChangePlateNumber1: controller.updatePlatePartNumber1,
                    onChangePlateNumber2: controller.updatePlatePartNumber2,
                    onChangePlateNumber3: controller.updatePlatePartNumber3,
                    onChangePlateNumber4: controller.updatePlatePartNumber4,
                    isDataChanged: controller.isDataChanged,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            AppTimeLine(
              enterTime:
                  controller.lastReport?.firstImageTakenAt.split(" ").last ??
                      "",
              exitTime:
                  controller.lastReport?.lastImageTakenAt.split(" ").last ?? "",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              controller.lastReport?.totalParkTime ?? "",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              controller.lastReport?.totalParkTimeText ?? "",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width * 0.9,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).colorScheme.background,
                        blurRadius: 23,
                        spreadRadius: -5,
                        offset: Offset(0, 15))
                  ]),
              child: Text(
                controller.lastReport?.address ?? "",
                style: TextStyle(color: Color(0xffF5F8FF)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  NumberUtility.format(
                      controller.lastReport?.totalAmount.toString() ?? ""),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "rial-text".tr,
                  style: TextStyle(color: Color(0xff969BA3), fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            AppFilledButton(
              onTab: () async {
                if (controller.lastReport != null &&
                    controller.lastReport!.totalAmount > 0 &&
                    controller.lastReport!.paymentStatus != 2) {
                  await channel.sendTransaction(
                      totalAmount:
                          controller.lastReport!.totalAmount.toString());
                } else {
                  SnackbarUtility.showSnackbar(
                      message: "payment-zero-error".tr);
                }
              },
              title: "pay-button".tr,
              isRequestRunning: false,
              enabled: controller.lastReport != null &&
                  controller.lastReport!.totalAmount > 0 &&
                  controller.lastReport!.paymentStatus != 2,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    });
  }

  Container buildBottomSheetHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width * 0.2,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.width * 0.04),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.2,
            height: 4,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(1)),
          ),
        ],
      ),
    );
  }
}
