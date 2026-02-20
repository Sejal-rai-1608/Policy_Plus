import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turfnpark/Pages/notification_page.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String leftImage;
  final String rightImage;
  final String title;

  const CustomAppbar({
    super.key,
    required this.leftImage,
    required this.rightImage,
    this.title = "",
  });

  @override
  Size get preferredSize => const Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: false,
      titleSpacing: 8,

      title: SvgPicture.asset(leftImage, height: 34, fit: BoxFit.contain),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
            icon: SvgPicture.asset(rightImage, height: 24),
          ),
        ),
      ],
    );
  }
}
