import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/widgets/app-header.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-icon-button.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-loading.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-plate-input.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/controllers/reports-controller.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/widgets/header-column.dart';
import 'package:parkingandroid/features/moto-park/reports/presentation/widgets/table-item.dart';

class ReportsPage extends GetView<ReportsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppHeader(),
      body: GetBuilder<ReportsController>(builder: (controller) {
        return AppLoading(
          loading: controller.loading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Get.size.width * 0.05),
                margin: EdgeInsets.only(bottom: Get.size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppPlateInput(
                      width: controller.isSearchVisible
                          ? Get.size.width * 0.7
                          : Get.size.width * 0.8,
                      height: 45,
                      plateNumber1: controller.plateNumber1,
                      onChangePlateNumber1: controller.onChangePlateNumber1,
                      plateNumber2: controller.plateNumber2,
                      onChangePlateNumber2: controller.onChangePlateNumber2,
                      plateNumber3: controller.plateNumber3,
                      onChangePlateNumber3: controller.onChangePlateNumber3,
                      onChangePlateNumber4: controller.onChangePlateNumber4,
                      plateNumber4: controller.plateNumber4,
                      isDataChanged: false,
                    ),
                    AnimatedCrossFade(
                      firstChild: AppIconButton(
                        icon: FeatherIcons.search,
                        isRequestRunning: false,
                        onTab: () {
                          FocusScope.of(context).unfocus();
                          controller.handleSearchButton();
                        },
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      secondChild: Container(),
                      crossFadeState: controller.isSearchVisible
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 400),
                      firstCurve: Curves.easeInCubic,
                      reverseDuration: Duration(milliseconds: 400),
                      secondCurve: Curves.easeInCubic,
                      sizeCurve: Curves.easeInCubic,
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTableHeader(),
                    Container(
                      height: Get.size.height * 0.68,
                      width: 840,
                      child: ListView.builder(
                          controller: controller.scrollController,
                          physics: BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: controller.reports.length,
                          itemBuilder: (context, index) {
                            return TableItem(report: controller.reports[index]);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }

  SingleChildScrollView buildTableHeader() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        height: Get.size.width * 0.1,
        margin: EdgeInsets.symmetric(horizontal: Get.size.width * 0.025),
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            color: Color(0xff1A253A),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderColumn(
              title: "reports-table-header-time-title".tr,
              width: 120,
            ),
            SizedBox(
              width: 10,
            ),
            HeaderColumn(
              title: "reports-table-header-plate-title".tr,
              width: 200,
            ),
            SizedBox(
              width: 10,
            ),
            HeaderColumn(
              title: "reports-table-header-park-time-title".tr,
              width: 150,
            ),
            SizedBox(
              width: 10,
            ),
            HeaderColumn(
              title: "reports-table-header-status-title".tr,
              width: 100,
            ),
            SizedBox(
              width: 10,
            ),
            HeaderColumn(
              title: "",
              width: 50,
            )
          ],
        ),
      ),
    );
  }

  Positioned buildScrollButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
        bottom: 30,
        right: 15,
        child: AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: 1,
            curve: Curves.easeInCubic,
            child: Material(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(size.width * 0.12),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(size.width * 0.12),
                child: Container(
                  width: size.width * 0.12,
                  height: size.width * 0.12,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
            )));
  }
}
