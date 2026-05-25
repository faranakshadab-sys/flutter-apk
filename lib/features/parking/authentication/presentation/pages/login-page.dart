import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';

import '../../../../common/presentation/widgets/app-filled-button.dart';
import '../../../../common/presentation/widgets/app-text-filed.dart';
import '../controllers/login-controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController controller;

  @override
  void initState() {
    controller = Get.find<LoginController>();

    Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      controller.updateLoading(false);
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/images/arad-logo.png'), context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugInvertOversizedImages = true;

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LoginController>(builder: (_) {
          return AppLoading(
            loading: controller.loading,
            child: AppScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(
                      flex: 4,
                    ),
                    Text(
                      "login-title".tr,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "login-description".tr,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    AppTextFiled(
                      controller: controller.userNameController,
                      hintText: "login-mobile-input-description".tr,
                      labelText: "login-mobile-input-title".tr,
                      onChangeValue: controller.updateUserName,
                      value: controller.userName,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AppTextFiled(
                        hintText: "*******",
                        labelText: "login-password-input-title".tr,
                        onChangeValue: controller.updatePassword,
                        value: controller.password,
                        controller: controller.passwordController),
                    SizedBox(
                      height: 48,
                    ),
                    AppFilledButton(
                      isRequestRunning: controller.isRequestRunning,
                      onTab: () {
                        FocusScope.of(context).unfocus();
                        controller.handleLoginRequest();
                      },
                      title: "login-button-title".tr,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(left: 35),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/arad-logo.png",
                        fit: BoxFit.cover,
                        width: size.width * 0.7,
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
