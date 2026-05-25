import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoading extends StatelessWidget {
  final Widget child;
  final bool loading;

  AppLoading({required this.child, required this.loading});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: buildLoading(context),
      secondChild: child,
      crossFadeState:
          loading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Duration(milliseconds: 400),
      reverseDuration: Duration(milliseconds: 400),
      firstCurve: Curves.easeInCubic,
      secondCurve: Curves.easeInCubic,
      sizeCurve: Curves.easeInCubic,
    );
  }
}

Widget buildLoading(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.height,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: size.width * 0.6, child: LinearProgressIndicator()),
        SizedBox(
          height: size.width * 0.05,
        ),
        Text(
          "loading-data-text".tr,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    ),
  );
}
