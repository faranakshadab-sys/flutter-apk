import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/convert-utility.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/plate-identity-model.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/report-view-model.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/add-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/delete-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/get-plate-identities-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/submit-payment-status-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/update-plate-case.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/home-controller.dart';
import 'package:parkingandroid/features/moto-park/reports/domain/models/report-information-model.dart';
import 'package:parkingandroid/features/moto-park/reports/domain/use-cases/report-information-case.dart';
import 'dart:ui' as ui;

class ReportInformationController extends GetxController {
  final ReportInformationCase reportInformationCase;
  final UpdatePlateCase updatePlateCase;
  final AddPlateIdentityCase addPlateIdentityCase;
  final GetPlateIdentitiesCase getPlateIdentitiesCase;
  final SubmitPaymentStatusCase submitPaymentStatusCase;
  final DeletePlateIdentityCase deletePlateIdentityCase;
  final int reportId;

  final MotoParkHomeController homeController = Get.find();

  ReportInformationController(
      {required this.reportInformationCase,
      required this.addPlateIdentityCase,
      required this.getPlateIdentitiesCase,
      required this.submitPaymentStatusCase,
      required this.updatePlateCase,
      required this.reportId,
      required this.deletePlateIdentityCase});

  @override
  void onReady() {
    getReportInformation();
    _startListener();
    super.onReady();
  }

  @override
  void onClose() {
    _cancelListener();
    super.onClose();
  }

  ReceiptPlatformChannel channel = ReceiptPlatformChannel();
  bool loading = true;

  ReportInformationModel? reportInformation;

  String initialPlateNumber1 = "";
  String initialPlateNumber2 = "";
  String initialPlateNumber3 = "";
  String initialPlateNumber4 = "";

  String plateNumber1 = "";
  String plateNumber2 = "";
  String plateNumber3 = "";
  String plateNumber4 = "";

  bool get isEditedPlateNumber =>
      plateNumber1 != initialPlateNumber1 ||
      plateNumber2 != initialPlateNumber2 ||
      plateNumber3 != initialPlateNumber3 ||
      plateNumber4 != initialPlateNumber4;

  bool isDataChanged = false;

  GlobalKey plateKey = GlobalKey();

  List<PlateIdentityModel> phones = [];

  static const stream = EventChannel('parking/receipt-event-channel');
  late StreamSubscription _streamSubscription;

  void _startListener() {
    _streamSubscription = stream.receiveBroadcastStream().listen(_listenStream);
  }

  void _cancelListener() {
    _streamSubscription.cancel();
  }

  void _listenStream(value) async {
    if (reportInformation == null) {
      return;
    }

    if (value != "FAIL") {
      Map<String, dynamic> response = jsonDecode(value);

      RenderRepaintBoundary boundary =
          plateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = (await boundary.toImage(pixelRatio: 2.0));

      if (response["resultCode"] == "000") {
        var result = await submitPaymentStatus(
            reportId: reportInformation!.id,
            totalAmount: reportInformation!.totalAmount,
            refrenceId: response["referenceID"]);

        if (result) {
          getReportInformation();
          await channel.printMarginalParkPaymentReceipt(
            paymentStatus: "پرداخت موفق",
            submitDateTime: reportInformation!.createdAt,
            totalAmount: reportInformation!.totalAmount.toString(),
            totalParkTime:
                reportInformation!.totalParkTime.replaceAll("--:--", "00:00"),
            plateImageBytes:
                await ConvertUtility.getBase64FromResizedImage(image, 300, 60),
          );
        } else {
          await channel.printMarginalParkPaymentReceipt(
            paymentStatus: "پرداخت ناموفق",
            submitDateTime: reportInformation!.createdAt,
            totalParkTime:
                reportInformation!.totalParkTime.replaceAll("--:--", "00:00"),
            totalAmount: reportInformation!.totalAmount.toString(),
            plateImageBytes:
                await ConvertUtility.getBase64FromResizedImage(image, 300, 60),
          );
        }
      }
    }
  }

  void deletePlateIdentity(id) async {
    var response = await deletePlateIdentityCase(
        params: DeletePlateIdentityCaseParams(id: id));

    response.fold(
        (failure) =>
            SnackbarUtility.showSnackbar(message: "request-failed-response".tr),
        (success) {
      SnackbarUtility.showSnackbar(message: "request-success-message".tr);

      getPlateIdentities(
          plateNumber1: int.parse(plateNumber1),
          plateNumber2: plateNumber2,
          plateNumber3: int.parse(plateNumber3),
          plateNumber4: int.parse(plateNumber4));
    });
  }

  void updatePlateNumber1(String value) {
    plateNumber1 = value;
    update();
  }

  void updatePlateNumber2(String value) {
    plateNumber2 = value;
    update();
  }

  void updatePlateNumber3(String value) {
    plateNumber3 = value;
    update();
  }

  void updatePlateNumber4(String value) {
    plateNumber4 = value;
    update();
  }

  void _resetDataChange() {
    Future.delayed(Duration(seconds: 1), () {
      isDataChanged = false;
    });
  }

