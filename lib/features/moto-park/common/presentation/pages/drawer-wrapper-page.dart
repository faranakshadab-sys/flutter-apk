import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/routes/moto-park-navigator.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-drawer.dart';

class MotoParkDrawerWrapperPage extends StatefulWidget {
  @override
  State<MotoParkDrawerWrapperPage> createState() =>
      _MotoParkDrawerWrapperPageState();
}

class _MotoParkDrawerWrapperPageState extends State<MotoParkDrawerWrapperPage> {
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
      body: MotoParkNavigator.navigator,
    ));
  }
}
