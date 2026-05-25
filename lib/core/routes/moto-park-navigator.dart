import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/authentication/presentation/bindings/login-bindings.dart';
import 'package:parkingandroid/features/moto-park/authentication/presentation/pages/login-page.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/bindings/home-bindings.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/pages/home-page.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/bindings/profile-bindings.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/pages/profile-page.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/bindings/report-information-bindings.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/bindings/reports-bindings.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/pages/reports-page.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/pages/report-information-page.dart';

class MotoParkNavigator {
  static String currentRoute = "/login";

  static WillPopScope navigator = WillPopScope(
    child: Navigator(
        key: Get.nestedKey(2),
        initialRoute: '/login',
        reportsRouteUpdateToEngine: true,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/login":
              {
                currentRoute = "/login";
                return GetPageRoute(
                    page: () => LoginPage(), binding: LoginBinding());
              }

            case "/home":
              {
                currentRoute = "/home";
                return GetPageRoute(
                    page: () => HomePage(), binding: MotoParkHomeBindings());
              }

            case "/profile":
              {
                currentRoute = "/profile";
                return GetPageRoute(
                    page: () => ProfilePage(), binding: ProfileBindings());
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
                      reportId: settings.arguments as int),
                );
              }
            default:
              return null;
          }
        }),
    onWillPop: () async {
      return !await Get.nestedKey(2)!.currentState!.maybePop();
    },
  );
}
