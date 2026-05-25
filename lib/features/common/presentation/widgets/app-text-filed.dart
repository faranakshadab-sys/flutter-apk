import 'package:flutter/material.dart';

class AppTextFiled extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String value;
  final void Function(String value) onChangeValue;
  final TextEditingController controller;

  final TextInputType? inputType;
  final bool? enabled;
  final int? maxLength;
  final dataKey = GlobalKey();

  AppTextFiled(
      {required this.hintText,
      required this.labelText,
      required this.onChangeValue,
      required this.value,
      required this.controller,
      this.inputType,
      this.enabled,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChangeValue,
      style: TextStyle(color: Colors.white),
      keyboardType: inputType,
      maxLength: maxLength,
      enabled: enabled,
      onTap: () {
        Scrollable.ensureVisible(dataKey.currentContext!);
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          counterText: "",
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium),
    );
  }
}
