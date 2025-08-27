import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import 'package:partbet/app/shared/widgets/search_filter_bottom_sheet.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController searchController;
  String query = '';
  bool hasSearched = false;
  Map<String, dynamic> appliedFilters = {};

  final List<Map<String, dynamic>> allProducts = [
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Tire',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
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
      'outOfStock': true,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'name': 'Suspension',
      'desc': 'Fits Vitz Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png",
      'name': 'Brake Disc',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
    {
      'image': "https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png",
      'name': 'Alternator',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
      'low': false,
    },
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (query.isEmpty) return [];
    return allProducts.where((prod) =>
      prod['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
      prod['desc'].toString().toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    query = args is String ? args : (args?['query'] as String? ?? '');
    searchController = TextEditingController(text: query);
    if (query.isNotEmpty) hasSearched = true;
  }

  void _onSearch() {
    setState(() {
      query = searchController.text.trim();
      hasSearched = true;
    });
  }

  void _onClear() {
    setState(() {
      searchController.clear();
      query = '';
      hasSearched = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = filteredProducts;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Search',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppTextField(
                  controller: searchController,
                  hintText: 'Search part',
                  backgroundColor: Colors.transparent,
                  useDarkTextField: false,
                  borderColor: AppColors.primary,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 16,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: _onClear,
                          child: const Icon(Icons.close, color: Colors.white, size: 24),
                        ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _onSearch,
                        child: Icon(Icons.search, color: Colors.white.withOpacity(0.4), size: 24),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  onTap: () {},
                  readOnly: false,
                ),
              ),
              if (!hasSearched) ...[
                const SizedBox(height: 24),
                // Show nothing else, keyboard will be up
              ] else if (query.isNotEmpty && results.isEmpty) ...[
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('0 Results', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace with your own asset if you have
                        Icon(Icons.inbox, size: 100, color: Colors.blueAccent),
                        const SizedBox(height: 24),
                        const Text(
                          'Nothing Found!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try Searching a different thing',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ] else if (results.isNotEmpty) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${results.length} Results',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                      GestureDetector(
                        onTap: () {
                          showSearchFilterBottomSheet(
                            context: context,
                            initialFilters: appliedFilters,
                            onApply: (filters) {
                              setState(() {
                                appliedFilters = filters;
                                // TODO: filter results based on filters
                              });
                            },
                          );
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final prod = results[index];
                        return _buildProductCard(prod);
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    // Reuse the product card widget logic from parts_view/sub_category_view
    return GestureDetector(
      onTap: () {
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
              if (product['outOfStock'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Out Of Stock',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              if (product['low'] == true || product['outOfStock'] == true)
                const SizedBox(height: 4),
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
