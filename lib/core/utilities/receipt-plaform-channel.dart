import 'dart:convert';

import 'package:flutter/services.dart';

class ReceiptPlatformChannel {
  final MethodChannel channel =
      MethodChannel("parking/receipt-platform-channel");

  Future sendTransaction({
    required String totalAmount,
  }) async {
    await channel.invokeMethod("sendTransaction", totalAmount);
  }

  Future printArrivalReceipt(
      {required String entryDate,
      required String entryHour,
      required String qrBytes,
      required String plateBytes,
      required String parkingName,
      required String parkingAddress,
      required String parkingPhone}) async {
    var values = jsonEncode({
      "entryDate": entryDate,
      "entryHour": entryHour,
      "qrBytes": qrBytes,
      "plateBytes": plateBytes,
      "parkingName": parkingName,
      "parkingAddress": parkingAddress,
      "parkingPhone": parkingPhone
    });

    await channel.invokeMethod("printArrivalReceipt", values);
  }

  Future printExitReceipt(
      {required String entryDate,
      required String entryHour,
      required String plateBytes,
      required String totalAmount,
      required String exitHour,
      required String exitDate,
      required String totalParkTime,
      required String parkingName,
      required String parkingAddress,
      required String parkingPhone,
      required String paymentStatusText}) async {
    var values = jsonEncode({
      "entryDate": entryDate,
      "exitDate": exitDate,
      "entryHour": entryHour,
      "exitHour": exitHour,
      "plateBytes": plateBytes,
      "parkingName": parkingName,
      "parkingAddress": parkingAddress,
      "parkingPhone": parkingPhone,
      "totalAmount": totalAmount,
      "paymentStatusText": paymentStatusText,
      "totalParkTime": totalParkTime
    });

    await channel.invokeMethod("printExitReceipt", values);
  }

  Future printMarginalParkPaymentReceipt(
      {required String totalAmount,
      required String totalParkTime,
      required String paymentStatus,
      required String submitDateTime,
      required String plateImageBytes}) async {
    var values = jsonEncode({
      "totalAmount": totalAmount,
      "totalParkTime": totalParkTime,
      "paymentStatus": paymentStatus,
      "submitDateTime": submitDateTime,
      "plateImageBytes": plateImageBytes,
    });

    await channel.invokeMethod("printMarginalParkPaymentReceipt", values);
  }
}
