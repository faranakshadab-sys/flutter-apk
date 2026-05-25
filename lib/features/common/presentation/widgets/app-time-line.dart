import 'package:flutter/material.dart';
import 'package:parkingandroid/core/utilities/dashed-line-painter.dart';

class AppTimeLine extends StatelessWidget {
  final String enterTime;
  final String exitTime;

  AppTimeLine({required this.enterTime, required this.exitTime});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: size.width * 0.73,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    exitTime,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
                Container(
                  width: size.width * 0.15,
                  alignment: Alignment.center,
                  child: Text(
                    enterTime,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                )
              ],
            )),
        SizedBox(
          height: 8,
        ),
        Container(
          width: size.width * 0.6,
          child: Row(children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
            ),
            Expanded(
              child: CustomPaint(
                  painter: DashedLinePainter(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer)),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  borderRadius: BorderRadius.circular(8)),
            )
          ]),
        ),
      ],
    );
  }
}
