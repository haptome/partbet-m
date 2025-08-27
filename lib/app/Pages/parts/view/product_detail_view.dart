import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required Map<String, dynamic> product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product = (Get.arguments as Map<String, dynamic>? ?? {});
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Parts',
        showBackButton: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.notification,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppAssets.cart,
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 17,
                      height: 17,
                      child: Center(
                        child: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: AuthBackground(
        padding: 14,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: product['image'] != null
                        ? Image.network(product['image'] as String, fit: BoxFit.contain)
                        : const SizedBox(),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: SizedBox(
                    height: 60,
                    child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < 3; i++)
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        ),
                        child: product['image'] != null
                          ? Image.network(product['image'] as String, fit: BoxFit.contain)
                          : const SizedBox(),
                      ),
                      GestureDetector(
                        onTap: () {
                          final List<String> imgs = List<String>.generate(
                            6,
                            (_) => (product['image'] ?? '').toString(),
                          );
                          Get.toNamed<void>(
                            '/product-images',
                            arguments: {'images': imgs},
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: product['image'] != null
                          ? Image.network(product['image'] as String, fit: BoxFit.contain)
                          : const SizedBox(),
                            ),
                            Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9900).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                          '+5',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          ),
                        ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (product['price'] ?? 'ETB 2,450').toString(),
                      style: TextStyle(
                        color: const Color(0xFFFF9900).withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9900),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                      label: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  (product['name'] as String? ?? 'Air Filter A281'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  (product['brand'] as String? ?? 'Bosch'),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: 90,
                  child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _infoCard(
                    label: 'Availability',
                    value: 'In Stock',
                    valueColor: Colors.green,
                    bold: false,
                    ),
                    const SizedBox(width: 16),
                    _infoCard(
                    label: 'Condition',
                    value: 'New',
                    valueColor: Colors.green,
                    bold: false,
                    ),
                    const SizedBox(width: 16),
                    _infoCard(
                    label: 'Part Number',
                    value: 'BAF-A281-COR',
                    valueColor: Colors.white,
                    bold: true,
                    ),
                  ],
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Description',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  (product['desc'] as String?) ?? 'Lorem ipsum dolor sit amet consectetur. Sociis tristique est maecenas tortor. Id sit non quis enim. Nunc massa aenean lorem amet sit tristique nisl. Non id ac vestibulum tellus.',
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const SizedBox(height: 18),
                // Dimension & Weight
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Dimension', style: TextStyle(color: Colors.white70, fontSize: 15)),
                        SizedBox(height: 4),
                        Text('-', style: TextStyle(color: Colors.white, fontSize: 15)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Weight', style: TextStyle(color: Colors.white70, fontSize: 15)),
                        SizedBox(height: 4),
                        Text('0.5 KG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Compatibility
                const Text('Compatibility', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: _compatChip('Toyota Yaris', '20014 - 2018'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: _compatChip('Toyota Corolla', '20014 - 2018'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                // Shipping Info
                const Text('Shipping Info', style: TextStyle(color: Colors.white70, fontSize: 15)),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.local_shipping_outlined, color: Colors.white, size: 28),
                    SizedBox(width: 8),
                    Text('2 - 3 Days', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required String label, required String value, required Color valueColor, bool bold = false}) {
    return Container(
      // width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          if (!bold)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: valueColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
            )
          else
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _compatChip(String car, String year) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(car, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          Text(year, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}
