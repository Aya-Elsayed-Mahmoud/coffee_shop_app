import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headLine = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.grey,
    height: 1.5,
  );

  static const TextStyle price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
  );
  static const TextStyle headLineSmall = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    color: AppColors.grey,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
