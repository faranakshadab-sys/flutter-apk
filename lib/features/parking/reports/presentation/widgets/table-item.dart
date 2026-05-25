import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/number-utility.dart';
import 'package:parkingandroid/features/parking/reports/presentation/widgets/payment-status-badge.dart';
import 'package:parkingandroid/features/parking/reports/presentation/widgets/table-item-column.dart';
import 'package:parkingandroid/features/parking/common/presentation/widgets/plate-view.dart';

import '../../../common/domain/models/report-view-model.dart';

class TableItem extends StatelessWidget {
  final ReportViewModel report;

  TableItem({required this.report});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        decoration: BoxDecoration(
            color: Color(0xff0B121F),
            border: Border(
                bottom: BorderSide(
                    color: Color(
                      0xff1A253A,
                    ),
                    width: 1))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TableItemColumn(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        report.createdAt.split(" ").last,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        report.createdAt.split(" ").first,
                        style: TextStyle(color: Color(0xff969BA3)),
                      ),
                      Text(
                        report.address,
                        style: TextStyle(color: Color(0xff969BA3)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                width: 120,
              ),
              SizedBox(
                width: 10,
              ),
              TableItemColumn(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CachedNetworkImage(
                      imageUrl: report.images.first.plateImage,
                      fit: BoxFit.fill,
                      width: 170,
                      height: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    PlateView(
                      plateNumber1: report.plateNumberPart1.toString(),
                      plateNumber2: report.plateNumberPart2.toString(),
                      plateNumber3: report.plateNumberPart3.toString(),
                      plateNumber4: report.plateNumberPart4.toString(),
                    ),
                  ],
                ),
                width: 200,
              ),
              SizedBox(
                width: 10,
              ),
              TableItemColumn(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      report.totalParkTime,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${NumberUtility.format(report.totalAmount.toString())} " +
                          "rial-text".tr,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                width: 150,
              ),
              SizedBox(
                width: 10,
              ),
              TableItemColumn(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: PaymentStatusBadge(
                    color: report.paymentStatus == 2
                        ? Color(0xff1abc9c)
                        : Color(0xfff1c40f),
                    title: report.paymentStatusText,
                  ),
                ),
                width: 100,
              ),
              SizedBox(
                width: 10,
              ),
              TableItemColumn(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed("/report-information",
                          id: 1, arguments: report.id);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Icon(FeatherIcons.moreVertical),
                    ),
                  ),
                ),
                width: 50,
              )
            ]));
  }
}
