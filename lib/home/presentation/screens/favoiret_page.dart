import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../models/product_provider.dart';
import '../../widget/product_grid.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<ProductProvider>().favorites;

    if (favorites.isEmpty) {
      return const Center(
        child: Text("No favorites yet ❤️", style: AppTextStyles.body),
      );
    }

    return ProductGrid(products: favorites);
  }
}
