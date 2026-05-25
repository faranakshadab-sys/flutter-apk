import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/routes/get-routes.dart';
import 'core/translations/app-translations.dart';
import 'features/common/presentation/bindings/app-bindings.dart';

import 'features/common/presentation/controllers/theme-controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeController controller;

  @override
  void initState() {
    controller = Get.put<ThemeController>(ThemeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (_) {
      return GetMaterialApp(
        title: 'Parking Plus Android',
        theme: controller.theme,
        translations: AppTranslations(),
        locale: controller.locale,
        fallbackLocale: Locale('fa', 'IR'),
        debugShowCheckedModeBanner: false,
        initialRoute: "/moto-park",
        initialBinding: AppBindings(context: context),
        getPages: getRoutes(),
      );
    });
  }
}
