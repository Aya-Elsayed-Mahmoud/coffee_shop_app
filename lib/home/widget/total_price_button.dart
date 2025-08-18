import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/widgets/primary_button.dart';
import '../../home/models/product.dart';
import '../../home/models/product_provider.dart';

import '../../../core/theme/app_colors.dart';
import '../service/product_detail_service.dart';

class TotalPriceButton extends StatelessWidget {
  final Product product;
  final Map<String, bool> selectedSizes;
  final ProductDetailService service;

  const TotalPriceButton({
    super.key,
    required this.product,
    required this.selectedSizes,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final total = service.totalPrice(product, selectedSizes);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: PrimaryButton(
        text: "Add to Cart - \$${total.toStringAsFixed(2)}",
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
        onPressed: () {
          if (!selectedSizes.containsValue(true)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please select at least one size.")),
            );
            return;
          }

          final provider = context.read<ProductProvider>();
          selectedSizes.forEach((size, selected) {
            if (selected) {
              final item = Product(
                id: product.id,
                title: "${product.title} • $size",
                description: product.description,
                image: product.image,
                ingredients: product.ingredients,
                price: service.priceForSize(product, size),
              );
              provider.addToCart(item);
            }
          });
        },
      ),
    );
  }
}
