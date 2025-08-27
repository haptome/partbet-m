import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/Pages/splash/controllers/splash_controller.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/core/config/app_sizes.dart';
import 'package:get/get.dart';

import '../../../core/config/app_assets.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            FadeInImage(
              placeholder: AssetImage(AppAssets.splashBackground),
              image: AssetImage(AppAssets.splashBackground),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              fadeInDuration: const Duration(milliseconds: 1),
              color: Colors.black.withOpacity(0.7),
              colorBlendMode: BlendMode.darken,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.splashPadding),
              child: Obx(() {
                final showContent = controller.isLogoVisible.value;

                return Center(
                  child: ScaleTransition(
                    scale: controller.scaleAnimation,
                    child: Image.asset(
                      AppAssets.logo,
                      width: AppSizes.splashLogoWidth.w,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
}
