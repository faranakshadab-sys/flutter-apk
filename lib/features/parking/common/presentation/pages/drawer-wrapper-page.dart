import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/routes/parking-navigator.dart';

import '../widgets/app-drawer.dart';

class ParkingDrawerWrapperPage extends StatefulWidget {
  @override
  State<ParkingDrawerWrapperPage> createState() =>
      _ParkingDrawerWrapperPageState();
}

class _ParkingDrawerWrapperPageState extends State<ParkingDrawerWrapperPage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    Get.put<GlobalKey<ScaffoldState>>(globalKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawerEnableOpenDragGesture: false,
      key: globalKey,
      drawer: AppDrawer(),
      body: ParkingNavigator.navigator,
    ));
  }
}
