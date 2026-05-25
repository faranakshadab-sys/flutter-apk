import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../domain/models/report-view-model.dart';
import 'app-report-image.dart';

class AppReportImageSlider extends StatelessWidget {
  final List<ReportImageViewModel> images;

  AppReportImageSlider({required this.images});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
          height: size.width,
          aspectRatio: 16 / 9,
          viewportFraction: 0.85,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollPhysics: BouncingScrollPhysics(),
          disableCenter: true,
          enableInfiniteScroll: false,
          initialPage: images.length - 1,
          reverse: true),
      items: images.map((reportImage) {
        return Builder(
          builder: (BuildContext context) {
            return AppReportImage(
              carImage: reportImage.mainImage,
              plateImage: reportImage.plateImage,
              index: images.indexOf(reportImage) + 1,
              time: reportImage.createdAt.split(" ").last,
            );
          },
        );
      }).toList(),
    );
  }
}
