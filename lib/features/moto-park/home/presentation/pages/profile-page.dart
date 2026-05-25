import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-header.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-text-filed.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/profile-controller.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
          appBar: AppHeader(),
          body: AppLoading(
            loading: controller.loading,
            child: AppScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: Get.size.width * 0.05),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: Get.size.width * 0.07,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius:
                                  BorderRadius.circular(Get.size.width * 0.25)),
                          width: Get.size.width * 0.25,
                          height: Get.size.width * 0.25,
                          alignment: Alignment.center,
                          child: Text(
                            controller.information?.lastName[0] ?? "",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.size.width * 0.1,
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
                        height: Get.size.width * 0.05,
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
                        height: Get.size.width * 0.05,
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
                        height: Get.size.width * 0.05,
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
                        height: Get.size.width * 0.05,
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
                        height: Get.size.width * 0.1,
                      ),
                    ]),
              ),
            ),
          ));
    });
  }
}
