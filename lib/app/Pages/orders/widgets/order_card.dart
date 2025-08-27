import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/Pages/orders/controller/orders_controller.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';

import '../../../routes/app_routes.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    Color buttonColor;
    String buttonText = order.buttonText;
    String buttonIconAsset = AppAssets.pay;
    Color statusBg = Colors.white.withOpacity(0.1);
    Color statusTextColor = Colors.white;

    switch (order.status) {
      case 'Pending':
        statusColor = const Color(0xFFEE851A);
        buttonColor = const Color(0xFF007C91);
        buttonIconAsset = AppAssets.pay;
        break;
      case 'Processing':
        statusColor = const Color(0xFFFF9900);
        buttonColor = const Color(0xFF0097A7);
        buttonIconAsset = AppAssets.location;
        break;
      case 'Completed':
        statusColor = const Color(0xFF21C362);
        buttonColor = const Color(0xFF444444);
        buttonIconAsset = AppAssets.invoice;
        buttonText = 'View Order';
        break;
      case 'Delivered':
        statusColor = const Color(0xFF21C362);
        buttonColor = const Color(0xFF444444);
        buttonIconAsset = AppAssets.invoice;
        buttonText = 'View Order';
        break;
      case 'Canceled':
        statusColor = const Color(0xFFFF3B30);
        buttonColor = const Color(0xFF444444);
        buttonIconAsset = AppAssets.badge;
        statusTextColor = Colors.white;
        break;
      default:
        statusColor = const Color(0xFF444444);
        buttonColor = const Color(0xFF444444);
        buttonIconAsset = AppAssets.invoice;
        break;
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.ORDER_DETAILS, arguments: order);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Order ID ${order.orderId}",
                    style: const TextStyle(color: AppColors.grey50,fontWeight: FontWeight.w100),
                  ),
                ),
                Text(
                  order.date,
                  style: const TextStyle(color: AppColors.grey50,fontWeight: FontWeight.w100),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    "assets/images/parts.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        order.brand,
                        style: const TextStyle(color: AppColors.grey50,fontWeight: FontWeight.w100),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        order.status == 'Delivered' ? 'Delivered' : order.status == 'Completed' ? 'Completed' : order.status == 'Canceled' ? 'Canceled' : order.status,
                        style: TextStyle(
                          color: statusTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                   
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffFFA733),
                    )),
                     if (order.status != 'Canceled')
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        icon: SvgPicture.asset(
                          buttonIconAsset,
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          // color: Colors.white,
                        ),
                        label: Text(buttonText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
