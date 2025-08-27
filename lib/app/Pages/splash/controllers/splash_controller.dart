import 'package:partbet/app/Pages/onboarding/views/onboarding_view.dart';
import 'package:partbet/app/core/services/secure_storage_service.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import '../../auth/view/auth_view.dart';
import '../../main/views/main_view.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController imageController;
  late final Animation<double> scaleAnimation;

  final isLogoVisible = false.obs;
  

  @override
  void onInit() {
    super.onInit();

    imageController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
      tween: Tween<double>(begin: 0.5, end: 1.1).chain(CurveTween(curve: Curves.easeOut)),
      weight: 50,
      ),
      TweenSequenceItem(
      tween: Tween<double>(begin: 1.1, end: 0.9).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 25,
      ),
      TweenSequenceItem(
      tween: Tween<double>(begin: 0.9, end: 1.0).chain(CurveTween(curve: Curves.easeOut)),
      weight: 25,
      ),
    ]).animate(
      CurvedAnimation(
      parent: imageController,
      curve: Curves.easeInOut,
      ),
    );

    // Delay before showing the logo
    Future.delayed(const Duration(seconds: 1), () {
      isLogoVisible.value = true;
      imageController.forward().whenComplete(() async {
        await Future<void>.delayed(const Duration(milliseconds: 1000));


        final isFirstLaunch =
            await Get.find<SecureStorageService>().isFirstLaunch();

        // Fetch user data from storage (example: username)
        final userFullName = await Get.find<SecureStorageService>().read('user_full_name');

        Get.offAll<void>(
          () {
            if (isFirstLaunch) return const OnboardingView();
            if (userFullName == null || userFullName.isEmpty) return AuthView();
            return MainView();
          },
          transition: Transition.fade,
          duration: const Duration(milliseconds: 600),
        );
      });
    });
  }

  @override
  void onClose() {
    imageController.dispose();
    super.onClose();
  }
}
