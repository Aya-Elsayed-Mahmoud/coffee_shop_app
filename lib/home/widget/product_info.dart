import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../home/models/product.dart';

class ProductInfo extends StatelessWidget {
  final Product product;

  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: AppTextStyles.headLine.copyWith(
            fontSize: 22,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${product.price.toStringAsFixed(2)}",
          style: AppTextStyles.headLine.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 12),
        const Divider(color: AppColors.grey),
        const SizedBox(height: 8),
        Text(
          "Description",
          style: AppTextStyles.headLine.copyWith(
            fontSize: 18,
            color: AppColors.gold,
          ),
        ),
        Text(
          product.description,
          style: AppTextStyles.body.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
