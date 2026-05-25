import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/parking/reports/presentation/widgets/table-item.dart';

import '../controllers/reports-controller.dart';
import 'header-column.dart';

class ReportTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          borderRadius: BorderRadius.circular(8)),
      child: GetBuilder<ReportsController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTableHeader(size),
            ...controller.reports.map((report) => TableItem(report: report))
          ],
        );
      }),
    );
  }

  Container buildTableHeader(Size size) {
    return Container(
      height: size.width * 0.1,
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
    );
  }
}
