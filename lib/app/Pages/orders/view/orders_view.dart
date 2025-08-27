import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/Pages/orders/controller/orders_controller.dart';
import 'package:partbet/app/Pages/orders/view/tabs/active_orders.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/auth_background.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({Key? key}) : super(key: key);

  final controller = Get.put(OrdersController());

  final List<String> tabs = ['Active', 'Completed', 'Canceled'];

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: GeneralAppBar(
          title: 'Orders',
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
                      onPressed: () => Get.toNamed<void>('/notifications'),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 8,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1,
                        color:
                            Colors.transparent, // Important for gradient border
                      ),

                      // Gradient border using BoxDecoration's gradient
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.04),
                        ],
                        begin: Alignment(
                            -0.97, 0.25), // Adjust to match your 99.59deg angle
                        end: Alignment(0.97, -0.25),
                      ),

                      // Blur effect
                      backgroundBlendMode: BlendMode.overlay,
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Obx(() => Row(
                            children: List.generate(tabs.length, (index) {
                              final isSelected =
                                  index == controller.selectedTabIndex.value;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => controller.changeTab(index),
                                  child: Container(
                                    height: 42.sp,
                                    // padding: const EdgeInsets.symmetric(
                                    //     vertical: 12),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primary
                                          : Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      tabs[index],
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.white70,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    switch (controller.selectedTabIndex.value) {
                      case 0:
                        return const ActiveOrdersTab();
                      case 1:
                        return const ActiveOrdersTab();
                      case 2:
                        return const ActiveOrdersTab();
                      default:
                        return const SizedBox.shrink();
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      );
}
