import 'dart:async';

import 'package:coffee_shop_app/home/widget/loading_widget.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../models/product.dart';
import '../presentation/screens/product_detail_screen.dart';

class CoffeeCarouselWidget extends StatefulWidget {
  final List<Product> products;

  const CoffeeCarouselWidget({super.key, required this.products});

  @override
  State<CoffeeCarouselWidget> createState() => _CoffeeCarouselWidgetState();
}

class _CoffeeCarouselWidgetState extends State<CoffeeCarouselWidget> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  late Timer _timer;

  List<Product> getCarouselItems() {
    final total = widget.products.length;
    if (total == 0) return [];

    final start = (total / 2).floor() - 4;
    final end = start + 3;
    return widget.products.sublist(
      start < 0 ? 0 : start,
      end > total ? total : end,
    );
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      final carouselItems = getCarouselItems();
      if (carouselItems.isEmpty) return;

      _currentPage++;
      if (_currentPage >= carouselItems.length) _currentPage = 0;

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carouselItems = getCarouselItems();

    if (carouselItems.isEmpty) {
      return const LoadingWidget(message: "Loading carousel...");
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: carouselItems.length,
            itemBuilder: (context, index) {
              final product = carouselItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[200]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Discover our finest coffee selection!",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
