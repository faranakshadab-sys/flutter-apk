import 'package:flutter/material.dart';

class PaymentStatusBadge extends StatelessWidget {
  final Color color;
  final String title;

  PaymentStatusBadge({required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 35,
      decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
