import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class InformationDateAndTime extends StatefulWidget {
  const InformationDateAndTime({
    super.key,
  });

  @override
  State<InformationDateAndTime> createState() => _InformationDateAndTimeState();
}

class _InformationDateAndTimeState extends State<InformationDateAndTime> {
  String timeString = "";
  String jalaliDate = "";

  @override
  void initState() {
    var date = DateTime.now().toJalali();
    setState(() {
      jalaliDate =
          "${date.year}/${date.month < 10 ? "0${date.month}" : date.month}/${date.day < 10 ? "0${date.day}" : date.day}";
    });
    timeString =
        "${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour}";
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getCurrentTime());
    super.initState();
  }

  void _getCurrentTime() {
    if (mounted) {
      setState(() {
        timeString =
            "${DateTime.now().minute < 10 ? "0${DateTime.now().minute}" : DateTime.now().minute} : ${DateTime.now().hour < 10 ? "0${DateTime.now().hour}" : DateTime.now().hour}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            jalaliDate,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Color(0xff969BA3)),
          ),
          Text(
            timeString,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
