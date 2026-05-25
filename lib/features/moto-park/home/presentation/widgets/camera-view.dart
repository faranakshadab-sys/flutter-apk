import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/home-controller.dart';
import 'package:skeletons/skeletons.dart';

class CameraView extends GetWidget<MotoParkHomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.82,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          GetBuilder<MotoParkHomeController>(builder: (contoller) {
            return Container(
              child: controller.cameraController != null &&
                      controller.cameraController!.value.isInitialized
                  ? OverflowBox(
                      alignment: Alignment.center,
                      child: Container(
                          width: size.width,
                          height: size.height * 0.82,
                          child: CameraPreview(controller.cameraController!)))
                  : builaCameraLoading(size),
            );
          }),
          Positioned(
              left: 0,
              bottom: Get.width * 0.12,
              child: Container(
                width: size.width,
                height: size.width * 0.4,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildNightModeButton(context, size, controller),
                    GetBuilder<MotoParkHomeController>(builder: (controller) {
                      return Material(
                        color: controller.isAuto
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(size.width * 0.32),
                        child: InkWell(
                          onTapDown: (details) {
                            if (controller.isLastLocationRecived) {
                              if (controller.isNightModeOn) {
                                controller.cameraController
                                    ?.setFlashMode(FlashMode.torch);
                              }
                              controller.updateIsAuto(true);
                            } else {
                              SnackbarUtility.showSnackbar(
                                  message: "location-loading-message".tr);
                              controller.startLocationStream();
                            }
                          },
                          onTapUp: (details) {
                            if (controller.isNightModeOn) {
                              controller.cameraController
                                  ?.setFlashMode(FlashMode.off);
                            }
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
                                    color: !controller.isLastLocationRecived
                                        ? Colors.red
                                        : controller.isAuto
                                            ? Color(0xff35d679)
                                            : Colors.white,
                                    width: 6),
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.32)),
                            child: !controller.isLastLocationRecived
                                ? Icon(
                                    Icons.location_disabled,
                                    color: Colors.white,
                                  )
                                : !controller.isAuto
                                    ? Container()
                                    : Icon(
                                        Icons.square,
                                        color: Theme.of(context).primaryColor,
                                      ),
                          ),
                        ),
                      );
                    }),
                    buildLastReport(size),
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

  GetBuilder buildNightModeButton(
      BuildContext context, Size size, MotoParkHomeController controller) {
    return GetBuilder<MotoParkHomeController>(builder: (controller) {
      return Material(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(size.width),
        child: InkWell(
          onTap: () {
            controller.updateIsNightMode(!controller.isNightModeOn);
          },
          borderRadius: BorderRadius.circular(size.width),
          child: Container(
            width: size.width * 0.12,
            height: size.width * 0.12,
            decoration: BoxDecoration(),
            child: Icon(
              controller.isNightModeOn
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }

  GetBuilder buildLastReport(Size size) {
    return GetBuilder<MotoParkHomeController>(builder: (controller) {
      return InkWell(
        onTap: () {
          if (controller.lastReport != null) {
            Get.toNamed("/reports", id: 2);
          }
        },
        borderRadius: BorderRadius.circular(size.width * 0.12),
        child: controller.lastReport != null
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width * 0.08),
                    border: Border.all(color: Color(0xff969BA3), width: 1)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size.width * 0.08),
                  child: CachedNetworkImage(
                    imageUrl: controller.lastReport!.images.first.mainImage,
                    width: size.width * 0.12,
                    height: size.width * 0.12,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SkeletonLine(
                style: SkeletonLineStyle(
                    width: size.width * 0.12,
                    height: size.width * 0.12,
                    borderRadius: BorderRadius.circular(size.width * 0.12)),
              ),
      );
    });
  }
}
