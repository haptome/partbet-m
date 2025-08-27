import 'package:flutter/material.dart';

import '../../core/config/app_color.dart';

class CategoryCard extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool isGridView;

  const CategoryCard({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
    this.width,
    this.height,
    this.isGridView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      // Grid view style for category page
      return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                icon,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Horizontal list style for parts page
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? 80,
          height: height ?? 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                icon,
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: 32,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
