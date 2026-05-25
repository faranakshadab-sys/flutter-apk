import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/app-header.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/information-time.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../controllers/qr-code-scanner-controller.dart';

class QrCodeScannerPage extends GetView<QrCodeScannerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrCodeScannerController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppHeader(),
            body: Column(children: [
              InformationDateAndTime(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.68,
                child: QRView(
                  key: controller.qrKey,
                  onQRViewCreated: controller.onQRViewCreated,
                ),
              ),
              Container(
                width: Get.width,
                height: Get.width * 0.3,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildFlashButton(context, Get.size),
                    Material(
                      color: Color(0xff969BA3),
                      borderRadius: BorderRadius.circular(Get.width * 0.32),
                      child: InkWell(
                        onTapDown: (details) {
                          // controller.updateIsAuto(true);
                        },
                        onTapUp: (details) {
                          // controller.updateIsAuto(false);
                        },
                        onTap: () {
                          Get.toNamed("/payment", id: 1);
                        },
                        borderRadius: BorderRadius.circular(Get.width * 0.32),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInCubic,
                          width: Get.width * 0.18,
                          height: Get.width * 0.18,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 6),
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.32)),
                          child: Container(),
                        ),
                      ),
                    ),
                    buildPlateScannerButton(context),
                  ],
                ),
              )
            ]),
          ),
        );
      },
    );
  }

  Widget buildFlashButton(
    BuildContext context,
    Size size,
  ) {
    return Material(
      color: Color(0xff1A253A),
      borderRadius: BorderRadius.circular(size.width),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(size.width),
        child: Container(
          width: size.width * 0.12,
          height: size.width * 0.12,
          child: Icon(
            Icons.flashlight_off_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildPlateScannerButton(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;

    return Material(
        color: Color(0xff1A253A),
        borderRadius: BorderRadius.circular(size.width),
        child: InkWell(
          onTap: () {
            // if (controller.lastReport != null) {
            // Get.toNamed("/qr-scanner", id: 1)
            //     ?.then((value) => cameraController?.initialize());
            // }

            // Get.toNamed("/payment", id: 1);

            // Get.bottomSheet(ConfirmInformationModal(),
            //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            //     enableDrag: false,
            //     isDismissible: false,
            //     isScrollControlled: true,
            //     ignoreSafeArea: false);
          },
          borderRadius: BorderRadius.circular(size.width * 0.12),
          child: Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
          ),
        ));
  }
}
