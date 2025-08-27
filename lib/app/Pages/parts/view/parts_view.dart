import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/routes/app_routes.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/category_card.dart';
import '../controller/parts_controller.dart';

class PartsView extends StatelessWidget {
  PartsView({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {
      'icon':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'label': 'Engine',
    },
    {
      'icon':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'label': 'Brake',
    },
    {
      'icon':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'label': 'Tires',
    },
    {
      'icon':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'label': 'Suspension',
    },
  ];

  final List<Map<String, dynamic>> products = [
    {
      'image':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Tire',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Air Filter A281',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': true,
    },
    {
      'image':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Engine Part',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image':
          "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'name': 'Suspension',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    Get.put(PartsController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Parts',
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
                    onPressed: () => Get.toNamed<void>(AppRoutes.NOTIFICATIONS),
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
                    onPressed: () => Get.toNamed<void>(AppRoutes.CART),
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
                  onTap: () {
                    Get.toNamed<void>(AppRoutes.SEARCH, arguments: searchController.text);
                  },
                  readOnly: true,
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
                    InkWell(
                      onTap: () => Get.toNamed<void>(AppRoutes.CATEGORY,arguments: categories),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.textWhite100,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
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
                      return CategoryCard(
                        icon: cat['icon'] as String,
                        label: cat['label'] as String,
                        onTap: () {
                          // Navigate to sub-category page
                          Get.toNamed<void>(AppRoutes.SUB_CATEGORY, arguments: {'category': cat['label']});
                        },
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
                          Get.toNamed<void>(AppRoutes.PARTS_DETAILS, arguments: prod);
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
