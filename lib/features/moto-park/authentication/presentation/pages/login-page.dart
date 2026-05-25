import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-filled-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-text-filed.dart';
import 'package:parkingandroid/features/moto-park/authentication/presentation/controllers/login-controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
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
                        width: Get.size.width * 0.7,
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
