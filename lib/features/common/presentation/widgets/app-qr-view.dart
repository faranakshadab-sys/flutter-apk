import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppQrCode extends StatefulWidget {
  const AppQrCode({required this.reportId, required this.onCreateQrCode});
  final String? reportId;
  final void Function(String) onCreateQrCode;

  @override
  State<AppQrCode> createState() => _AppQrCodeState();
}

class _AppQrCodeState extends State<AppQrCode> {
  QrCode? qrCode;

  @override
  void initState() {
    if (widget.reportId != null) {
      setState(() {
        qrCode = QrCode.fromData(
          data: widget.reportId.toString(),
          errorCorrectLevel: QrErrorCorrectLevel.L,
        );
      });
    }

    super.initState();
  }

  @override
  void didUpdateWidget(AppQrCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reportId != null) {
      if (oldWidget.reportId != widget.reportId) {
        setState(() {
          qrCode = QrCode.fromData(
            data: widget.reportId.toString(),
            errorCorrectLevel: QrErrorCorrectLevel.L,
          );
        });
        getByteFromQr();
      }
    }
  }

  void getByteFromQr() async {
    final byteData = await QrPainter(
      data: widget.reportId!,
      version: QrVersions.auto,
      gapless: false,
      color: Colors.black,
      emptyColor: Colors.white,
    ).toImageData(200, format: ImageByteFormat.png);

    final imageDataBytes = byteData!.buffer.asUint8List();
    final base64 = base64Encode(imageDataBytes);
    widget.onCreateQrCode(base64);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: buildQrView(),
      secondChild: buildQrLoading(),
      crossFadeState: widget.reportId != null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 400),
      firstCurve: Curves.easeOutCubic,
      secondCurve: Curves.easeOutCubic,
      sizeCurve: Curves.easeOutCubic,
      reverseDuration: Duration(milliseconds: 400),
    );
  }

  Widget buildQrView() => widget.reportId == null
      ? Container()
      : QrImageView(
          data: widget.reportId.toString(),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          version: QrVersions.auto,
          size: 200.0,
        );

  Widget buildQrLoading() => Container(
        width: 200,
        height: 200,
      );
}
