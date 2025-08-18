import 'package:coffee_shop_app/home/models/product.dart';
import 'package:coffee_shop_app/home/service/product_detail_service.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../widget/product_image.dart';
import '../../widget/product_info.dart';
import '../../widget/size_selector.dart';
import '../../widget/total_price_button.dart';
import '../screens/cart_page.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final Map<String, bool> _selectedSizes = {"S": false, "M": true, "L": false};
  final ProductDetailService service = ProductDetailService();

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.height * 0.32;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black87),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(product: widget.product, height: imageHeight),
              const SizedBox(height: 12),
              ProductInfo(product: widget.product),
              Expanded(
                child: SingleChildScrollView(
                  child: SizeSelector(
                    product: widget.product,
                    selectedSizes: _selectedSizes,
                    service: service,
                    onChanged: (size, value) =>
                        setState(() => _selectedSizes[size] = value),
                  ),
                ),
              ),
              TotalPriceButton(
                product: widget.product,
                selectedSizes: _selectedSizes,
                service: service,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
