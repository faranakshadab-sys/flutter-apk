import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as imglib;

typedef ConvertFunc = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, Int32, Int32, Int32, Int32);
typedef Convert = Pointer<Uint32> Function(
    Pointer<Uint8>, Pointer<Uint8>, Pointer<Uint8>, int, int, int, int);

class IsolateUtils {
  static const String DEBUG_NAME = "FrameIsolate";

  late Isolate _isolate;
  ReceivePort _receivePort = ReceivePort();
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  static DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();
  static Convert conv = convertImageLib
      .lookup<NativeFunction<ConvertFunc>>('convertImage')
      .asFunction<Convert>();

  Future<void> start() async {
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    _isolate = await Isolate.spawn<Map<String, dynamic>>(
      entryPoint,
      {"sendPort": _receivePort.sendPort, "token": rootIsolateToken},
      debugName: DEBUG_NAME,
    );

    _sendPort = await _receivePort.first;
  }

  static void entryPoint(Map<String, dynamic> data) async {
    BackgroundIsolateBinaryMessenger.ensureInitialized(data["token"]);
    final port = ReceivePort();
    data["sendPort"].send(port.sendPort);

    await for (final IsolateData? isolateData in port) {
      if (isolateData != null) {
        Pointer<Uint8> p =
            malloc.allocate(isolateData.cameraImage.planes[0].bytes.length);
        Pointer<Uint8> p1 =
            malloc.allocate(isolateData.cameraImage.planes[1].bytes.length);
        Pointer<Uint8> p2 =
            malloc.allocate(isolateData.cameraImage.planes[2].bytes.length);

        Uint8List pointerList =
            p.asTypedList(isolateData.cameraImage.planes[0].bytes.length);
        Uint8List pointerList1 =
            p1.asTypedList(isolateData.cameraImage.planes[1].bytes.length);
        Uint8List pointerList2 =
            p2.asTypedList(isolateData.cameraImage.planes[2].bytes.length);
        pointerList.setRange(0, isolateData.cameraImage.planes[0].bytes.length,
            isolateData.cameraImage.planes[0].bytes);
        pointerList1.setRange(0, isolateData.cameraImage.planes[1].bytes.length,
            isolateData.cameraImage.planes[1].bytes);
        pointerList2.setRange(0, isolateData.cameraImage.planes[2].bytes.length,
            isolateData.cameraImage.planes[2].bytes);

        Pointer<Uint32> imgP = conv(
            p,
            p1,
            p2,
            isolateData.cameraImage.planes[1].bytesPerRow,
            isolateData.cameraImage.planes[1].bytesPerPixel!,
            isolateData.cameraImage.width,
            isolateData.cameraImage.height);

        Uint32List imgData = imgP.asTypedList(
            isolateData.cameraImage.width * isolateData.cameraImage.height);

        imglib.Image img = imglib.Image.fromBytes(
            isolateData.cameraImage.height,
            isolateData.cameraImage.width,
            imgData);

        var jpg = imglib.encodeJpg(img);

        Uint8List bytes = Uint8List.fromList(jpg);

        malloc.free(p);
        malloc.free(p1);
        malloc.free(p2);
        malloc.free(imgP);

        isolateData.responsePort!.send(bytes);
      }
    }
  }
}

class IsolateData {
  CameraImage cameraImage;
  SendPort? responsePort;

  IsolateData({required this.cameraImage, this.responsePort});
}
