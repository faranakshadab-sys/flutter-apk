import 'package:flutter/material.dart';

class AppScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final Axis? direction;

  AppScrollView({required this.child, this.controller, this.direction});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          scrollDirection: direction ?? Axis.vertical,
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: child,
              )));
    });
  }
}
