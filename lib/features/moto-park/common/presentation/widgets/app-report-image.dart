import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/widgets/app-scroll-view.dart';

class AppReportImage extends StatelessWidget {
  const AppReportImage(
      {super.key,
      required this.carImage,
      required this.plateImage,
      required this.index,
      required this.time});
  final String carImage;
  final String plateImage;
  final int index;
  final String time;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () {
          Get.bottomSheet(
            FullScreenModal(
              image: carImage,
            ),
            enableDrag: true,
            isDismissible: false,
            ignoreSafeArea: false,
            isScrollControlled: true,
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: carImage,
                  width: size.width * 0.75,
                  height: size.width * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: size.width * 0.2,
                  height: size.width * 0.1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: size.width * 0.2,
                  height: size.width * 0.1,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Text("عکس $index",
                      style: Theme.of(context).textTheme.bodyLarge),
                ))
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: plateImage,
          width: size.width * 0.33,
          height: size.height * 0.05,
          fit: BoxFit.fill,
        ),
      )
    ]);
  }
}

class FullScreenModal extends StatefulWidget {
  final String image;

  FullScreenModal({super.key, required this.image});

  @override
  State<FullScreenModal> createState() => _FullScreenModalState();
}

class _FullScreenModalState extends State<FullScreenModal> {
  final FocusNode _focusNode = FocusNode();

  final TransformationController transformationController =
      TransformationController();
  ScrollController _scrollController = new ScrollController();

  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 50) {
      Navigator.pop(context);
    }
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: AppScrollView(
        controller: _scrollController,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: size.width * 0.03),
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(FeatherIcons.arrowLeft)),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width,
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 2.5,
                  onInteractionEnd: (details) {
                    setState(() {
                      transformationController.value = Matrix4.identity();
                    });
                  },
                  transformationController: transformationController,
                  child: CachedNetworkImage(
                    imageUrl: widget.image,
                    width: size.width,
                    height: size.height * 0.8,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
