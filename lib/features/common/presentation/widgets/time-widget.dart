import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TimeWidget extends StatefulWidget {
  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          timeString,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          jalaliDate,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
