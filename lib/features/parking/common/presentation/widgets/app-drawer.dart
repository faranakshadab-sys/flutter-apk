import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/routes/parking-navigator.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';
import 'package:parkingandroid/features/common/presentation/widgets/drawer-item.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Container(
        width: size.width * 0.7,
        height: size.height,
        child: AppScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.width * 0.2,
              ),
              SvgPicture.asset(
                "assets/icons/arad-icon.svg",
                width: size.width * 0.5,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: size.width * 0.2,
              ),
              DrawerItem(
                isActive: false,
                onTab: () {
                  if (ParkingNavigator.currentRoute == "/home") {
                    Scaffold.of(context).closeDrawer();
                    return;
                  }

                  Scaffold.of(context).closeDrawer();
                  Get.toNamed("/home", id: 1);
                },
                icon: FeatherIcons.home,
                title: "drawer-home".tr,
              ),
              SizedBox(height: 10),
              DrawerItem(
                isActive: false,
                onTab: () {
                  if (ParkingNavigator.currentRoute == "/reports") {
                    Scaffold.of(context).closeDrawer();
                    return;
                  }
                  Scaffold.of(context).closeDrawer();
                  Get.toNamed("/reports", id: 1);
                },
                icon: FeatherIcons.fileText,
                title: "drawer-reports".tr,
              ),
              SizedBox(height: 10),
              DrawerItem(
                isActive: false,
                onTab: () {
                  if (ParkingNavigator.currentRoute == "/profile") {
                    Scaffold.of(context).closeDrawer();
                    return;
                  }
                  Scaffold.of(context).closeDrawer();
                  Get.toNamed("/profile", id: 1);
                },
                icon: FeatherIcons.user,
                title: "drawer-profile".tr,
              ),
              Spacer(),
              DrawerItem(
                isActive: false,
                onTab: () {
                  Scaffold.of(context).closeDrawer();
                  Get.offAllNamed("/welcome")!.then((value) => Get.deleteAll());
                },
                icon: FeatherIcons.logOut,
                title: "drawer-exit".tr,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
