import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../controller/parts_controller.dart';

class PartsDetailedView extends StatelessWidget {
  PartsDetailedView({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {
      'icon':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-1.png?alt=media&token=418f4baa-093d-43e8-9f12-159837ef97f5",
      'label': 'Engine',
    },
    {
      'icon':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-3.png?alt=media&token=418f4baa-093d-43e8-9f12-159837ef97f5",
      'label': 'Brake',
    },
    {
      'icon':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage.png?alt=media&token=418f4baa-093d-43e8-9f12-159837ef97f5",
      'label': 'Tires',
    },
    {
      'icon':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-2.png?alt=media&token=418f4baa-093d-43e8-9f12-159837ef97f5",
      'label': 'Suspension',
    },
  ];

  final List<Map<String, dynamic>> products = [
    {
      'image':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-3.png?alt=media&token=6dee4551-08b7-4ac4-83ce-df40caf5446b",
      'name': 'Tire',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-3.png?alt=media&token=6dee4551-08b7-4ac4-83ce-df40caf5446b",
      'name': 'Air Filter A281',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': true,
    },
    {
      'image':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-3.png?alt=media&token=6dee4551-08b7-4ac4-83ce-df40caf5446b",
      'name': 'Engine Part',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image':
          "https://firebasestorage.googleapis.com/v0/b/part-bet.firebasestorage.app/o/parts%2FImage-3.png?alt=media&token=6dee4551-08b7-4ac4-83ce-df40caf5446b",
      'name': 'Suspension',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final PartsController controller = Get.put(PartsController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Parts name',
        showBackButton: false,
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
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                AppTextField(
                  controller: searchController,
                  hintText: 'What are you looking for?',
                  backgroundColor: AppColors.transparent,
                  useDarkTextField: false,
                  borderColor: AppColors.textWhite100,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12.sp,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.4),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        Text(
                          'Explore parts by type',
                          style: TextStyle(
                            color: AppColors.textWhite60,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: AppColors.textWhite100,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0097A7),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              cat['icon'] as String,
                              width: 32,
                              height: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cat['label'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Featured Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final prod = products[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/product-detail', arguments: prod);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.transparent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Image.network(
                                      prod['image'] as String,
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                if (prod['low'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'LOW',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                if (prod['low'] == true)
                                  const SizedBox(height: 4),
                                Text(
                                  prod['name'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  prod['desc'] as String,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      prod['price'] as String,
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SvgPicture.asset(
                                          AppAssets.cart,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
