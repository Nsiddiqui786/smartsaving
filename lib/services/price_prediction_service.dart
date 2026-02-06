import 'dart:math';
import '../models/tracked_product.dart';

class PricePredictionService {
  // Simple linear trend-based prediction
  Future<Map<String, dynamic>> predictPrice(
    TrackedProduct trackedProduct,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final history = trackedProduct.priceHistory;
    if (history.length < 2) {
      return {
        'predictedPrice': trackedProduct.product.bestPrice,
        'confidence': 0.3,
        'trend': 'neutral',
        'message': 'Insufficient data for prediction',
      };
    }

    // Calculate average trend
    double avgTrend = 0.0;
    for (int i = 1; i < history.length; i++) {
      final prev = history[i - 1].bestPrice;
      final curr = history[i].bestPrice;
      avgTrend += (curr - prev) / prev;
    }
    avgTrend = avgTrend / (history.length - 1);

    // Predict next price
    final currentPrice = trackedProduct.product.bestPrice;
    final predictedPrice = currentPrice * (1 + avgTrend);
    final confidence = _calculateConfidence(history);

    String trend = 'neutral';
    String message = 'Price expected to remain stable';

    if (avgTrend > 0.02) {
      trend = 'increasing';
      message = 'Price is predicted to increase';
    } else if (avgTrend < -0.02) {
      trend = 'decreasing';
      message = 'Good time to buy - price predicted to decrease';
    }

    return {
      'predictedPrice': predictedPrice,
      'confidence': confidence,
      'trend': trend,
      'message': message,
      'daysPredicted': 7,
    };
  }

  double _calculateConfidence(List<PriceSnapshot> history) {
    if (history.length < 3) return 0.3;
    if (history.length < 7) return 0.6;
    if (history.length < 30) return 0.75;
    return 0.9;
  }

  // Get best time to buy recommendation
  Future<Map<String, dynamic>> getBestTimeRecommendation(
    TrackedProduct trackedProduct,
  ) async {
    final prediction = await predictPrice(trackedProduct);
    final currentPrice = trackedProduct.product.bestPrice;
    final predictedPrice = prediction['predictedPrice'] as double;
    final difference = predictedPrice - currentPrice;

    String recommendation = 'Hold';
    String reason = 'Current price is reasonable';

    if (difference > currentPrice * 0.05) {
      recommendation = 'Buy Now';
      reason = 'Price is likely to increase in the next 7 days';
    } else if (difference < -currentPrice * 0.05) {
      recommendation = 'Wait';
      reason = 'Price is likely to decrease in the next 7 days';
    }

    return {
      'recommendation': recommendation,
      'reason': reason,
      'currentPrice': currentPrice,
      'predictedPrice': predictedPrice,
      'savingsIfWait': max(0, difference),
    };
  }
}

final pricePredictionService = PricePredictionService();
