import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/presentation/bindings/payment-bindings.dart';
import 'package:parkingandroid/features/parking/home/presentation/bindings/qr-code-scanner-bindings.dart';
import 'package:parkingandroid/features/parking/home/presentation/pages/payment-page.dart';
import 'package:parkingandroid/features/parking/home/presentation/pages/qr-code-scanner-page.dart';

import '../../features/parking/authentication/presentation/bindings/login-bindings.dart';
import '../../features/parking/authentication/presentation/pages/login-page.dart';
import '../../features/parking/home/presentation/bindings/home-bindings.dart';
import '../../features/parking/home/presentation/bindings/profile-bindings.dart';
import '../../features/parking/home/presentation/pages/home-page.dart';
import '../../features/parking/home/presentation/pages/profile-page.dart';
import '../../features/parking/reports/presentation/bindings/report-information-bindings.dart';
import '../../features/parking/reports/presentation/bindings/reports-bindings.dart';
import '../../features/parking/reports/presentation/pages/report-information-page.dart';
import '../../features/parking/reports/presentation/pages/reports-page.dart';

class ParkingNavigator {
  static String currentRoute = "/login";

  static WillPopScope navigator = WillPopScope(
    onWillPop: () async {
      return !await Get.nestedKey(1)!.currentState!.maybePop();
    },
    child: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/login',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/login":
              {
                currentRoute = "/login";
                return GetPageRoute(
                    page: () => LoginPage(), binding: LoginBindings());
              }

            case "/home":
              {
                currentRoute = "/home";
                return GetPageRoute(
                    page: () => HomePage(), binding: HomeBindings());
              }

            case "/reports":
              {
                currentRoute = "/reports";
                return GetPageRoute(
                    page: () => ReportsPage(), binding: ReportsBindings());
              }

            case "/report-information":
              {
                currentRoute = "/report-information";
                return GetPageRoute(
                    page: () => ReportInformationPage(),
                    binding: ReportInformationBindings(
                        reportId: settings.arguments as int));
              }

            case "/profile":
              {
                currentRoute = "/profile";
                return GetPageRoute(
                    page: () => ProfilePage(), binding: ProfileBindings());
              }

            case "/qr-scanner":
              {
                return GetPageRoute(
                    page: () => QrCodeScannerPage(),
                    binding: QrCodeScannerBindings());
              }

            case "/payment":
              {
                return GetPageRoute(
                    page: () => PaymentPage(), binding: PaymentBinding());
              }

            default:
              {
                return GetPageRoute(
                  page: () => Scaffold(
                    body: Center(
                        child: Text(
                      "page-notfound-error".tr,
                      style: Theme.of(Get.find()).textTheme.titleMedium,
                    )),
                  ),
                );
              }
          }
        }),
  );
}