  void updatePlate() async {
    if (reportInformation == null) {
      return;
    }

    var response = await updatePlateCase(
        params: UpdatePlateCaseParams(
            id: reportId,
            plateNumberPart1: int.parse(plateNumber1),
            plateNumberPart2: plateNumber2,
            plateNumberPart3: int.parse(plateNumber3),
            plateNumberPart4: int.parse(plateNumber4)));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      reportInformation = ReportInformationModel(
          address: success.address,
          createdAt: success.createdAt,
          firstImageTakenAt: success.firstImageTakenAt,
          id: success.id,
          images: success.images,
          imagesCount: success.imagesCount,
          lastImageTakenAt: success.lastImageTakenAt,
          latitude: success.latitude,
          longitude: success.longitude,
          paymentStatus: success.paymentStatus,
          plateNumberPart1: success.plateNumberPart1,
          plateNumberPart2: success.plateNumberPart2,
          plateNumberPart3: success.plateNumberPart3,
          plateNumberPart4: success.plateNumberPart4,
          totalAmount: success.totalAmount,
          totalParkTime: success.totalParkTime,
          totalParkTimeText: success.totalParkTimeText,
          isMobileNumberRegistered: success.isMobileNumberRegistered,
          paymentStatusText: success.paymentStatusText);

      plateNumber1 = success.plateNumberPart1.toString();
      plateNumber2 = success.plateNumberPart2;
      plateNumber3 = success.plateNumberPart3.toString();
      plateNumber4 = success.plateNumberPart4.toString();

      initialPlateNumber1 = success.plateNumberPart1.toString();
      initialPlateNumber2 = success.plateNumberPart2.toString();
      initialPlateNumber3 = success.plateNumberPart3.toString();
      initialPlateNumber4 = success.plateNumberPart4.toString();

      isDataChanged = true;
      update();

      SnackbarUtility.showSnackbar(message: "request-success-message".tr);

      getPlateIdentities(
          plateNumber1: success.plateNumberPart1,
          plateNumber2: success.plateNumberPart2,
          plateNumber3: success.plateNumberPart3,
          plateNumber4: success.plateNumberPart4);

      homeController
          .onChangeLastReport(generateReportViewModel(reportInformation!));

      _resetDataChange();
    });
  }

  Future getReportInformation() async {
    var response = await reportInformationCase(
        params: ReportInformationCaseParams(reportId: reportId));

    response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
    }, (success) async {
      reportInformation = success;

      plateNumber1 = success.plateNumberPart1.toString();
      plateNumber2 = success.plateNumberPart2;
      plateNumber3 = success.plateNumberPart3.toString();
      plateNumber4 = success.plateNumberPart4.toString();

      initialPlateNumber1 = success.plateNumberPart1.toString();
      initialPlateNumber2 = success.plateNumberPart2.toString();
      initialPlateNumber3 = success.plateNumberPart3.toString();
      initialPlateNumber4 = success.plateNumberPart4.toString();

      isDataChanged = true;

      getPlateIdentities(
          plateNumber1: success.plateNumberPart1,
          plateNumber2: success.plateNumberPart2,
          plateNumber3: success.plateNumberPart3,
          plateNumber4: success.plateNumberPart4);

      update();
      _resetDataChange();
    });
  }

  void getPlateIdentities(
      {required int plateNumber1,
      required String plateNumber2,
      required int plateNumber3,
      required int plateNumber4}) async {
    var response = await getPlateIdentitiesCase(
        params: GetPlateIdentitiesCaseParams(
            page: 1,
            pageSize: 100,
            plateNumberPart1: plateNumber1,
            plateNumberPart2: plateNumber2,
            plateNumberPart3: plateNumber3,
            plateNumberPart4: plateNumber4));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      phones = success;
      homeController.onChangePlateIdentites(success);
      loading = false;
      update();
    });
  }

  Future<bool> addPlateIdentity(String phoneNumber) async {
    var response = await addPlateIdentityCase(
        params: AddPlateIdentityCaseParams(
            plateNumberPart1: int.parse(plateNumber1),
            ownerMobileNumber: phoneNumber,
            plateNumberPart2: plateNumber2,
            plateNumberPart3: int.parse(plateNumber3),
            plateNumberPart4: int.parse(plateNumber4)));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      SnackbarUtility.showSnackbar(message: "request-success-message".tr);
      getPlateIdentities(
          plateNumber1: int.parse(plateNumber1),
          plateNumber2: plateNumber2,
          plateNumber3: int.parse(plateNumber3),
          plateNumber4: int.parse(plateNumber4));
      return true;
    });
  }

  ReportViewModel generateReportViewModel(ReportInformationModel model) {
    return ReportViewModel(
        createdAt: model.createdAt,
        currentAmount: model.totalAmount,
        debtAmount: 0,
        firstImageTakenAt: model.firstImageTakenAt,
        id: model.id,
        images: model.images,
        imagesCount: model.imagesCount,
        lastImageTakenAt: model.lastImageTakenAt,
        latitude: model.latitude,
        longitude: model.longitude,
        paymentStatus: model.paymentStatus,
        plateNumberPart1: model.plateNumberPart1,
        plateNumberPart2: model.plateNumberPart2,
        plateNumberPart3: model.plateNumberPart3,
        plateNumberPart4: model.plateNumberPart4,
        totalAmount: model.totalAmount,
        totalParkTime: model.totalParkTime,
        totalParkTimeText: model.totalParkTimeText,
        address: model.address,
        isMobileNumberRegistered: model.isMobileNumberRegistered,
        paymentStatusText: model.paymentStatusText);
  }

  Future<bool> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String refrenceId}) async {
    var response = await submitPaymentStatusCase(
        params: SubmitPaymentStatusCaseParams(
            reportId: reportId,
            totalAmount: totalAmount,
            refrenceId: refrenceId));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      if (success) {
        SnackbarUtility.showSnackbar(message: "request-success-message".tr);
        if (homeController.lastReport?.id == reportId) {
          homeController
              .onChangeLastReport(generateReportViewModel(reportInformation!));
        }
        return true;
      } else {
        SnackbarUtility.showSnackbar(message: "request-failed-response".tr);
        return false;
      }
    });
  }
}
