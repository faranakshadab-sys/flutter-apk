import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-icon-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/common/presentation/widgets/time-widget.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/widgets/camera-view.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/widgets/report-bottom-sheet.dart';
import 'package:parkingandroid/features/moto-park/home/presentation/controllers/home-controller.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final DraggableScrollableController draggableScrollableController =
      DraggableScrollableController();
  late MotoParkHomeController controller;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      controller.cameraController!.stopImageStream();
      controller.cameraController!.dispose();
    }

    if (state == AppLifecycleState.resumed) {
      controller.initializeDependencies();
    }
  }

  @override
  void initState() {
    controller = Get.find();
    controller.initializeDragableController(draggableScrollableController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (draggableScrollableController.size >= 0.8) {
          draggableScrollableController
              .animateTo(0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInCubic)
              .then((value) => draggableScrollableController.reset());

          return false;
        }
        controller.newTime = DateTime.now();
        int difference =
            controller.newTime.difference(controller.oldTime).inMilliseconds;
        controller.oldTime = controller.newTime;

        if (difference < 1000) {
          Get.closeAllSnackbars();
          return true;
        } else {
          SnackbarUtility.showSnackbar(message: "exit-snackbar-text".tr);
          return false;
        }
      },
      child: Scaffold(
        appBar: buildAppbar(context),
        body: Stack(
          children: [
            AppScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    CameraView(),
                  ]),
            ),
            ReportBottomSheet(
              draggableScrollableController: draggableScrollableController,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
        elevation: 0,
        toolbarHeight: 85,
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
