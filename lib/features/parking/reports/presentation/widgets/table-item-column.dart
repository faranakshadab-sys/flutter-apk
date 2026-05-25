import 'package:flutter/widgets.dart';

class TableItemColumn extends StatelessWidget {
  final double width;
  final Widget child;

  TableItemColumn({required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 20),
      child: child,
    );
  }
}
