import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class PaymentTypeWidget extends StatelessWidget {
  final String title;
  final String description;

  const PaymentTypeWidget(
      {super.key, required this.description, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      child: Row(
        children: [
          Icon(
            FeatherIcons.creditCard,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            children: [
              Text(title),
              SizedBox(
                height: 15,
              ),
              Text(description)
            ],
          ),
          Spacer(),
          Checkbox(value: false, onChanged: (value) {})
        ],
      ),
    );
  }
}
