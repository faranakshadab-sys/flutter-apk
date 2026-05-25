import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/number-utility.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-qr-view.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/app-header.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/plate-view.dart';
import '../../../common/presentation/widgets/app-report-image-slider.dart';
import '../../../common/presentation/widgets/app-report-phone-input.dart';
import '../../../../common/presentation/widgets/app-time-line.dart';
import '../controllers/report-information-controller.dart';

class ReportInformationPage extends StatefulWidget {
  @override
  State<ReportInformationPage> createState() => _ReportInformationPageState();
}

class _ReportInformationPageState extends State<ReportInformationPage> {
  late ReportInformationController controller;

  @override
  void initState() {
    controller = Get.find<ReportInformationController>();
    controller.getReportInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
                        PlateView(
                          plateNumber1: controller.plateNumber1,
                          plateNumber2: controller.plateNumber2,
                          plateNumber3: controller.plateNumber3,
                          plateNumber4: controller.plateNumber4,
                          width: Get.width * 0.8,
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
                          exitTime: controller
                                  .reportInformation?.lastImageTakenAt
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
                        AppQrCode(
                          reportId: controller.reportId.toString(),
                          onCreateQrCode: (value) {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: size.width * 0.9,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
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
                      ],
                    ),
                  ),
                ),
                loading: controller.loading);
          })),
    );
  }
}
