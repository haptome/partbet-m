import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/category_card.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    // Get categories from arguments passed from parts view
    final arguments = Get.arguments;
    if (arguments is List<Map<String, dynamic>>) {
      categories = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Category',
          showBackButton: true,
          trailing: Container(
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
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                  'Explore parts by type',
                      style: TextStyle(
                        color: Colors.white,
                    fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                const SizedBox(height: 24),
                Expanded(
                  child: categories.isEmpty
                      ? const Center(
                          child: Text(
                            'No categories available',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 26,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: categories.length * 4 , // Show 3 rows as in the image
                          itemBuilder: (context, index) {
                            final categoryIndex = index % categories.length;
                            final category = categories[categoryIndex];
                            
                            return CategoryCard(
                              icon: category['icon'] as String,
                              label: category['label'] as String,
                              isGridView: true,
                              onTap: () => _onCategoryTap(category['label'] as String),
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

  void _onCategoryTap(String categoryName) {
    // Navigate to sub-category page with the selected category
    Get.toNamed<void>(AppRoutes.SUB_CATEGORY, arguments: {'category': categoryName});
  }
}
