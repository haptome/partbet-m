import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:partbet/app/Pages/main/controllers/nav_controller.dart';
import 'package:partbet/app/Pages/orders/view/orders_view.dart';
import 'package:partbet/app/Pages/parts/view/parts_view.dart';
import 'package:partbet/app/Pages/profile/view/profile_view.dart';

import 'package:partbet/app/shared/widgets/app_bottom_nav.dart';
import 'package:get/get.dart';

import '../../services/view/service_view.dart';
import '../../home/view/home_view.dart';

class MainView extends GetView<NavController> {
  MainView({
    super.key,
    int? initialIndex,
  }) {
    if (initialIndex != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final navController = Get.find<NavController>();
        navController.currentIndex.value = initialIndex;
      });
    }
  }

  late final List<Widget> pages = [
    HomeView(),
    PartsView(),
    ServicesView(),
    OrdersScreen(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController(), permanent: true);
    void handleTabChange(int index) {
      // Force dispose ConverterController when navigating away
      if (index != 2) {}
      if (index != 1) {}

      controller.currentIndex.value = index;
    }

    return Obx(
      () => AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: pages[controller.currentIndex.value],
          backgroundColor: const Color(0xFF18100B),
          bottomNavigationBar: AppBottomNav(
            selectedIndex: controller.currentIndex.value,
            onTap: handleTabChange,
          ),
        ),
      ),
    );
  }
}
