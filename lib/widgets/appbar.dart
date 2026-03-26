import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turfnpark/Pages/notification_page.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? leftImage;
  final String title;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final bool showBackButton;
  final bool hideRightIcon; // NEW: explicit control to hide right icon

  const CustomAppbar({
    super.key,
    this.leftImage,
    this.title = "",
    this.rightIcon,
    this.onRightIconPressed,
    this.showBackButton = true,
    this.hideRightIcon = false, // default: false, so icon shows
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: false,
      titleSpacing: 18,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: leftImage != null
          ? SvgPicture.asset(leftImage!, height: 44, fit: BoxFit.contain)
          : Text(
              title,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
      actions: hideRightIcon
          ? null
          : [
              IconButton(
                onPressed:
                    onRightIconPressed ??
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ),
                      );
                    },
                icon: Icon(
                  rightIcon ?? Icons.notifications,
                  color: Colors.black,
                ),
              ),
            ],
    );
  }
}
