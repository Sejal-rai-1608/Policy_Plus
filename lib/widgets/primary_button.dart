import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color textColor; // ✅ text color control
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final bool fullWidth;
  final Widget? icon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white, // ✅ default text color
    this.backgroundColor = const Color(0xffF58220),
    this.borderRadius = 14,
    this.height = 50,
    this.fullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          elevation: 0,
        ),
        child: icon == null
            ? Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor, // ✅ apply color
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  SizedBox(width: 8.w),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: textColor, // ✅ apply here also
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
