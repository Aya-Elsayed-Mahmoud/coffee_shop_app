import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../models/product_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<ProductProvider>().cart;

    final totalPrice = cart.fold<double>(
      0,
      (sum, product) => sum + (product.price ?? 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.gold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: AppTextStyles.price,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          if (cart.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "Your cart is empty 🛒",
                  style: AppTextStyles.body.copyWith(color: AppColors.primary),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final product = cart[index];
                  return Card(
                    color: AppColors.primary.withOpacity(0.9),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                      title: Text(
                        product.title,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      subtitle: Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: AppTextStyles.price,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.remove_shopping_cart,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          context.read<ProductProvider>().removeFromCart(
                            product,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
