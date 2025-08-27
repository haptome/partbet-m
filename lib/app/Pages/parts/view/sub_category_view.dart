import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import 'package:partbet/app/shared/widgets/filter_chip_widget.dart';
import 'package:partbet/app/shared/widgets/sub_category_filter_bottom_sheet.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import 'package:partbet/app/routes/app_routes.dart';

class SubCategoryView extends StatefulWidget {
  const SubCategoryView({super.key});

  @override
  State<SubCategoryView> createState() => _SubCategoryViewState();
}

class _SubCategoryViewState extends State<SubCategoryView> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = '';
  String selectedBrand = 'All';
  List<String> selectedSubCategories = [];
  
  // Sample data - in real app this would come from arguments or API
  final List<String> brands = ['All', 'Toyota Corolla', 'Vitz', 'Nissan'];
  final List<String> subCategories = [
    'Spark Plugs', 'Air Filter', 'Radiators', 'Alternators', 
    'Fuel Injectors', 'Turbo Charges', 'Cylinder Heads'
  ];
  
  final List<Map<String, dynamic>> products = [
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Tire',
      'desc': 'Fits Toyota Corolla',
      'price': '2500000 Birr',
      'low': false,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'name': 'Air Filter A281',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': true,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Engine Part',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'name': 'Suspension',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Get category from arguments
    final arguments = Get.arguments;
    if (arguments is Map<String, dynamic>) {
      selectedCategory = (arguments['category'] as String?) ?? 'Engine';
    } else if (arguments is String) {
      selectedCategory = arguments;
    } else {
      selectedCategory = 'Engine'; // Default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: selectedCategory,
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
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          "4",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
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
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const SizedBox(height: 16),
                // Search Bar
                AppTextField(
                  controller: searchController,
                  hintText: 'Search part',
                  backgroundColor: AppColors.transparent,
                  useDarkTextField: false,
                  borderColor: AppColors.textWhite100,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 12,
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
                const SizedBox(height: 20),
                
                // Brand Filter Chips
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: brands.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final brand = brands[index];
                      return FilterChipWidget(
                        label: brand,
                        isSelected: selectedBrand == brand,
                        onTap: () {
                          setState(() {
                            selectedBrand = brand;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                
                // Sub Categories Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sub Categories',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '341 Results',
                          style: TextStyle(
                            color: AppColors.textWhite60,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showSubCategoryFilterBottomSheet(
                          context: context,
                          allSubCategories: subCategories,
                          selectedSubCategories: selectedSubCategories,
                          onSelectionChanged: (selected) {
                            setState(() {
                              selectedSubCategories = selected;
                            });
                          },
                        );
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: AppColors.textWhite100,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Sub Category Filter Chips - Show only selected ones or first few
                SizedBox(
                  height: selectedSubCategories.isNotEmpty ? null : 80,
                  child: selectedSubCategories.isNotEmpty 
                      ? Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: selectedSubCategories.map((subCategory) {
                            return _buildSelectedChip(subCategory);
                          }).toList(),
                        )
                      : GridView.builder(
                          scrollDirection: Axis.horizontal,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.5,
                          ),
                          itemCount: subCategories.length > 6 ? 6 : subCategories.length, // Show max 6 initially
                          itemBuilder: (context, index) {
                            final subCategory = subCategories[index];
                            return FilterChipWidget(
                              label: subCategory,
                              isSelected: false,
                              selectedColor: const Color(0xFF2E8B8B), // Teal color from design
                              onTap: () {
                                setState(() {
                                  selectedSubCategories = [subCategory];
                                });
                              },
                            );
                          },
                        ),
                ),
                const SizedBox(height: 24),
                
                // Products Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$selectedCategory Parts',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '341 Results',
                          style: TextStyle(
                            color: AppColors.textWhite60,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Products Grid
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(), // Disable grid scrolling since parent scrolls
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final prod = products[index];
                      return _buildProductCard(prod);
                    },
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        // Navigate to product details
        Get.toNamed<void>('/parts-details', arguments: product);
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
                    product['image'] as String,
                    fit: BoxFit.contain,
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: Colors.white.withOpacity(0.5),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (product['low'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Low',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              if (product['low'] == true) const SizedBox(height: 4),
              Text(
                product['name'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                product['desc'] as String,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product['price'] as String,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
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
  }

  Widget _buildSelectedChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2E8B8B), // Teal color for selected
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedSubCategories.remove(label);
              });
            },
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 12,
                color: Color(0xFF2E8B8B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
