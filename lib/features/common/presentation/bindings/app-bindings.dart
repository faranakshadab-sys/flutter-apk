import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/plate-detection-dio.dart';
import 'package:parkingandroid/features/common/data/data-source/local-data-source-impl.dart';
import 'package:parkingandroid/features/common/data/data-source/local-data-source.dart';
import 'package:parkingandroid/features/common/presentation/controllers/user-controller.dart';

class AppBindings extends Bindings {
  final BuildContext context;

  AppBindings({required this.context});

  @override
  void dependencies() {
    Get.put<BuildContext>(context);

    Get.put<CommonLocalDatasource>(CommonLocalDatasourceImpl());

    Get.put<UserController>(
      UserController(),
      permanent: true,
    );

    PlateDetectionDio.init();
  }
}
