import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-isolates.dart';
import 'package:parkingandroid/core/utilities/convert-utility.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/delete-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/widgets/permission-modal.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/plate-identity-model.dart';
import 'package:parkingandroid/features/moto-park/common/domain/models/report-view-model.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/add-plate-identity-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/get-plate-identities-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/get-reports-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/submit-payment-status-case.dart';
import 'package:parkingandroid/features/moto-park/common/domain/use-cases/update-plate-case.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/detect-plate-base64-case.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/detect-plate-bytes-case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

class MotoParkHomeController extends GetxController {
  final GetReportsCase getReportsCase;
  final DetectPlateBase64Case detectPlateBase64Case;
  final DetectPlateBytesCase detectPlateBytesCase;
  final SubmitPaymentStatusCase submitPaymentStatusCase;
  final GetPlateIdentitiesCase getPlateIdentitiesCase;
  final UpdatePlateCase updatePlateCase;
  final AddPlateIdentityCase addPlateIdentityCase;
  final DeletePlateIdentityCase deletePlateIdentityCase;
  final String uniqueIdentifier;
  late DraggableScrollableController draggableScrollableController;

  ReceiptPlatformChannel channel = ReceiptPlatformChannel();

  MotoParkHomeController(
      {required this.getReportsCase,
      required this.detectPlateBase64Case,
      required this.detectPlateBytesCase,
      required this.submitPaymentStatusCase,
      required this.getPlateIdentitiesCase,
      required this.updatePlateCase,
      required this.addPlateIdentityCase,
      required this.uniqueIdentifier,
      required this.deletePlateIdentityCase});

  static const stream = EventChannel('parking/receipt-event-channel');
  late StreamSubscription _streamSubscription;
  late IsolateUtils isolateUtils;
  List<PlateIdentityModel> phoneNumbers = [];
  bool isPhoneNumbersLoaded = false;

  bool isAuto = false;
  bool isNightModeOn = false;

  bool isPlateDetectionRequestRunning = false;

  bool isCameraPermissionGranted = false;
  bool isLocationPermissionGranted = false;
  double? latitude;
  double? longitude;

  bool get isLocationReady => latitude != null && longitude != null;

  ReportViewModel? lastReport;
  GlobalKey plateKey = GlobalKey();

  String initialPlateNumber1 = "";
  String initialPlateNumber2 = "";
  String initialPlateNumber3 = "";
  String initialPlateNumber4 = "";

  String plateNumberPart1 = "";
  String plateNumberPart2 = "";
  String plateNumberPart3 = "";
  String plateNumberPart4 = "";

  bool get isEditedPlateNumber =>
      plateNumberPart1 != initialPlateNumber1 ||
      plateNumberPart2 != initialPlateNumber2 ||
      plateNumberPart3 != initialPlateNumber3 ||
      plateNumberPart4 != initialPlateNumber4;

  bool isDataChanged = false;

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();

  CameraController? cameraController;

  bool get isLastLocationRecived => latitude != null && longitude != null;

