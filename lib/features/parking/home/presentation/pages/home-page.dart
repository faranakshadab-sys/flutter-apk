import 'dart:async';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/app-isolates.dart';
import 'package:parkingandroid/core/utilities/receipt-plaform-channel.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-icon-button.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/camera-view.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/confirm-information-modal.dart';
import 'package:parkingandroid/features/parking/home/presentation/widgets/permission-modal.dart';
import '../controllers/home-controller.dart';
import '../../../../common/presentation/widgets/time-widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late HomeController controller;
  CameraController? cameraController;
  late IsolateUtils isolateUtils;

  ReceiptPlatformChannel channel = ReceiptPlatformChannel();

  DateTime oldTime = DateTime.now();
  DateTime newTime = DateTime.now();

  final GlobalKey plateKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      precacheImage(AssetImage('assets/icons/isf-logo.svg'), context);
    });

    controller = Get.find<HomeController>();
    initializeDependencies();
    initializeIsolateUtils();

    Future.delayed(Duration(milliseconds: 2000), () {
      Get.bottomSheet(ConfirmInformationModal(),
          enableDrag: false,
          ignoreSafeArea: true,
          isScrollControlled: true,
          isDismissible: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor);
    });

    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController!.stopImageStream();
      cameraController!.dispose();
    }

    if (state == AppLifecycleState.resumed) {
      initializeDependencies();
    }
  }

  Future initializeIsolateUtils() async {
    isolateUtils = IsolateUtils();
    await isolateUtils.start();
  }

  Future<void> initializeCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();

      cameraController = CameraController(cameras[0], ResolutionPreset.medium,
          enableAudio: false);

      await cameraController!.initialize();

      cameraController!.startImageStream(_onLastFrame);

      setState(() {});
    } catch (e) {}
  }

  Future _onLastFrame(CameraImage image) async {
    if (controller.isAuto) {
      if (controller.isRequestRunning) {
        return;
      }

      controller.handleRequestRunning(true);

      ReceivePort responsePort = ReceivePort();
      var data =
          IsolateData(cameraImage: image, responsePort: responsePort.sendPort);

      isolateUtils.sendPort.send(data);

      responsePort.listen((bytes) async {
        bool isDetected =
            await controller.detectPlateOnFrameBytes(bytes: bytes);

        if (isDetected) {
          Get.bottomSheet(ConfirmInformationModal(),
              isScrollControlled: true,
              isDismissible: false,
              enableDrag: false,
              ignoreSafeArea: true);

          controller.updateIsAuto(false);
        }
      });
    }
  }

  Future<void> initializeDependencies() async {
    String? response =
        await Get.find<HomeController>().checkRequiredPermissions();

    if (response != null && mounted) {
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
      initializeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(),
          body: Stack(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    CameraView(
                      controller: cameraController,
                      resetRequestRunning: () {
                        controller.handleRequestRunning(false);
                      },
                    ),
                  ]),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        newTime = DateTime.now();
        int difference = newTime.difference(oldTime).inMilliseconds;
        oldTime = newTime;

        if (difference < 1000) {
          Get.closeAllSnackbars();
          return true;
        } else {
          SnackbarUtility.showSnackbar(message: "exit-snackbar-text".tr);
          return false;
        }
      },
    );
  }

  AppBar buildAppbar() {
    return AppBar(
        elevation: 0,
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppIconButton(
                    isRequestRunning: false,
                    onTab: () {
                      Get.find<GlobalKey<ScaffoldState>>()
                          .currentState!
                          .openDrawer();
                    },
                    icon: FeatherIcons.menu),
                Spacer(
                  flex: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/isf-logo.svg",
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "شهرداری اصفهان",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
                TimeWidget(),
              ]),
        ));
  }
}
