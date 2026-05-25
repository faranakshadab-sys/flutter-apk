import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-plate-input.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-time-line.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/payment-controller.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/information-time.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/payment/payment-type-widget.dart';

import '../widgets/payment/user-profile.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late PaymentController controller;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    controller = Get.find();
    controller.startListener();
    super.initState();
  }

  @override
  void dispose() {
    controller.cancelListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            InformationDateAndTime(),
            SizedBox(
              height: 50,
            ),
            AppTimeLine(
              enterTime: "15:27",
              exitTime: "16:27",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "01:00",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondaryContainer),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "یک ساعت",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Color(0xff969BA3)),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "22,000",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700)),
              TextSpan(
                  text: "تومان",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Color(0xff969BA3)))
            ])),
            SizedBox(
              height: 30,
            ),
            AppPlateInput(
              plateNumber1: "76",
              plateNumber2: "ج",
              plateNumber3: "136",
              plateNumber4: "66",
              onChangePlateNumber1: (value) {},
              onChangePlateNumber2: (value) {},
              onChangePlateNumber3: (value) {},
              onChangePlateNumber4: (value) {},
              width: Get.width * 0.6,
              height: 50,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  width: Get.width * 0.2,
                  height: Get.width * 0.2,
                  decoration: BoxDecoration(
                    color: Color(0xff969BA3),
                    borderRadius: BorderRadius.circular(Get.width),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    FeatherIcons.user,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            UserProfileWidget(),
            SizedBox(
              height: 30,
            ),
            PaymentTypeWidget(
              title: "parking-pay-with-card".tr,
              description: "parking-shetab-member-bank-cards".tr,
            ),
            Spacer(),
            AppFilledButton(
                isRequestRunning: false, onTab: () {}, title: "pay-button".tr),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    ));
  }
}