  @override
  void onInit() async {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SvgAssetLoader('assets/icons/isf-logo.svg');
    });

    super.onInit();
  }

  @override
  void onReady() {
    getLastReport();
    initializeDependencies();
    initializeIsolateUtils();
    _startListener();
    super.onReady();
  }

  @override
  void onClose() {
    _cancelListener();
    cameraController!.dispose();
    super.onClose();
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
          plateNumber1: int.parse(plateNumberPart1),
          plateNumber2: plateNumberPart2,
          plateNumber3: int.parse(plateNumberPart3),
          plateNumber4: int.parse(plateNumberPart4));
    });
  }

  void onChangePlateIdentites(List<PlateIdentityModel> value) {
    phoneNumbers = value;
    update();
  }

  void onChangeLastReport(ReportViewModel value) {
    lastReport = value;

    plateNumberPart1 = value.plateNumberPart1.toString();
    plateNumberPart2 = value.plateNumberPart2;
    plateNumberPart3 = value.plateNumberPart3.toString();
    plateNumberPart4 = value.plateNumberPart4.toString();

    initialPlateNumber1 = value.plateNumberPart1.toString();
    initialPlateNumber2 = value.plateNumberPart2;
    initialPlateNumber3 = value.plateNumberPart3.toString();
    initialPlateNumber4 = value.plateNumberPart4.toString();

    isDataChanged = true;
    update();

    _resetDataChanged();
  }

  void initializeDragableController(DraggableScrollableController value) async {
    draggableScrollableController = value;
    update();
  }

  void _startListener() {
    _streamSubscription = stream.receiveBroadcastStream().listen(_listenStream);
  }

  void _cancelListener() {
    _streamSubscription.cancel();
  }

  void _listenStream(value) async {
    if (lastReport == null) {
      return;
    }

    if (value != "FAIL") {
      Map<String, dynamic> response = jsonDecode(value);

      RenderRepaintBoundary boundary =
          plateKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = (await boundary.toImage(pixelRatio: 2.0));

      if (response["resultCode"] == "000") {
        var result = await submitPaymentStatus(
            reportId: lastReport!.id,
            totalAmount: lastReport!.totalAmount,
            refrenceId: response["referenceID"]);
        if (result) {
          await channel.printMarginalParkPaymentReceipt(
            paymentStatus: "پرداخت موفق",
            submitDateTime: lastReport!.createdAt,
            totalAmount: lastReport!.totalAmount.toString(),
            totalParkTime:
                lastReport!.totalParkTime.replaceAll("--:--", "00:00"),
            plateImageBytes:
                await ConvertUtility.getBase64FromResizedImage(image, 300, 60),
          );
        } else {
          await channel.printMarginalParkPaymentReceipt(
            paymentStatus: "پرداخت ناموفق",
            submitDateTime: lastReport!.createdAt,
            totalParkTime:
                lastReport!.totalParkTime.replaceAll("--:--", "00:00"),
            totalAmount: lastReport!.totalAmount.toString(),
            plateImageBytes:
                await ConvertUtility.getBase64FromResizedImage(image, 300, 60),
          );
        }
      }
    }
  }

  Future initializeIsolateUtils() async {
    isolateUtils = IsolateUtils();
    await isolateUtils.start();
  }

  Future<String?> checkRequiredPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus locationStatus = await Permission.location.status;

    if (cameraStatus == PermissionStatus.granted) {
      isCameraPermissionGranted = true;
    } else {
      isCameraPermissionGranted = false;
    }

    if (locationStatus == PermissionStatus.granted) {
      isLocationPermissionGranted = true;
    } else {
      isLocationPermissionGranted = false;
    }

    if (!isCameraPermissionGranted && !isLocationPermissionGranted) {
      return "camera-location-request-permission".tr;
    }

    if (!isCameraPermissionGranted && isLocationPermissionGranted) {
      return "camera-request-permission".tr;
    }

    if (isCameraPermissionGranted && !isLocationPermissionGranted) {
      return "location-request-permission".tr;
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

  Future<bool> requestLocationPermission() async {
    PermissionStatus response = await Permission.location.request();

    if (response == PermissionStatus.granted) {
      isLocationPermissionGranted = true;
      return true;
    } else {
      isLocationPermissionGranted = false;
      return false;
    }
  }

  Future<bool> requestCameraAndLocationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.location,
    ].request();
    isLocationPermissionGranted =
        statuses[Permission.location] == PermissionStatus.granted;
    isCameraPermissionGranted =
        statuses[Permission.camera] == PermissionStatus.granted;

    if (statuses[Permission.location] == PermissionStatus.granted &&
        statuses[Permission.camera] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> initializeDependencies() async {
    String? response = await checkRequiredPermissions();

    if (response != null) {
      Get.bottomSheet(
        PermissionModal(
          title: response,
          initializeCamera: initializeCamera,
        ),
        enableDrag: true,
        isDismissible: false,
        ignoreSafeArea: false,
        isScrollControlled: true,
      );
    } else {
      startLocationStream();
      initializeCamera();
    }
  }

  void startLocationStream() {
    Geolocator.getPositionStream().listen((position) {
      latitude = position.latitude;
      longitude = position.longitude;
      update();
    });
  }

  Future<void> initializeCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();

      cameraController = CameraController(cameras[0], ResolutionPreset.medium,
          enableAudio: false);

      await cameraController!.initialize();

      cameraController!.startImageStream(_onLastFrame);

      update();
    } catch (e) {}
  }

  Future _onLastFrame(CameraImage image) async {
    if (isAuto) {
      if (isPlateDetectionRequestRunning) {
        return;
      }

      isPlateDetectionRequestRunning = true;
      update();

      ReceivePort responsePort = ReceivePort();
      var data =
          IsolateData(cameraImage: image, responsePort: responsePort.sendPort);

      isolateUtils.sendPort.send(data);

      responsePort.listen((bytes) async {
        bool isPlateDetected = await detectPlateOnFrameBytes(bytes: bytes);
        if (isPlateDetected) {
          draggableScrollableController.animateTo(1,
              duration: Duration(milliseconds: 400), curve: Curves.easeInCubic);
        }
      });
    }
  }

  Future<bool> detectPlateOnFrameBase64({required String base64}) async {
    var response = await detectPlateBase64Case(
        params: DetectPlateBase64CaseParams(
            image: base64,
            lat: latitude ?? 0,
            long: longitude ?? 0,
            uniqueIdentifier: uniqueIdentifier));

    return response.fold((failure) {
      return false;
    }, (success) {
      if (success != null) {
        SnackbarUtility.showSnackbar(message: "request-success-message".tr);
        lastReport = success;

        plateNumberPart1 = success.plateNumberPart1.toString();
        plateNumberPart2 = success.plateNumberPart2;
        plateNumberPart3 = success.plateNumberPart3.toString();
        plateNumberPart4 = success.plateNumberPart4.toString();

        initialPlateNumber1 = success.plateNumberPart1.toString();
        initialPlateNumber2 = success.plateNumberPart2;
        initialPlateNumber3 = success.plateNumberPart3.toString();
        initialPlateNumber4 = success.plateNumberPart4.toString();

        isDataChanged = true;
        isAuto = false;

        getPlateIdentities(
            plateNumber1: success.plateNumberPart1,
            plateNumber2: success.plateNumberPart2,
            plateNumber3: success.plateNumberPart3,
            plateNumber4: success.plateNumberPart4);

        update();
        _resetDataChanged();
        return true;
      } else {
        return false;
      }
    });
  }

  Future<bool> detectPlateOnFrameBytes({required Uint8List bytes}) async {
    var response = await detectPlateBytesCase(
        params: DetectPlateBytesCaseParams(
            image: bytes,
            lat: latitude ?? 0,
            long: longitude ?? 0,
            uniqueIdentifier: uniqueIdentifier));

    return response.fold((failure) {
      isPlateDetectionRequestRunning = false;
      update();
      return false;
    }, (success) {
      isPlateDetectionRequestRunning = false;
      update();
      if (success != null) {
        lastReport = success;

        plateNumberPart1 = success.plateNumberPart1.toString();
        plateNumberPart2 = success.plateNumberPart2;
        plateNumberPart3 = success.plateNumberPart3.toString();
        plateNumberPart4 = success.plateNumberPart4.toString();

        initialPlateNumber1 = success.plateNumberPart1.toString();
        initialPlateNumber2 = success.plateNumberPart2;
        initialPlateNumber3 = success.plateNumberPart3.toString();
        initialPlateNumber4 = success.plateNumberPart4.toString();

        isDataChanged = true;
        isAuto = false;

        getPlateIdentities(
            plateNumber1: success.plateNumberPart1,
            plateNumber2: success.plateNumberPart2,
            plateNumber3: success.plateNumberPart3,
            plateNumber4: success.plateNumberPart4);

        update();
        _resetDataChanged();

        return true;
      } else {
        return false;
      }
    });
  }

  void getLastReport() async {
    var response = await getReportsCase(
        params: GetReportsCaseParams(
            page: 1,
            pageSize: 1,
            date: "",
            plateNumberPart1: 0,
            plateNumberPart2: "",
            plateNumberPart3: 0,
            plateNumberPart4: 0));

    response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
    }, (success) {
      if (success.length > 0) {
        lastReport = success.first;

        plateNumberPart1 = success.first.plateNumberPart1.toString();
        plateNumberPart2 = success.first.plateNumberPart2;
        plateNumberPart3 = success.first.plateNumberPart3.toString();
        plateNumberPart4 = success.first.plateNumberPart4.toString();

        initialPlateNumber1 = success.first.plateNumberPart1.toString();
        initialPlateNumber2 = success.first.plateNumberPart2;
        initialPlateNumber3 = success.first.plateNumberPart3.toString();
        initialPlateNumber4 = success.first.plateNumberPart4.toString();

        isDataChanged = true;

        getPlateIdentities(
            plateNumber1: success.first.plateNumberPart1,
            plateNumber2: success.first.plateNumberPart2,
            plateNumber3: success.first.plateNumberPart3,
            plateNumber4: success.first.plateNumberPart4);

        update();

        _resetDataChanged();
      }
    });
  }

  void _resetDataChanged() {
    Future.delayed(Duration(seconds: 1), () {
      isDataChanged = false;
    });
  }

  Future<bool> addPlateIdentity(String phoneNumber) async {
    var response = await addPlateIdentityCase(
        params: AddPlateIdentityCaseParams(
            plateNumberPart1: int.parse(plateNumberPart1),
            ownerMobileNumber: phoneNumber,
            plateNumberPart2: plateNumberPart2,
            plateNumberPart3: int.parse(plateNumberPart3),
            plateNumberPart4: int.parse(plateNumberPart4)));

    return response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
      return false;
    }, (success) {
      SnackbarUtility.showSnackbar(message: "request-success-message".tr);
      getPlateIdentities(
          plateNumber1: int.parse(plateNumberPart1),
          plateNumber2: plateNumberPart2,
          plateNumber3: int.parse(plateNumberPart3),
          plateNumber4: int.parse(plateNumberPart4));
      return true;
    });
  }

  void updatePlate() async {
    if (lastReport == null) {
      return;
    }

    var response = await updatePlateCase(
        params: UpdatePlateCaseParams(
            id: lastReport!.id,
            plateNumberPart1: int.parse(plateNumberPart1),
            plateNumberPart2: plateNumberPart2,
            plateNumberPart3: int.parse(plateNumberPart3),
            plateNumberPart4: int.parse(plateNumberPart4)));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      lastReport = success;

      plateNumberPart1 = success.plateNumberPart1.toString();
      plateNumberPart2 = success.plateNumberPart2;
      plateNumberPart3 = success.plateNumberPart3.toString();
      plateNumberPart4 = success.plateNumberPart4.toString();

      initialPlateNumber1 = success.plateNumberPart1.toString();
      initialPlateNumber2 = success.plateNumberPart2;
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
      _resetDataChanged();
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

  void updateIsNightMode(bool value) {
    isNightModeOn = value;
    update();
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
            plateNumberPart1: int.parse(plateNumberPart1),
            plateNumberPart2: plateNumberPart2,
            plateNumberPart3: int.parse(plateNumberPart3),
            plateNumberPart4: int.parse(plateNumberPart4)));

    response.fold(
        (failure) => SnackbarUtility.showSnackbar(message: failure.message),
        (success) {
      phoneNumbers = success;
      isPhoneNumbersLoaded = true;
      update();
    });
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
        getLastReport();
        return true;
      } else {
        SnackbarUtility.showSnackbar(message: "request-failed-response".tr);
        return false;
      }
    });
  }
}
