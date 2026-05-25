import 'package:flutter/material.dart';
import 'package:parkingandroid/core/utilities/text-field-utility.dart';

class AppPlateInput extends StatefulWidget {
  final String plateNumber1;
  final String plateNumber2;
  final String plateNumber3;
  final String plateNumber4;

  final void Function(String) onChangePlateNumber1;
  final void Function(String) onChangePlateNumber2;
  final void Function(String) onChangePlateNumber3;
  final void Function(String) onChangePlateNumber4;
  final double? width;
  final double? height;

  final bool? isDataChanged;
  final bool? enabled;

  AppPlateInput(
      {required this.plateNumber1,
      required this.plateNumber2,
      required this.plateNumber3,
      required this.plateNumber4,
      required this.onChangePlateNumber1,
      required this.onChangePlateNumber2,
      required this.onChangePlateNumber3,
      required this.onChangePlateNumber4,
      this.height,
      this.width,
      this.isDataChanged,
      this.enabled});

  @override
  State<AppPlateInput> createState() => _AppPlateInputState();
}

class _AppPlateInputState extends State<AppPlateInput> {
  late TextEditingController plateNumber1Controller;
  late TextEditingController plateNumber2Controller;
  late TextEditingController plateNumber3Controller;
  late TextEditingController plateNumber4Controller;

  FocusNode plateNumber1 = FocusNode();
  FocusNode plateNumber2 = FocusNode();
  FocusNode plateNumber3 = FocusNode();
  FocusNode plateNumber4 = FocusNode();

  final GlobalKey plateNumber1Key = GlobalKey();
  final GlobalKey plateNumber2Key = GlobalKey();
  final GlobalKey plateNumber3Key = GlobalKey();
  final GlobalKey plateNumber4Key = GlobalKey();

  @override
  void initState() {
    setState(() {
      plateNumber1Controller = TextEditingController(text: widget.plateNumber1);
      plateNumber2Controller = TextEditingController(
          text: widget.plateNumber2 == "ا" ? "الف" : widget.plateNumber2);
      plateNumber3Controller = TextEditingController(text: widget.plateNumber3);
      plateNumber4Controller = TextEditingController(text: widget.plateNumber4);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(AppPlateInput oldWidget) {
    if (widget.isDataChanged == true) {
      setState(() {
        plateNumber1Controller.text = widget.plateNumber1;
        plateNumber2Controller.text =
            widget.plateNumber2 == "ا" ? "الف" : widget.plateNumber2;
        plateNumber3Controller.text = widget.plateNumber3;
        plateNumber4Controller.text = widget.plateNumber4;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: widget.width ?? size.width * 0.35,
      height: widget.height ?? 40,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Container(
          height: widget.height ?? 40,
          width: (widget.width ?? size.width * 0.35) * 0.2,
          alignment: Alignment.center,
          child: TextField(
            key: plateNumber4Key,
            controller: plateNumber4Controller,
            onChanged: widget.onChangePlateNumber4,
            focusNode: plateNumber4,
            enabled: widget.enabled ?? true,
            onTap: () {
              plateNumber4Controller.selectAll();
              Scrollable.ensureVisible(plateNumber4Key.currentContext!);
            },
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            maxLength: 2,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: "- -",
              contentPadding: EdgeInsets.all(4),
              isDense: true,
            ),
          ),
        ),
        Container(
          height: widget.height ?? 40,
          width: 1.5,
          color: Colors.black,
        ),
        Container(
            height: widget.height ?? 40,
            width: (widget.width ?? size.width * 0.35) * 0.25,
            alignment: Alignment.center,
            child: TextField(
              key: plateNumber3Key,
              controller: plateNumber3Controller,
              focusNode: plateNumber3,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.onChangePlateNumber3(value);
                if (value.length == 3) {
                  plateNumber4.requestFocus();
                }
              },
              onTap: () {
                plateNumber3Controller.selectAll();
                Scrollable.ensureVisible(plateNumber3Key.currentContext!);
              },
              maxLength: 3,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              decoration: InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "- - -",
                contentPadding: EdgeInsets.all(4),
                isDense: true,
              ),
            )),
        Container(
            height: widget.height ?? 40,
            width: (widget.width ?? size.width * 0.35) * 0.2,
            alignment: Alignment.center,
            child: TextField(
              key: plateNumber2Key,
              controller: plateNumber2Controller,
              maxLength: 1,
              focusNode: plateNumber2,
              keyboardType: TextInputType.text,
              onTap: () {
                plateNumber2Controller.selectAll();
                Scrollable.ensureVisible(plateNumber2Key.currentContext!);
              },
              onChanged: (value) {
                widget.onChangePlateNumber2(value);

                if (value == "ا") {
                  plateNumber2Controller.text = "الف";
                }
                if (value.length == 1) {
                  plateNumber3.requestFocus();
                }
              },
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4),
                counterText: "",
                hintText: "-",
                isDense: true,
              ),
            )),
        SizedBox(
          width: 7,
        ),
        Container(
            height: widget.height ?? 40,
            width: (widget.width ?? size.width * 0.35) * 0.2,
            alignment: Alignment.center,
            child: TextField(
              key: plateNumber1Key,
              controller: plateNumber1Controller,
              maxLength: 2,
              focusNode: plateNumber1,
              textAlign: TextAlign.center,
              onTap: () {
                plateNumber1Controller.selectAll();
                Scrollable.ensureVisible(plateNumber1Key.currentContext!);
              },
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.onChangePlateNumber1(value);

                if (value.length == 2) {
                  plateNumber2.requestFocus();
                }
              },
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4),
                counterText: "",
                hintText: "- -",
                isDense: true,
              ),
            )),
        Spacer(),
        Container(
          height: widget.height ?? 40,
          width: 1.5,
          color: Colors.black,
        ),
        Container(
          height: widget.height ?? 40,
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
