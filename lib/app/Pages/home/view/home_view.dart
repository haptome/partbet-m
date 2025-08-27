import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../../notifications/view/notifications_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> inquiries = [
    {
      'id': '1024',
      'title': 'Inquiry #1024',
      'desc': 'Brake Pads • Toyota Corolla 2015',
      'status': 'Pending',
      'price': '2500 Birr',
    },
    {
      'id': '1024',
      'title': 'Inquiry',
      'desc': 'Alternator • Nissan Sunny 2018',
      'status': 'Available',
      'price': '2500 Birr',
    },
    {
      'id': '1024',
      'title': 'Inquiry #1024',
      'desc': 'Brake Pads • Toyota Corolla 2015',
      'status': 'Pending',
      'price': '2500 Birr',
    },
    {
      'id': '1024',
      'title': 'Inquiry #1024',
      'desc': 'Brake Pads • Toyota Corolla 2015',
      'status': 'Unavailable',
      'price': '2500 Birr',
    },
  ];

  final List<Map<String, String>> featured = [
    {
      'image': 'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png',
      'name': 'Tire',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
    },
    {
      'image': 'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image-2_lsk046.png',
      'name': 'Air Filter A281',
      'desc': 'Fits Toyota Corolla',
      'price': '2500 Birr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Home',
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
                    onPressed: () => Get.to<NotificationsView>(() => NotificationsView()),
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
                    onPressed: () => Get.toNamed<void>('/cart'),
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          '4',
                          style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
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
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            children: [
              AppTextField(
                controller: searchController,
                hintText: 'Search by Part Name, SKU, or Brand',
                backgroundColor: AppColors.transparent,
                useDarkTextField: false,
                borderColor: AppColors.textWhite100,
                textStyle: TextStyle(color: Colors.white, fontSize: 12.sp),
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12.sp),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.search, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 16),
              // My Inquiries
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('My Inquiries', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.INQUIRIES);
                    },
                    child: const Text('See All', style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: inquiries.length,
                  itemBuilder: (context, index) {
                    final q = inquiries[index];
                    return Container(
                      width: 180,
                      margin: EdgeInsets.only(right: index < inquiries.length - 1 ? 12 : 0),
                      child: _inquiryCard(q),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              // Featured Product
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Featured Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('See All', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: featured.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final prod = featured[index];
                  return _productCard(prod);
                },
              ),
              const SizedBox(height: 16),
              // Banner
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.08)),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://images.pexels.com/photos/4489732/pexels-photo-4489732.jpeg?auto=compress&cs=tinysrgb&w=800',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Time for an Oil Change?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                            Text('Find Trusted Mechanics Near You', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Recent Orders header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Recent Orders', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('See All', style: TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 12),
              _recentOrderCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    switch (status.toLowerCase()) {
      case 'available':
        bg = Colors.green;
        break;
      case 'unavailable':
        bg = Colors.redAccent;
        break;
      case 'pending':
        bg = const Color(0xFFCE6E00);
        break;
      default:
        bg = const Color(0xFFCE6E00);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }

  Widget _inquiryCard(Map<String, dynamic> q) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF3E2A15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(q['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 6),
                _statusChip(q['status'] as String),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              q['desc'] as String,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(q['price'] as String, style: const TextStyle(color: Color(0xFFB86B1F), fontWeight: FontWeight.w700)),
                q['status'] == 'Available' ? Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(color: const Color(0xFFB86B1F), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
                ) : const SizedBox(),
              ],
            ),
          ],
        ),
      );

  Widget _productCard(Map<String, String> prod) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
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
                    prod['image']!,
                    fit: BoxFit.contain,
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 4),
              Text(
                prod['name']!,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                prod['desc']!,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    prod['price']!,
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _recentOrderCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://res.cloudinary.com/dglbocbnt/image/upload/v1754718546/Image_bbt2j7.png',
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID #ORD-90213', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(height: 2),
                  Text('Carbonator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 2),
                  Text('Brand', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                  child: const Text('Pay Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 4),
                const Text('January 12, 2025', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ],
        ),
      );
}
