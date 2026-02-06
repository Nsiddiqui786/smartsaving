class PriceAlert {
  final String id;
  final String userId;
  final String productId;
  final double targetPrice;
  final DateTime createdAt;
  final bool isActive;
  final DateTime? triggeredAt;

  PriceAlert({
    required this.id,
    required this.userId,
    required this.productId,
    required this.targetPrice,
    required this.createdAt,
    required this.isActive,
    this.triggeredAt,
  });

  factory PriceAlert.fromJson(Map<String, dynamic> json) {
    return PriceAlert(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      targetPrice: (json['targetPrice'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool,
      triggeredAt: json['triggeredAt'] != null
          ? DateTime.parse(json['triggeredAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'targetPrice': targetPrice,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
      'triggeredAt': triggeredAt?.toIso8601String(),
    };
  }
}
