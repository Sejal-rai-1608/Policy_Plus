import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle mainTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle subTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle mainTitlewithgrey = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade600,
  );
  static TextStyle mainTitlewithwhite = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle fieldLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey.shade700,
  );

  static TextStyle hintText = TextStyle(fontSize: 14.sp, color: Colors.grey);

  static TextStyle errorText = TextStyle(fontSize: 12.sp, color: Colors.red);

  static TextStyle successText = TextStyle(
    fontSize: 12.sp,
    color: Colors.green.shade900,
  );

  static TextStyle smallText = TextStyle(fontSize: 11.sp, color: Colors.black);

  static TextStyle cardTitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static TextStyle cardSubtitle = TextStyle(
    fontSize: 12.sp,
    color: Colors.grey.shade600,
    decoration: TextDecoration.underline,
  );

  static TextStyle cardMeta = TextStyle(
    fontSize: 13.sp,
    color: Colors.grey.shade700,
  );

  static TextStyle badgeText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle whiteSubtitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
