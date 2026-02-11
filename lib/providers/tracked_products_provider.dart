import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/storage_service.dart';
import '../models/tracked_product.dart';
import '../models/product.dart';
import '../services/amazon_service.dart';
import '../services/flipkart_service.dart';

final trackedProductsProvider =
    NotifierProvider<
      TrackedProductsNotifier,
      AsyncValue<List<TrackedProduct>>
    >(() {
      return TrackedProductsNotifier();
    });

class TrackedProductsNotifier
    extends Notifier<AsyncValue<List<TrackedProduct>>> {
  final _trackingData = <String, List<PriceSnapshot>>{};

  @override
  AsyncValue<List<TrackedProduct>> build() {
    _loadTrackedProducts();
    return const AsyncValue.data([]);
  }

  Future<void> _loadTrackedProducts() async {
    try {
      final trackedIds = storageService.getTrackedProducts();
      final tracked = <TrackedProduct>[];

      for (final id in trackedIds) {
        final product = await amazonService.getProduct(id);
        if (product != null) {
          final priceHistory = _trackingData[id] ?? [];
          tracked.add(
            TrackedProduct(
              id: 'tracked_$id',
              userId: 'user_001',
              product: product,
              addedAt: DateTime.now(),
              priceHistory: priceHistory,
            ),
          );
        }
      }

      state = AsyncValue.data(tracked);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTrackedProduct(Product product) async {
    try {
      await storageService.addTrackedProduct(product.id);
      final currentState = state.maybeWhen(
        data: (items) => items,
        orElse: () => <TrackedProduct>[],
      );

      final newTracked = TrackedProduct(
        id: 'tracked_${product.id}',
        userId: 'user_001',
        product: product,
        addedAt: DateTime.now(),
        priceHistory: [
          PriceSnapshot(
            amazonPrice: product.amazonPrice,
            flipkartPrice: product.flipkartPrice,
            timestamp: DateTime.now(),
          ),
        ],
      );

      _trackingData[product.id] = newTracked.priceHistory;
      state = AsyncValue.data([...currentState, newTracked]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeTrackedProduct(String productId) async {
    try {
      await storageService.removeTrackedProduct(productId);
      final currentState = state.maybeWhen(
        data: (items) => items,
        orElse: () => <TrackedProduct>[],
      );

      _trackingData.remove(productId);
      state = AsyncValue.data(
        currentState.where((t) => t.product.id != productId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updatePriceHistory(String productId) async {
    try {
      final amazonPrice = await amazonService.getCurrentPrice(productId);
      final flipkartPrice = await flipkartService.getCurrentPrice(productId);

      final snapshot = PriceSnapshot(
        amazonPrice: amazonPrice,
        flipkartPrice: flipkartPrice,
        timestamp: DateTime.now(),
      );

      _trackingData[productId] = [
        ...(_trackingData[productId] ?? []),
        snapshot,
      ];

      final currentState = state.maybeWhen(
        data: (items) => items,
        orElse: () => <TrackedProduct>[],
      );

      final updatedState = currentState.map((t) {
        if (t.product.id == productId) {
          return TrackedProduct(
            id: t.id,
            userId: t.userId,
            product: Product(
              id: t.product.id,
              name: t.product.name,
              description: t.product.description,
              imageUrl: t.product.imageUrl,
              amazonPrice: amazonPrice,
              flipkartPrice: flipkartPrice,
              rating: t.product.rating,
              reviews: t.product.reviews,
              updatedAt: DateTime.now(),
            ),
            addedAt: t.addedAt,
            targetPrice: t.targetPrice,
            priceHistory: _trackingData[productId] ?? [],
          );
        }
        return t;
      }).toList();

      state = AsyncValue.data(updatedState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> setTargetPrice(String productId, double targetPrice) async {
    try {
      final currentState = state.maybeWhen(
        data: (items) => items,
        orElse: () => <TrackedProduct>[],
      );

      final updatedState = currentState.map((t) {
        if (t.product.id == productId) {
          return TrackedProduct(
            id: t.id,
            userId: t.userId,
            product: t.product,
            addedAt: t.addedAt,
            targetPrice: targetPrice,
            priceHistory: t.priceHistory,
          );
        }
        return t;
      }).toList();

      state = AsyncValue.data(updatedState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  bool isProductTracked(String productId) {
    return state.maybeWhen(
      data: (items) => items.any((t) => t.product.id == productId),
      orElse: () => false,
    );
  }
}

final isProductTrackedProvider = Provider.family<bool, String>((
  ref,
  productId,
) {
  final tracked = ref.watch(trackedProductsProvider);
  return tracked.maybeWhen(
    data: (items) => items.any((t) => t.product.id == productId),
    orElse: () => false,
  );
});
