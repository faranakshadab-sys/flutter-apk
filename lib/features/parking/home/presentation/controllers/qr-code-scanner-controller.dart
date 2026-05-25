import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/home/domain/use-cases/submit-exit-report-case.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScannerController extends GetxController {
  final SubmitExitReportCase submitExitReportCase;

  QrCodeScannerController({required this.submitExitReportCase});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  String? qrCodeData;

  bool get isQrReaded => qrCodeData != null;

  void onQRViewCreated(QRViewController qrController) {
    controller = qrController;
    qrController.scannedDataStream.listen((scanData) {
      qrCodeData = scanData.code;
      update();
      qrController.pauseCamera();
    });
  }
}
