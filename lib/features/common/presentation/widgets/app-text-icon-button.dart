import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppIconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onTab;
  final bool isRequestRunning;

  const AppIconTextButton(
      {super.key,
      required this.icon,
      required this.onTab,
      required this.text,
      required this.isRequestRunning});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        child: InkWell(
            onTap: isRequestRunning ? null : onTab,
            borderRadius: BorderRadius.circular(8),
            child: Container(
                width: Get.width * 0.9,
                height: Get.width * 0.125,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(icon),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ))));
  }
}
