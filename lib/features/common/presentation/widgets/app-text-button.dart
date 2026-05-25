import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final bool isRequestRunning;
  final void Function() onTab;

  AppTextButton(
      {required this.isRequestRunning,
      required this.onTab,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
            onTap: isRequestRunning ? null : onTab,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ))));
  }
}
