import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image/image.dart';

class ConvertUtility {
  static Future<String> getBase64FromImage(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final completer = Completer<Uint8List>();
    completer.complete(Uint8List.view(byteData!.buffer));
    final bytes = await completer.future;
    return base64Encode(bytes);
  }

  static Future<String> getBase64FromResizedImage(
      ui.Image image, int width, int height) async {
    try {
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final completer = Completer<Uint8List>();
      completer.complete(Uint8List.view(byteData!.buffer));

      var bytes = await completer.future;

      final decodedImage = decodeImage(List.from(bytes));

      final resizedImage =
          copyResize(decodedImage!, width: width, height: height);

      bytes = Uint8List.fromList(encodePng(resizedImage));

      return base64Encode(bytes);
    } catch (e) {
      return "";
    }
  }
}
