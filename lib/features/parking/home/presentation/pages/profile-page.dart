import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/app-header.dart';

import '../../../../common/presentation/widgets/app-text-filed.dart';
import '../controllers/profile-controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController controller;

  @override
  void initState() {
    controller = Get.find<ProfileController>();
    controller.getProfileInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: AppHeader(),
      body: GetBuilder<ProfileController>(builder: (controller) {
        return AppLoading(
          loading: controller.loading,
          child: AppScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: size.width * 0.07,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius:
                                BorderRadius.circular(size.width * 0.25)),
                        width: size.width * 0.25,
                        height: size.width * 0.25,
                        alignment: Alignment.center,
                        child: Text(
                          controller.information?.lastName[0] ?? "",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                    AppTextFiled(
                      labelText: "profile-firstname-title".tr,
                      enabled: false,
                      hintText: "",
                      value: controller.information?.firstName ?? "",
                      controller: TextEditingController(
                          text: controller.information?.firstName ?? ""),
                      onChangeValue: (value) {},
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AppTextFiled(
                      enabled: false,
                      labelText: "profile-lastname-title".tr,
                      hintText: "",
                      value: controller.information?.lastName ?? "",
                      controller: TextEditingController(
                          text: controller.information?.lastName ?? ""),
                      onChangeValue: (value) {},
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AppTextFiled(
                      enabled: false,
                      hintText: "",
                      labelText: "profile-username-title".tr,
                      value: controller.information?.username ?? "",
                      controller: TextEditingController(
                          text: controller.information?.username ?? ""),
                      onChangeValue: (value) {},
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AppTextFiled(
                      enabled: false,
                      hintText: "",
                      labelText: "profile-last-seen-title".tr,
                      value: controller.information?.lastLoginAt ?? "",
                      controller: TextEditingController(
                          text:
                              "${controller.information?.lastLoginAt.split(" ").first ?? ""} ${"houre-text".tr} ${controller.information?.lastLoginAt.split(" ").last ?? ""}"),
                      onChangeValue: (value) {},
                    ),
                    SizedBox(
                      height: size.width * 0.05,
                    ),
                    AppTextFiled(
                      enabled: false,
                      hintText: "",
                      labelText: "profile-role-title".tr,
                      value: controller.information?.roleName ?? "",
                      controller: TextEditingController(
                          text: controller.information?.roleName ?? ""),
                      onChangeValue: (value) {},
                    ),
                    SizedBox(
                      height: size.width * 0.1,
                    ),
                  ]),
            ),
          ),
        );
      }),
    ));
  }
}
