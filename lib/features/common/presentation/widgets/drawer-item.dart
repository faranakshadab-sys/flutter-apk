import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final void Function() onTab;
  final String title;
  final IconData icon;
  final bool isActive;

  const DrawerItem(
      {super.key,
      required this.icon,
      required this.onTab,
      required this.title,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.86,
      child: Material(
        type: MaterialType.button,
        color: isActive
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        animationDuration: Duration(milliseconds: 400),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTab,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.width * 0.04, horizontal: size.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 28,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
