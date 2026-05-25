import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/feature-item.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      SvgAssetLoader('assets/icons/parking-icon.svg');
      SvgAssetLoader('assets/icons/moto-park-icon.svg');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              FeatureItem(
                  image: "assets/icons/parking-icon.svg",
                  onTab: () {
                    Get.toNamed("/parking");
                  },
                  title: "parking-title".tr),
              SizedBox(
                height: size.width * 0.06,
              ),
              FeatureItem(
                  image: "assets/icons/moto-park-icon.svg",
                  onTab: () {
                    Get.toNamed("/moto-park");
                  },
                  title: "moto-park-title".tr),
            ]),
      ),
    );
  }
}
