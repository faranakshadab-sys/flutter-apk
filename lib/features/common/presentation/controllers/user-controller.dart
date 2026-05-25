import 'package:get/get.dart';

class UserController extends GetxController {
  String fullName = "";
  String roleName = "";
  String uniqueIdentifier = "";

  void initUserInformation(
      {required String fullNameValue,
      required String uniqueIdentifierValue,
      required String roleNameValue}) {
    fullName = fullNameValue;
    uniqueIdentifier = uniqueIdentifierValue;
    roleName = roleNameValue;
    update();
  }
}
