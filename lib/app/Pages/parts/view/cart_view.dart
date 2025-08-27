import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../../main/views/main_view.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final List<Map<String, dynamic>> items = [
    {
      'image':
          'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png',
      'name': 'Carbonator',
      'brand': 'Brand',
      'qty': 2,
      'price': 400,
    },
    {
      'image':
          'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png',
      'name': 'Air Filter A281',
      'brand': 'Bosch',
      'qty': 1,
      'price': 600,
    },
  ];

  int get total =>
      items.fold(0, (sum, e) => sum + (e['price'] as int) * (e['qty'] as int));

  void _increment(int index) {
    setState(() => items[index]['qty'] = (items[index]['qty'] as int) + 1);
  }

  void _decrement(int index) {
    setState(() {
      final q = (items[index]['qty'] as int);
      items[index]['qty'] = q > 1 ? q - 1 : 1;
    });
  }

  void _remove(int index) {
    setState(() => items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const GeneralAppBar(
        title: 'Cart',
        showBackButton: true,
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: items.isEmpty
              ? _emptyState(context)
              : Stack(
                  children: [
                    ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => _cartTile(index),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16 + MediaQuery.of(context).padding.bottom,
                      child: SizedBox(
                        height: 54,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          onPressed: () => Get.toNamed<void>('/checkout'),
                          icon: SvgPicture.asset(
                            AppAssets.cart,
                            colorFilter: ColorFilter.mode(
                                AppColors.textWhite100, BlendMode.srcIn),
                          ),
                          label: Text(
                            'Checkout (${total} BIRR)',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _cartTile(int index) {
    final item = items[index];
    final int qty = item['qty'] as int;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 48,
            height: 48,
            color: Colors.white.withOpacity(0.08),
            child: Image.network(item['image'] as String, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['name'] as String,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                item['brand'] as String,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Row(
          children: [
            qty > 1
                ? _squareButton(
                    icon: Icon(Icons.remove),
                    onTap: () => _decrement(index),
                    color: Colors.white.withOpacity(0.1),
                  )
                : _squareButton(
                    icon: SvgPicture.asset(
                            AppAssets.cart,
                            colorFilter: ColorFilter.mode(
                                AppColors.textWhite100, BlendMode.srcIn),
                          ),
                    onTap: () => _remove(index),
                    color: const Color(0xFFE05252),
                  ),
            const SizedBox(width: 8),
            Text(
              qty.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            _squareButton(
                icon: Icon(Icons.add),
                onTap: () => _increment(index),
                color: AppColors.primary),
          ],
        )
      ],
    );
  }

  Widget _squareButton({required Widget icon, required VoidCallback onTap, required Color color}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: icon 
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                shape: BoxShape.circle,
              ),
              child:  Center(
                child: Image.asset(AppAssets.emptyCart),
                    
              ),
            ),
            const SizedBox(height: 24),
            const Text('Cart is Empty',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            const Text('Add something from Parts',
                style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 24),
            SizedBox(
              width: 260,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  // Navigate to Parts tab on main
                  Get.offAll<MainView>(() => MainView(initialIndex: 1));
                },
                icon: const Icon(Icons.search, color: Colors.white),
                label: const Text('Look for parts',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
