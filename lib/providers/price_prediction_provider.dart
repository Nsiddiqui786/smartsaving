import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/price_prediction_service.dart';
import '../models/tracked_product.dart';

final pricePredictionProvider =
    FutureProvider.family<Map<String, dynamic>, TrackedProduct>((
      ref,
      trackedProduct,
    ) async {
      return pricePredictionService.predictPrice(trackedProduct);
    });

final priceRecommendationProvider =
    FutureProvider.family<Map<String, dynamic>, TrackedProduct>((
      ref,
      trackedProduct,
    ) async {
      return pricePredictionService.getBestTimeRecommendation(trackedProduct);
    });
