import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';

// ignore: must_be_immutable
class TestPage extends GetView {
  ReceiptPlatformChannel platformChannel = ReceiptPlatformChannel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppFilledButton(
                isRequestRunning: false,
                onTab: () async {
                  await platformChannel.printMarginalParkPaymentReceipt(
                    totalAmount: "100000",
                    totalParkTime: "10:20:00",
                    paymentStatus: "پرداخت شده",
                    submitDateTime: "1402/01/01 10:22:34",
                    plateImageBytes: "",
                  );
                },
                title: "Motopark payment recipt"),
            SizedBox(
              height: 25,
            ),
            AppFilledButton(
                isRequestRunning: false,
                onTab: () async {
                  await platformChannel.printExitReceipt(
                      entryDate: "entryDate",
                      entryHour: "entryHour",
                      plateBytes: "",
                      totalAmount: "totalAmount",
                      exitHour: "exitHour",
                      exitDate: "exitDate",
                      totalParkTime: "totalParkTime",
                      parkingName: "parkingName",
                      parkingAddress: "parkingAddress",
                      parkingPhone: "parkingPhone",
                      paymentStatusText: "paymentStatusText");
                },
                title: "Parking exit test recipt"),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
