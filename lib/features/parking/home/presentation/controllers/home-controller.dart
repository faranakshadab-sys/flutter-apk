import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/convert-utility.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/parking/home/domain/models/create-enter-report-model.dart';
import 'package:parkingandroid/features/parking/home/domain/use-cases/create-enter-report-case.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/use-cases/detect-plate-bytes-case.dart';
import 'dart:ui' as ui;

class HomeController extends GetxController {
  final DetectPlateBytesCase detectPlateBytesCase;
  final CreateEnterReportCase createEnterReportCase;
  final GlobalKey plateKey = GlobalKey();

  ReceiptPlatformChannel platformChannel = ReceiptPlatformChannel();

  bool isCameraPermissionGranted = false;

  bool isAuto = false;
  bool isFlashModeOn = false;

  String initialPlateNumber1 = "";
  String initialPlateNumber2 = "";
  String initialPlateNumber3 = "";
  String initialPlateNumber4 = "";

  String plateNumberPart1 = "";
  String plateNumberPart2 = "";
  String plateNumberPart3 = "";
  String plateNumberPart4 = "";

  String phoneNumber = "";

  String base64 = "";

  CreateEnterReportModel? createdReport;

  PageController pageController = PageController();

  String? lastReportQrCode;

  bool get isEditedPlateNumber =>
      plateNumberPart1 != initialPlateNumber1 ||
      plateNumberPart2 != initialPlateNumber2 ||
      plateNumberPart3 != initialPlateNumber3 ||
      plateNumberPart4 != initialPlateNumber4;

  bool isPrintReceipt = false;
  bool isDataChanged = false;

  bool isRequestRunning = false;

  HomeController(
      {required this.detectPlateBytesCase,
      required this.createEnterReportCase});

  void submitCreateReport() async {
    if (base64 == "") {
      SnackbarUtility.showSnackbar(message: "parking-no-image-error".tr);
      return;
    }

    isRequestRunning = true;
    update();

    var response = await createEnterReportCase(
        params: CreateEnterReportCaseParams(
            image: base64,
            phoneNumber: phoneNumber,
            plateNumber: plateNumberPart1 +
                plateNumberPart2 +
                plateNumberPart3 +
                plateNumberPart4));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      createdReport = success;
      Get.back(id: 2);
    });
  }

  void printArrivalReceipt() async {
    if (createdReport == null) {
      return;
    }

    RenderRepaintBoundary boundary =
        plateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = (await boundary.toImage(pixelRatio: 2.0));

    platformChannel.printArrivalReceipt(
        entryDate: createdReport!.entryDate.split(" ").first,
        entryHour: createdReport!.entryDate.split(" ").last,
        qrBytes: lastReportQrCode!,
        plateBytes: await ConvertUtility.getBase64FromImage(image),
        parkingName: createdReport!.parkingName,
        parkingAddress: createdReport!.parkingAddress,
        parkingPhone: createdReport!.parkingPhone);
  }

  void onGenerateQrCode(String value) {
    lastReportQrCode = value;
    update();
  }

  void onChangePhoneNumber(String value) {
    phoneNumber = value;
    update();
  }

  void handleRequestRunning(bool value) {
    isRequestRunning = value;
    update();
  }

  void handleCanceleButton() {
    lastReportQrCode = null;
    base64 = "";

    initialPlateNumber1 = "";
    initialPlateNumber2 = "";
    initialPlateNumber3 = "";
    initialPlateNumber4 = "";

    plateNumberPart1 = "";
    plateNumberPart2 = "";
    plateNumberPart3 = "";
    plateNumberPart4 = "";

    update();
    Get.back(id: 2);
  }

  void onChangeLastReportQrCode(String value) {
    lastReportQrCode = value;
    update();
  }

  void onChangeIsPrintReceipt(bool value) {
    isPrintReceipt = value;
    update();
  }

  void _resetDataChanged() {
    Future.delayed(Duration(seconds: 1), () {
      isDataChanged = false;
    });
  }

  void updatePlatePartNumber1(String value) {
    plateNumberPart1 = value;
    update();
  }

  void updatePlatePartNumber2(String value) {
    plateNumberPart2 = value;
    update();
  }

  void updatePlatePartNumber3(String value) {
    plateNumberPart3 = value;
    update();
  }

  void updatePlatePartNumber4(String value) {
    plateNumberPart4 = value;
    update();
  }

  void updateIsAuto(bool value) {
    isAuto = value;
    update();
  }

  void updateIsFlashMode(bool value) {
    isFlashModeOn = value;
    update();
  }

  Future<String?> checkRequiredPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;

    if (cameraStatus == PermissionStatus.granted) {
      isCameraPermissionGranted = true;
    } else {
      isCameraPermissionGranted = false;
    }

    if (!isCameraPermissionGranted) {
      return "camera-request-permission".tr;
    }

    return null;
  }

  Future<bool> requestCameraPermission() async {
    PermissionStatus response = await Permission.camera.request();

    if (response == PermissionStatus.granted) {
      isCameraPermissionGranted = true;
      return true;
    } else {
      isCameraPermissionGranted = false;
      return false;
    }
  }

  Future<bool> detectPlateOnFrameBytes({required Uint8List bytes}) async {
    var response = await detectPlateBytesCase(
        params: DetectPlateBytesCaseParams(
      image: bytes,
    ));

    return response.fold((failure) {
      handleRequestRunning(false);
      return false;
    }, (success) {
      handleRequestRunning(false);
      if (success != null) {
        String platePart1 = success.plateNumber.substring(0, 2).toString();
        String platePart2 = success.plateNumber.substring(2, 3).toString();
        String platePart3 = success.plateNumber.substring(3, 6).toString();
        String platePart4 = success.plateNumber.substring(6, 8).toString();

        base64 = success.base64Image;

        plateNumberPart1 = platePart1;
        plateNumberPart2 = platePart2;
        plateNumberPart3 = platePart3;
        plateNumberPart4 = platePart4;

        initialPlateNumber1 = platePart1;
        initialPlateNumber2 = platePart2;
        initialPlateNumber3 = platePart3;
        initialPlateNumber4 = platePart4;
        isPrintReceipt = false;
        isDataChanged = true;
        isAuto = false;

        update();
        _resetDataChanged();

        return true;
      } else {
        return false;
      }
    });
  }
}
