import '../models/product.dart';

class ProductDetailService {
  final Map<String, double> sizeAddons = {"S": 0.0, "M": 0.5, "L": 1.0};

  double priceForSize(Product product, String size) {
    return product.price + (sizeAddons[size] ?? 0);
  }

  double totalPrice(Product product, Map<String, bool> selectedSizes) {
    double total = 0;
    selectedSizes.forEach((size, selected) {
      if (selected) total += priceForSize(product, size);
    });
    return total;
  }
}
