import 'package:flutter/material.dart';

class PlateView extends StatelessWidget {
  final String plateNumber1;
  final String plateNumber2;
  final String plateNumber3;
  final String plateNumber4;
  final double? width;
  final double? height;

  PlateView(
      {required this.plateNumber1,
      required this.plateNumber2,
      required this.plateNumber3,
      required this.plateNumber4,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: height ?? 40,
      width: width ?? size.width * 0.45,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(
          height: 40,
          width: (size.width * 0.45) * 0.2,
          alignment: Alignment.center,
          child: Text(
            plateNumber4,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          height: 40,
          width: 1.5,
          color: Colors.black,
        ),
        Container(
            height: 40,
            width: (size.width * 0.45) * 0.23,
            alignment: Alignment.center,
            child: Text(
              plateNumber3,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )),
        Container(
            height: 40,
            width: (size.width * 0.45) * 0.2,
            alignment: Alignment.center,
            child: Text(
              plateNumber2,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )),
        SizedBox(
          width: 7,
        ),
        Container(
            height: 40,
            width: (size.width * 0.45) * 0.2,
            alignment: Alignment.center,
            child: Text(
              plateNumber1,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )),
        Spacer(),
        Container(
          height: 40,
          width: 1.5,
          color: Colors.black,
        ),
        Container(
          height: 40,
          width: 12,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6), bottomLeft: Radius.circular(6))),
        )
      ]),
    );
  }
}
