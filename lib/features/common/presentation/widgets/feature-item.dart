import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String image;
  final void Function() onTab;

  FeatureItem({required this.image, required this.onTab, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Material(
      color: Color(0xff101929),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTab,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06, vertical: size.width * 0.08),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              SizedBox(
                height: size.width * 0.08,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
