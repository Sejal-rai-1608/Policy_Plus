import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static const primary = LinearGradient(
    colors: [AppColors.primary, AppColors.primaryLight],
  );

  static const card = LinearGradient(
    colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
  );

  static const chartBar = LinearGradient(
    colors: [AppColors.primary, AppColors.chartGradientTop],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );
}
