import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/plate-identity-model.dart';
import '../../../../common/presentation/widgets/app-filled-button.dart';
import '../../../../common/presentation/widgets/app-text-button.dart';
import '../../../../common/presentation/widgets/app-text-filed.dart';

class AppReportPhoneInput extends StatefulWidget {
  final List<PlateIdentityModel> phones;
  final Future<bool> Function(String) onAddPhoneNumber;

  AppReportPhoneInput({required this.onAddPhoneNumber, required this.phones});

  @override
  State<AppReportPhoneInput> createState() => _AppReportPhoneInputState();
}

class _AppReportPhoneInputState extends State<AppReportPhoneInput> {
  bool isExpanded = false;

  Future<bool> handleAddPhone(String value) async {
    bool isPhoneAdded = await widget.onAddPhoneNumber(value);
    if (isPhoneAdded) {
      setState(() {
        isExpanded = false;
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedCrossFade(
          firstChild: ReportPhoneEmpty(
            isExpanded: isExpanded,
            onChangeExpaned: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          secondChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...widget.phones.map((phone) {
                int index = widget.phones.indexOf(phone);
                return ReportPhone(
                  isExpanded: isExpanded,
                  isLastPhone: index == 0,
                  onChangeExpaned: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  phone: phone,
                );
              }),
            ],
          ),
          crossFadeState: widget.phones.length == 0
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 400),
          firstCurve: Curves.easeInCubic,
          secondCurve: Curves.easeInCubic,
          sizeCurve: Curves.easeInCubic,
          reverseDuration: Duration(milliseconds: 400),
        ),
        AnimatedCrossFade(
          firstChild: Container(
            padding: EdgeInsets.only(top: size.width * 0.03),
            child: PhoneInputWithButton(
              onAddPhone: handleAddPhone,
            ),
          ),
          secondChild: Container(),
          crossFadeState:
              isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(milliseconds: 400),
          reverseDuration: Duration(milliseconds: 400),
          firstCurve: Curves.easeOutCubic,
          secondCurve: Curves.easeOutCubic,
          sizeCurve: Curves.easeOutCubic,
        )
      ],
    );
  }
}

class PhoneInputWithButton extends StatefulWidget {
  final Future<bool> Function(String) onAddPhone;

  const PhoneInputWithButton({super.key, required this.onAddPhone});

  @override
  State<PhoneInputWithButton> createState() => _PhoneInputWithButtonState();
}

class _PhoneInputWithButtonState extends State<PhoneInputWithButton> {
  TextEditingController controller = TextEditingController();
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width * 0.6,
          height: size.width * 0.12,
          child: AppTextFiled(
              hintText: "",
              labelText: "phone-text".tr,
              maxLength: 11,
              onChangeValue: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
              value: phoneNumber,
              inputType: TextInputType.number,
              controller: controller),
        ),
        SizedBox(
          height: 10,
        ),
        AppFilledButton(
            width: size.width * 0.2,
            height: size.width * 0.12,
            enabled: phoneNumber.length == 11,
            onTab: () async {
              FocusScope.of(context).unfocus();

              bool isAdded = await widget.onAddPhone(phoneNumber);

              if (isAdded) {
                setState(() {
                  phoneNumber = "";
                });
                controller.text = "";
              }
            },
            title: "submit-text".tr,
            isRequestRunning: false),
      ],
    );
  }
}

class ReportPhoneEmpty extends StatelessWidget {
  final bool isExpanded;
  final void Function() onChangeExpaned;

  ReportPhoneEmpty({
    required this.isExpanded,
    required this.onChangeExpaned,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "شماره ای ثبت نشده",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          AppTextButton(
              isRequestRunning: false,
              onTab: onChangeExpaned,
              text: isExpanded ? "hide-text".tr : "add-text".tr)
        ]);
  }
}

class ReportPhone extends StatelessWidget {
  final bool isExpanded;
  final void Function() onChangeExpaned;
  final bool isLastPhone;
  final PlateIdentityModel phone;

  ReportPhone(
      {required this.isExpanded,
      required this.isLastPhone,
      required this.onChangeExpaned,
      required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              phone.ownerMobileNumber,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            isLastPhone
                ? AppTextButton(
                    isRequestRunning: false,
                    onTab: onChangeExpaned,
                    text: isExpanded ? "hide-text".tr : "add-text".tr)
                : Container()
          ]),
    );
  }
}
