import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/amazon_service.dart';
import '../services/flipkart_service.dart';
import '../models/product.dart';

final amazonServiceProvider = Provider((ref) => amazonService);
final flipkartServiceProvider = Provider((ref) => flipkartService);

final searchQueryProvider = StateProvider<String>((ref) => '');

final productsProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>((ref) {
      final query = ref.watch(searchQueryProvider);
      return ProductsNotifier(query);
    });

class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final String query;
  ProductsNotifier(this.query) : super(const AsyncValue.loading()) {
    _searchProducts();
  }

  Future<void> _searchProducts() async {
    state = const AsyncValue.loading();
    try {
      final amazonResults = await amazonService.searchProducts(query);
      state = AsyncValue.data(amazonResults);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> retry() => _searchProducts();
}

final productDetailProvider = FutureProvider.family<Product?, String>((
  ref,
  productId,
) async {
  try {
    return await amazonService.getProduct(productId);
  } catch (e) {
    return null;
  }
});

final priceComparisonProvider = FutureProvider.family<Product, String>((
  ref,
  productId,
) async {
  final amazonFuture = amazonService.getCurrentPrice(productId);
  final flipkartFuture = flipkartService.getCurrentPrice(productId);

  final results = await Future.wait([amazonFuture, flipkartFuture]);
  final amazonPrice = results[0] as double;
  final flipkartPrice = results[1] as double;

  final product = await amazonService.getProduct(productId);
  if (product == null) throw Exception('Product not found');

  return Product(
    id: product.id,
    name: product.name,
    description: product.description,
    imageUrl: product.imageUrl,
    amazonPrice: amazonPrice,
    flipkartPrice: flipkartPrice,
    rating: product.rating,
    reviews: product.reviews,
    updatedAt: DateTime.now(),
  );
});
