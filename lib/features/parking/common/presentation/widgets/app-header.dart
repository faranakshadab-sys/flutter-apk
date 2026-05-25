import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

import '../../../../common/presentation/widgets/app-icon-button.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
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
              AppIconButton(
                  isRequestRunning: false,
                  onTab: () {
                    Get.back(id: 1);
                  },
                  icon: FeatherIcons.arrowLeft),
            ],
          ),
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(85);
}
