import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final void Function() onTab;
  final void Function()? onLongPress;
  final bool isRequestRunning;
  final double? width;
  final double? height;
  final String title;
  final bool? enabled;
  final Color? color;

  AppFilledButton(
      {required this.isRequestRunning,
      required this.onTab,
      required this.title,
      this.onLongPress,
      this.width,
      this.height,
      this.enabled,
      this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
        borderRadius: BorderRadius.circular(8),
        color: enabled == false
            ? Colors.grey[600]
            : color ?? Theme.of(context).colorScheme.primaryContainer,
        elevation: 2,
        child: InkWell(
          onTap: isRequestRunning || enabled == false ? null : onTab,
          onLongPress:
              isRequestRunning || enabled == false ? null : onLongPress,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: width ?? size.width * 0.9,
            height: height ?? size.width * 0.125,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: isRequestRunning
                ? Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
          ),
        ));
  }
}
