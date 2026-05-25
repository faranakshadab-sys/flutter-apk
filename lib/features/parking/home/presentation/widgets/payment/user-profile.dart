import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      child: Row(
        children: [
          Container(
            width: Get.width * 0.11,
            height: Get.width * 0.11,
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(Get.width * 0.11)),
            alignment: Alignment.center,
            child: Icon(
              FeatherIcons.user,
              color: Color(0xff85ADFF),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Text(
                "عرفان جباری",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "09395398485",
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
