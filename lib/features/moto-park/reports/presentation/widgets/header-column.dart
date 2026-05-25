import 'package:flutter/material.dart';

class HeaderColumn extends StatelessWidget {
  final double width;
  final String title;

  HeaderColumn({required this.title, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 20),
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
