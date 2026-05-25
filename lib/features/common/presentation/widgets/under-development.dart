import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UnderDevelopment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Spacer(),
          Lottie.asset('assets/animations/under-development.json',
              width: size.width * 0.8),
          SizedBox(
            height: 20,
          ),
          Text(
            "under-development-title".tr,
            style: TextStyle(color: Colors.white),
          ),
          Spacer()
        ],
      ),
    );
  }
}
