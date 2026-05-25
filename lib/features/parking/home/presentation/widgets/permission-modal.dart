import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-text-button.dart';
import 'package:parkingandroid/features/parking/home/presentation/controllers/home-controller.dart';

class PermissionModal extends StatelessWidget {
  final String title;
  final Function initializeCamera;

  const PermissionModal(
      {super.key, required this.title, required this.initializeCamera});

  void permissionAccessHandler() async {
    if (title == "camera-request-permission".tr) {
      bool response =
          await Get.find<HomeController>().requestCameraPermission();
      if (response) {
        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
        }
        initializeCamera();
      } else {
        Get.showSnackbar(GetSnackBar(
          title: "permission-denied-title".tr,
          message: "permission-denied-message".tr,
        ));
      }

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Get.back();
      },
      child: Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: InkWell(
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.22,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05, vertical: size.width * 0.08),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "camera-location-request-permission".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextButton(
                        isRequestRunning: false,
                        onTab: permissionAccessHandler,
                        text: "permission-grant-button".tr,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      AppTextButton(
                        isRequestRunning: false,
                        onTab: () {
                          exit(0);
                        },
                        text: "permission-denied-button".tr,
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
