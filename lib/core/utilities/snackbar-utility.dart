import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtility {
  static void showSnackbar({required String message}) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        message,
        style: Theme.of(Get.find())
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.white, fontFamily: "IranSans"),
      ),
      duration: Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeInCubic,
      isDismissible: true,
      backgroundColor: Theme.of(Get.find()).colorScheme.primaryContainer,
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
