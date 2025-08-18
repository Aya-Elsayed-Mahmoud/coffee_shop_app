import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../home/models/product.dart';
import '../service/product_detail_service.dart';

class SizeSelector extends StatelessWidget {
  final Product product;
  final Map<String, bool> selectedSizes;
  final Function(String, bool) onChanged;
  final ProductDetailService service;

  const SizeSelector({
    super.key,
    required this.product,
    required this.selectedSizes,
    required this.onChanged,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: AppTextStyles.headLine.copyWith(
            fontSize: 18,
            color: AppColors.gold,
          ),
        ),
        ...service.sizeAddons.keys.map((size) {
          final price = service.priceForSize(product, size);
          return CheckboxListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            value: selectedSizes[size],
            onChanged: (v) => onChanged(size, v ?? false),
            activeColor: AppColors.gold,
            title: Row(
              children: [
                Text(
                  size,
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                ),
                const Spacer(),
                Text(
                  "\$${price.toStringAsFixed(2)}",
                  style: AppTextStyles.body.copyWith(color: AppColors.white),
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 12),
        const Divider(color: AppColors.grey),
        const SizedBox(height: 8),
      ],
    );
  }
}
