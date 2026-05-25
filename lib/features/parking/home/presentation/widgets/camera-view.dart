import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/home-controller.dart';
import 'package:skeletons/skeletons.dart';

class CameraView extends StatelessWidget {
  final CameraController? controller;
  final void Function() resetRequestRunning;

  CameraView({required this.controller, required this.resetRequestRunning});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.82,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          controller != null && controller!.value.isInitialized
              ? OverflowBox(
                  alignment: Alignment.center,
                  child: Container(
                      width: size.width,
                      height: size.height * 0.82,
                      child: CameraPreview(controller!)))
              : builaCameraLoading(size),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: size.width * 0.3,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    buildFlashButton(context, size, controller),
                    GetBuilder<HomeController>(builder: (controller) {
                      return Material(
                        color: controller.isAuto
                            ? Colors.white
                            : Color(0xff969BA3),
                        borderRadius: BorderRadius.circular(size.width * 0.32),
                        child: InkWell(
                          onTapDown: (details) {
                            controller.updateIsAuto(true);
                          },
                          onTapUp: (details) {
                            controller.updateIsAuto(false);
                          },
                          borderRadius:
                              BorderRadius.circular(size.width * 0.32),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInCubic,
                            width: controller.isAuto
                                ? size.width * 0.3
                                : size.width * 0.18,
                            height: controller.isAuto
                                ? size.width * 0.3
                                : size.width * 0.18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.isAuto
                                        ? Color(0xff35d679)
                                        : Colors.white,
                                    width: 6),
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.32)),
                            child: !controller.isAuto
                                ? Container()
                                : Icon(
                                    Icons.square,
                                    color: Theme.of(context).primaryColor,
                                  ),
                          ),
                        ),
                      );
                    }),
                    buildQrCodeScannerButton(context, controller),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  SkeletonLine builaCameraLoading(Size size) {
    return SkeletonLine(
      style: SkeletonLineStyle(
          width: size.width,
          height: size.height * 0.76,
          borderRadius: BorderRadius.circular(8)),
    );
  }

  GetBuilder buildFlashButton(
      BuildContext context, Size size, CameraController? cameraController) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Material(
        color: Color(0xff1A253A),
        borderRadius: BorderRadius.circular(size.width),
        child: InkWell(
          onTap: () {
            if (controller.isFlashModeOn) {
              cameraController?.setFlashMode(FlashMode.off);
              controller.updateIsFlashMode(!controller.isFlashModeOn);
            } else {
              cameraController?.setFlashMode(FlashMode.torch);
              controller.updateIsFlashMode(!controller.isFlashModeOn);
            }
          },
          borderRadius: BorderRadius.circular(size.width),
          child: Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            child: Icon(
              controller.isFlashModeOn
                  ? Icons.flashlight_on_rounded
                  : Icons.flashlight_off_rounded,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  GetBuilder buildQrCodeScannerButton(
      BuildContext context, CameraController? cameraController) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(builder: (controller) {
      return Material(
          color: Color(0xff1A253A),
          borderRadius: BorderRadius.circular(size.width),
          child: InkWell(
            onTap: () {
              // if (controller.lastReport != null) {
              Get.toNamed("/qr-scanner", id: 1)
                  ?.then((value) => cameraController?.initialize());
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
                Icons.qr_code,
                color: Colors.white,
              ),
            ),
          ));
    });
  }
}
