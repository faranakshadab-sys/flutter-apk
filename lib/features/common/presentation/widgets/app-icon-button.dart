import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final bool isRequestRunning;
  final void Function() onTab;
  final IconData icon;
  final Color? color;
  final bool? enabled;

  AppIconButton(
      {required this.isRequestRunning,
      required this.onTab,
      required this.icon,
      this.color,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8),
        color:
            enabled == false ? Colors.grey[600] : color ?? Colors.transparent,
        elevation: 1,
        child: InkWell(
            onTap: isRequestRunning || enabled == false ? null : onTab,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                child: Icon(
                  icon,
                  size: 22,
                ))));
  }
}
