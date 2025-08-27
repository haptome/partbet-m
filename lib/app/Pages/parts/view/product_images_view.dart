import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImagesView extends StatefulWidget {
  const ProductImagesView({super.key});

  @override
  State<ProductImagesView> createState() => _ProductImagesViewState();
}

class _ProductImagesViewState extends State<ProductImagesView> {
  late List<String> images;
  int? selectedIndex; // null => grid, otherwise show single

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is List<String>) {
      images = args;
    } else if (args is Map<String, dynamic>) {
      final src = args['images'] as List<dynamic>?;
      images = src?.map((e) => e.toString()).toList() ?? [];
      if (images.isEmpty && args['image'] != null) images = [args['image'].toString()];
      selectedIndex = args['index'] as int?; // if passed, directly open single mode
    } else {
      images = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            color: Colors.white.withOpacity(0.08),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: selectedIndex == null
                  ? _buildGrid(context)
                  : _buildSingle(context, selectedIndex!),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topRightClose({required IconData icon, required VoidCallback onTap}) {
    return Positioned(
      top: 12,
      right: 12,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final items = images.isEmpty
        ? [
            'https://via.placeholder.com/400x300.png?text=No+Image',
            'https://via.placeholder.com/400x300.png?text=No+Image'
          ]
        : images;
    return Stack(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 60),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => setState(() => selectedIndex = index),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Image.network(
                      items[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        _topRightClose(icon: Icons.close, onTap: () => Get.back<void>()),
      ],
    );
  }

  Widget _buildSingle(BuildContext context, int index) {
    final image = images[index];
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRect(
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(40),
              minScale: 1.0,
              maxScale: 4.0,
              child: SizedBox.expand(
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        _topRightClose(icon: Icons.fullscreen_exit, onTap: () => setState(() => selectedIndex = null)),
      ],
    );
  }
}
