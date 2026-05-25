import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/use-cases/login-case.dart';
import 'package:parkingandroid/features/moto-park/authentication/domain/use-cases/save-information-case.dart';
import 'package:parkingandroid/features/common/presentation/controllers/user-controller.dart';

class LoginController extends GetxController {
  String userName = "";
  String password = "";
  late TextEditingController userNameController;
  late TextEditingController passwordController;
  bool isRequestRunning = false;
  bool loading = false;

  final LoginCase loginCase;
  final SaveUserInformationCase saveUserInformationCase;

  LoginController(
      {required this.loginCase, required this.saveUserInformationCase});

  @override
  void onInit() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/images/arad-logo.png'), Get.find());
    });

    userNameController = TextEditingController(text: userName);
    passwordController = TextEditingController(text: password);
    super.onInit();
  }

  void updateLoading(bool value) {
    loading = value;
    update();
  }

  void updateUserName(String value) {
    userName = value;
    update();
  }

  void updatePassword(String value) {
    password = value;
    update();
  }

  void handleLoginRequest() async {
    if (userName == "") {
      SnackbarUtility.showSnackbar(message: "empty-username-error".tr);
      return;
    }

    if (password == "") {
      SnackbarUtility.showSnackbar(message: "empty-password-error".tr);
    }

    isRequestRunning = true;
    update();

    var loginResponse = await loginCase(
        params: LoginCaseParams(password: password, username: userName));

    loginResponse.fold((loginFailure) {
      SnackbarUtility.showSnackbar(message: loginFailure.message);
      isRequestRunning = false;
      update();
    }, (loginSuccess) async {
      var saveInformationResponse = await saveUserInformationCase(
          params: SaveUserInformationCaseParams(
              accessToken: loginSuccess.accessToken,
              refreshToken: loginSuccess.refreshToken,
              uniqueIdentifier: loginSuccess.uniqueIdentifier));

      saveInformationResponse.fold(
          (saveInformationFailure) => SnackbarUtility.showSnackbar(
              message: saveInformationFailure.message),
          (saveInformationSuccess) {
        if (!saveInformationSuccess) {
          return;
        }

        Get.find<UserController>().initUserInformation(
            fullNameValue: loginSuccess.fullName,
            uniqueIdentifierValue: loginSuccess.uniqueIdentifier,
            roleNameValue: loginSuccess.roleName);
        SnackbarUtility.showSnackbar(message: "login-success-message".tr);
        isRequestRunning = false;
        update();
        Get.offAllNamed("/home", id: 2);
      });
    });
  }
}
