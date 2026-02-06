import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_provider.dart';
import '../providers/tracked_products_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/price_comparison_card.dart';
import '../widgets/loading_skeleton.dart';
import '../utils/currency_formatter.dart';
import '../utils/constants.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  bool _showTargetPriceForm = false;
  final _targetPriceController = TextEditingController();

  @override
  void dispose() {
    _targetPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(priceComparisonProvider(widget.productId));
    final isTracked = ref.watch(isProductTrackedProvider(widget.productId));

    return Scaffold(
      appBar: SmartSavingAppBar(
        title: AppStrings.priceComparison,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: productAsync.when(
        data: (product) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: Container(
                    height: 300,
                    color: Colors.grey[200],
                    width: double.infinity,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 60,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingL),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product info
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimensions.paddingS),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: AppDimensions.paddingS),
                          Text(
                            '${product.rating.toStringAsFixed(1)} (${product.reviews} reviews)',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingL),

                      // Price comparison
                      Text(
                        AppStrings.priceComparison,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingM),
                      PriceComparisonCard(product: product),
                      const SizedBox(height: AppDimensions.paddingL),

                      // Description
                      Text(
                        'About',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: AppDimensions.paddingS),
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: AppDimensions.paddingL),

                      // View price history button
                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: OutlinedButton(
                          onPressed: isTracked
                              ? () {
                                  Navigator.of(context).pushNamed(
                                    '/price-history',
                                    arguments: product.id,
                                  );
                                }
                              : null,
                          child: const Text(AppStrings.priceHistory),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingM),

                      // Track/Set alert button
                      if (!_showTargetPriceForm)
                        SizedBox(
                          width: double.infinity,
                          height: AppDimensions.buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (isTracked) {
                                setState(() => _showTargetPriceForm = true);
                              } else {
                                ref
                                    .read(trackedProductsProvider.notifier)
                                    .addTrackedProduct(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Product tracked!'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(AppColors.primary),
                            ),
                            child: Text(
                              isTracked
                                  ? AppStrings.addAlert
                                  : AppStrings.track,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: [
                            TextField(
                              controller: _targetPriceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: AppStrings.targetPrice,
                                prefixText: '₹ ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.paddingM),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      setState(
                                        () => _showTargetPriceForm = false,
                                      );
                                      _targetPriceController.clear();
                                    },
                                    child: const Text(AppStrings.cancel),
                                  ),
                                ),
                                const SizedBox(width: AppDimensions.paddingM),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_targetPriceController
                                          .text
                                          .isNotEmpty) {
                                        final targetPrice =
                                            double.tryParse(
                                              _targetPriceController.text,
                                            ) ??
                                            0;
                                        ref
                                            .read(
                                              trackedProductsProvider.notifier,
                                            )
                                            .setTargetPrice(
                                              product.id,
                                              targetPrice,
                                            );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Alert set for ₹${CurrencyFormatter.format(targetPrice)}',
                                            ),
                                          ),
                                        );
                                        setState(
                                          () => _showTargetPriceForm = false,
                                        );
                                        _targetPriceController.clear();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(
                                        AppColors.primary,
                                      ),
                                    ),
                                    child: const Text(
                                      AppStrings.save,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              children: [
                LoadingSkeleton(height: 300, width: double.infinity),
                const SizedBox(height: AppDimensions.paddingL),
                LoadingSkeleton(height: 24, width: double.infinity),
                const SizedBox(height: AppDimensions.paddingS),
                LoadingSkeleton(height: 16, width: 200),
              ],
            ),
          ),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: AppDimensions.paddingM),
              Text(AppStrings.error),
            ],
          ),
        ),
      ),
    );
  }
}
