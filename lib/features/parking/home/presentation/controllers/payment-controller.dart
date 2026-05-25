import 'dart:async';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/convert-utility.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'dart:ui' as ui;

import 'package:parkingandroid/features/parking/common/domain/use-cases/submit-payment-status-case.dart';
import 'package:parkingandroid/features/parking/reports/domain/model/report-information-model.dart';
import 'package:parkingandroid/features/parking/reports/domain/use-cases/report-information-case.dart';

class PaymentController extends GetxController {
  final SubmitPaymentStatusCase submitPaymentStatusCase;
  final ReportInformationCase reportInformationCase;

  PaymentController(
      {required this.submitPaymentStatusCase,
      required this.reportInformationCase});

  static const stream = EventChannel('parking/receipt-event-channel');
  late StreamSubscription _streamSubscription;
  ReceiptPlatformChannel channel = ReceiptPlatformChannel();

  GlobalKey plateKey = GlobalKey();

  ReportInformationModel? report;

  void getReportInformation(int reportId) async {
    var response = await reportInformationCase(
        params: ReportInformationCaseParams(reportId: reportId));

    response.fold((failure) => print(failure.message), (success) {
      report = success;
      update();
    });
  }

  void startListener() {
    _streamSubscription = stream.receiveBroadcastStream().listen(_listenStream);
  }

  void cancelListener() {
    _streamSubscription.cancel();
  }

  void _listenStream(value) async {
    if (report == null) {
      return;
    }

    if (value != "FAIL") {
      Map<String, dynamic> response = jsonDecode(value);

      RenderRepaintBoundary boundary =
          plateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = (await boundary.toImage(pixelRatio: 2.0));

      if (response["resultCode"] == "000") {
        bool isSuccessed = await submitPaymentStatus(
            reportId: report!.id,
            totalAmount: report!.totalAmount,
            referenceId: response["referenceID"]);

        if (isSuccessed) {
          channel.printExitReceipt(
              exitDate: report!.lastImageTakenAt.split(" ").first,
              entryDate: report!.createdAt.split(" ").first,
              entryHour: report!.createdAt.split(" ").last,
              exitHour: report!.lastImageTakenAt.split(" ").last,
              paymentStatusText: "پرداخت موفق",
              totalAmount: report!.totalAmount.toString(),
              parkingAddress: "اصفهان، خیابان سالاریه کوچه اقاقیا",
              parkingName: "پارکینگ بعثت",
              parkingPhone: "025 1256985",
              plateBytes: await ConvertUtility.getBase64FromImage(image),
              totalParkTime: report!.totalParkTime);
        } else {
          channel.printExitReceipt(
            entryDate: report!.createdAt.split(" ").first,
            entryHour: report!.createdAt.split(" ").last,
            exitHour: report!.lastImageTakenAt.split(" ").last,
            paymentStatusText: "پرداخت ناموفق",
            totalAmount: report!.totalAmount.toString(),
            parkingAddress: "اصفهان، خیابان سالاریه کوچه اقاقیا",
            parkingName: "پارکینگ بعثت",
            parkingPhone: "025 1256985",
            plateBytes: await ConvertUtility.getBase64FromImage(image),
            totalParkTime: report!.totalParkTime,
            exitDate: report!.lastImageTakenAt.split(" ").first,
          );
        }
      } else {
        channel.printExitReceipt(
          entryDate: report!.createdAt.split(" ").first,
          entryHour: report!.createdAt.split(" ").last,
          exitHour: report!.lastImageTakenAt.split(" ").last,
          paymentStatusText: "پرداخت ناموفق",
          totalAmount: report!.totalAmount.toString(),
          parkingAddress: "اصفهان، خیابان سالاریه کوچه اقاقیا",
          parkingName: "پارکینگ بعثت",
          parkingPhone: "025 1256985",
          plateBytes: await ConvertUtility.getBase64FromImage(image),
          totalParkTime: report!.totalParkTime,
          exitDate: report!.lastImageTakenAt.split(" ").first,
        );
        SnackbarUtility.showSnackbar(message: "request-failed-response".tr);
      }
    }
  }

  Future<bool> submitPaymentStatus(
      {required int reportId,
      required int totalAmount,
      required String referenceId}) async {
    var response = await submitPaymentStatusCase(
        params: SubmitPaymentStatusCaseParams(
            reportId: reportId,
            totalAmount: totalAmount,
            referenceId: referenceId));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      if (success) {
        SnackbarUtility.showSnackbar(message: "request-success-message".tr);
        return true;
      } else {
        return false;
      }
    });
  }
}
