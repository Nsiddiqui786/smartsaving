import 'dart:math';
import '../models/product.dart';

class FlipkartService {
  static const List<Map<String, dynamic>> mockProducts = [
    {
      'id': 'prod_001',
      'name': 'Apple iPhone 15 Pro',
      'category': 'Smartphones',
      'basePrice': 79999,
      'discount': 0.08,
    },
    {
      'id': 'prod_002',
      'name': 'Samsung Galaxy S24',
      'category': 'Smartphones',
      'basePrice': 74999,
      'discount': 0.10,
    },
    {
      'id': 'prod_003',
      'name': 'Sony WH-1000XM5 Headphones',
      'category': 'Audio',
      'basePrice': 22999,
      'discount': 0.18,
    },
    {
      'id': 'prod_004',
      'name': 'Dell XPS 13 Laptop',
      'category': 'Computers',
      'basePrice': 99999,
      'discount': 0.12,
    },
    {
      'id': 'prod_005',
      'name': 'iPad Air 2024',
      'category': 'Tablets',
      'basePrice': 59999,
      'discount': 0.09,
    },
    {
      'id': 'prod_006',
      'name': 'Apple Watch Series 9',
      'category': 'Wearables',
      'basePrice': 34999,
      'discount': 0.08,
    },
    {
      'id': 'prod_007',
      'name': 'Canon EOS R6 Camera',
      'category': 'Cameras',
      'basePrice': 189999,
      'discount': 0.07,
    },
    {
      'id': 'prod_008',
      'name': 'LG 55" 4K Smart TV',
      'category': 'TVs',
      'basePrice': 49999,
      'discount': 0.15,
    },
  ];

  Future<List<Product>> searchProducts(String query) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final results = <Product>[];
    final lowerQuery = query.toLowerCase();

    for (final product in mockProducts) {
      final name = product['name'].toString().toLowerCase();
      if (name.contains(lowerQuery) || query.isEmpty) {
        results.add(_createProduct(product));
      }
    }

    return results;
  }

  Future<Product?> getProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 450));

    try {
      final product = mockProducts.firstWhere((p) => p['id'] == productId);
      return _createProduct(product);
    } catch (e) {
      return null;
    }
  }

  Future<double> getCurrentPrice(String productId) async {
    await Future.delayed(const Duration(milliseconds: 350));

    try {
      final product = mockProducts.firstWhere((p) => p['id'] == productId);
      final basePrice = product['basePrice'] as int;
      final discount = product['discount'] as double;
      final variation = Random().nextDouble() * 0.05;
      return (basePrice *
              (1 -
                  discount -
                  variation +
                  Random().nextDouble() * variation * 2))
          .toDouble();
    } catch (e) {
      return 0.0;
    }
  }

  Product _createProduct(Map<String, dynamic> data) {
    final basePrice = data['basePrice'] as int;
    final discount = data['discount'] as double;
    final actualPrice = (basePrice * (1 - discount)).toDouble();

    return Product(
      id: data['id'] as String,
      name: data['name'] as String,
      description:
          'Exclusive ${data['category']} with great deals and fast delivery',
      imageUrl:
          'https://via.placeholder.com/300x300?text=${Uri.encodeComponent(data["name"])}',
      amazonPrice: actualPrice + Random().nextDouble() * 3000,
      flipkartPrice: actualPrice + Random().nextDouble() * 5000,
      rating: 3.8 + Random().nextDouble() * 1.2,
      reviews: Random().nextInt(4000) + 200,
      updatedAt: DateTime.now(),
    );
  }
}

final flipkartService = FlipkartService();
