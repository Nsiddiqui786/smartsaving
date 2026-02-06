import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LoadingSkeleton extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;

  const LoadingSkeleton({
    super.key,
    required this.height,
    this.width,
    this.borderRadius = AppDimensions.borderRadiusM,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const _ShimmerEffect(),
    );
  }
}

class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect();

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ],
              colors: [Colors.grey[300]!, Colors.grey[200]!, Colors.grey[300]!],
            ),
          ),
        );
      },
    );
  }
}

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(AppDimensions.paddingM),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoadingSkeleton(
                  height: 200,
                  width: double.infinity,
                  borderRadius: AppDimensions.borderRadiusM,
                ),
                const SizedBox(height: AppDimensions.paddingM),
                LoadingSkeleton(height: 16, width: double.infinity),
                const SizedBox(height: AppDimensions.paddingS),
                LoadingSkeleton(height: 16, width: 200),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LoadingSkeleton(height: 20, width: 100),
                    LoadingSkeleton(height: 20, width: 80),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
