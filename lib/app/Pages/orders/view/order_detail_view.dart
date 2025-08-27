import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/Pages/orders/widgets/track_order_sheet.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/shared/widgets/auth_background.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partbet/app/Pages/orders/controller/orders_controller.dart';
import 'package:partbet/app/Pages/orders/widgets/track_order_sheet.dart';
import 'package:partbet/app/shared/widgets/auth_background.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';

import '../../../core/config/app_color.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderModel order;
  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  void _showTrackingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D2A28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (_) => const TrackOrderSheet(),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Pending':
        return const Color(0xFFEE851A);
      case 'Processing':
        return const Color(0xFFFF9900);
      case 'Completed':
      case 'Delivered':
        return const Color(0xFF21C362);
      case 'Canceled':
        return const Color(0xFFFF3B30);
      default:
        return Colors.grey;
    }
  }

  String _chipText(String status) {
    switch (status) {
      case 'Pending':
        return 'Pending';
      case 'Processing':
        return 'Processing';
      case 'Completed':
        return 'Completed';
      case 'Delivered':
        return 'Delivered';
      case 'Canceled':
        return 'Canceled';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCanceled = order.status == 'Canceled';
    final isActive = order.status == 'Pending' || order.status == 'Processing';
    final isPaid = order.status == 'Paid' || order.status == 'Completed' || order.status == 'Delivered' ||order.status == 'Processing';
    final isDelivery = order.status == 'Delivered';
    final items = [
      {'title': 'Carbonator', 'brand': 'Brand', 'image': 'assets/images/parts.png'},
      if (isDelivery) ...[
        {'title': 'Air Filter A281', 'brand': 'Bosch', 'image': 'assets/images/parts.png'},
        {'title': 'Air Filter A281', 'brand': 'Bosch', 'image': 'assets/images/parts.png'},
      ]
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const GeneralAppBar(title: 'Order Detail', showBackButton: true),
      body: AuthBackground(
        padding: 13,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16),
              // Order Summary
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order ID ${order.orderId}",
                                  style: const TextStyle(color: Colors.white70,
                                      fontSize: 12, fontWeight: FontWeight.w400)),
                             
                              
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                            Text(order.date,
                              style: const TextStyle(color: Colors.white70,
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                            
                           
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.price,
                                      style: const TextStyle(
                                          color: Color(0xFFFF9900),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isCanceled
                              ? const Color(0xFFFF3B30)
                              : isPaid
                                ? const Color(0xFF21C362)
                                : order.status == 'Pending'
                                  ? const Color(0xFFEE851A)
                                  : order.status == 'Processing'
                                    ? const Color(0xFFFF9900)
                                    : const Color(0xFF00C2FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.status == 'Canceled'
                              ? 'Canceled'
                              : isPaid
                                ? 'Paid'
                                : order.status,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              ),

              const SizedBox(height: 16),

              // Shipping Method Section (pixel-perfect)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Shipping Method", style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 10)),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF00AFC1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          child: const Text(
                            'Delivery',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white12,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                         Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF442B0F),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA726),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.location_on,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                            SizedBox(height: 2),
                            Text("Addis Abeba, Ethiopia", style: TextStyle(color: Colors.white70, fontSize: 12,fontWeight: FontWeight.w400,)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white12,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery Time", style: TextStyle(color: Colors.white70, fontSize: 10,fontWeight: FontWeight.w400)),
                        Row(
                          children:  [
                        

                            SvgPicture.asset(
                              AppAssets.delivery,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                            SizedBox(width: 8),
                            Text("2 - 3 Days", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Payment Info Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Payment Information", style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 10)),
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              ),
                              child: Image.asset(
                              AppAssets.chapa,
                              fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text("Chappa", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white12, height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Sub Total", style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 10)),
                        Text("1,000 BIRR", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Divider(color: Colors.white12, height: 24),
                    const SizedBox(height: 4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Total", style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, fontSize: 14)),
                        Text("1,200 BIRR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Items List Section
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Items Purchased", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10)),
                          Text("${items.length} Item${items.length > 1 ? 's' : ''}", style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 10)),
                        ],
                      ),
                      const Divider(color: Colors.white12, height: 24),
                      for (var i = 0; i < items.length; i++) ...[
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Image.asset(items[i]['image']!, fit: BoxFit.cover),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(items[i]['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                                Text(items[i]['brand']!, style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w400, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        if (i != items.length - 1) const Divider(color: Colors.white12, height: 24),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              
              if(order.status=='pending' || order.status=='Processing')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                          height: 54,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            onPressed: () => _showTrackingSheet(context),
                            icon: SvgPicture.asset(
                                AppAssets.cart,
                                width: 24,
                      height: 24,
                      color: Colors.white,
                                colorFilter: ColorFilter.mode(
                                    AppColors.textWhite100,
                                    BlendMode.srcIn),
                              ),
                            label: Text(
                              'Track Order',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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

  Widget _buildItem(String title, String brand) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12,
          ),
          child: Image.asset("assets/images/part.png", fit: BoxFit.cover),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(brand, style: const TextStyle(color: Colors.white70)),
          ],
        )
      ],
    );
  }
}
