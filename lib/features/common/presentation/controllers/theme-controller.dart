import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/theme/dark-theme.dart';
import 'package:parkingandroid/core/theme/light-theme.dart';

class ThemeController extends GetxController {
  ThemeData theme = darkTheme;
  Locale locale = Locale("fa");

  void switchTheme() {
    if (theme == darkTheme) {
      theme = lightTheme;
    } else {
      theme = darkTheme;
    }
    update();
  }

  void switchLocale() {
    if (locale == Locale("fa", "IR")) {
      locale = Locale("en", "US");
      Get.updateLocale(Locale("en", "US"));
    } else {
      locale = Locale("fa", "IR");
      Get.updateLocale(Locale("fa", "IR"));
    }
    update();
  }
}
