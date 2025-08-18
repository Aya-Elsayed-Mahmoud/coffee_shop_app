import 'dart:convert';

import 'package:coffee_shop_app/home/presentation/screens/favoiret_page.dart';
import 'package:coffee_shop_app/home/widget/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../features/auth/data/firebase_auth_service.dart';
import '../../models/product.dart';
import '../../widget/carousel_home.dart';
import '../../widget/loading_widget.dart';
import '../../widget/product_grid.dart';
import '../../widget/welcome_text.dart';
import 'cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late Future<List<Product>> productsFuture;
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  final AuthService authService = AuthService();

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(
      Uri.parse("https://api.sampleapis.com/coffee/hot"),
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  @override
  void initState() {
    super.initState();
    productsFuture = fetchProducts();
    productsFuture.then((products) {
      setState(() {
        allProducts = products;
        filteredProducts = List.from(allProducts);
      });
    });
  }

  void filterSearch(String query) {
    final lowerQuery = query.toLowerCase();
    final results = allProducts.where((p) {
      final title = p.title.toLowerCase();
      return title.startsWith(lowerQuery) || title.contains(lowerQuery);
    });
    setState(() {
      filteredProducts = results.toList();
    });
  }

  Widget homePageContent() {
    final user = FirebaseAuth.instance.currentUser;
    final username = authService.getUsername(user);

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Search coffee",
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.gold,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.gold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.4),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
              ),
              cursorColor: AppColors.gold,
              onChanged: filterSearch,
            ),
          ),
          WelcomeText(username: username),
          CoffeeCarouselWidget(products: allProducts),
          const SizedBox(height: 12),
          Expanded(child: ProductGrid(products: filteredProducts)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(message: "Loading coffees...");
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}",
                    style: AppTextStyles.body.copyWith(
                        color: AppColors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text("No products available",
                    style: AppTextStyles.body.copyWith(
                        color: AppColors.white)));
          } else {
            return homePageContent();
          }
        },
      ),
      const FavoritesPage(),
      const CartPage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
