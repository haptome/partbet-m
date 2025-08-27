import 'package:flutter/material.dart';
import 'package:partbet/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/routes/app_routes.dart';

class OnboardingController extends GetxController
    with GetTickerProviderStateMixin {
  final currentPage = 0.obs;
  final fullNameController = TextEditingController();
  late final AnimationController fadeController;
  late final Animation<double> fadeAnimation;
  final List<OnboardingPage> pages = const [
    OnboardingPage(
      image: AppAssets.onboardingOne,
      title: 'find What Fits - Fast',
      subTitle:
          'Easily discover the right car parts for your exact model No guesswork, no stress.',
    ),
    OnboardingPage(
      image: AppAssets.onboardingTwo,
      title: 'Quality Parts, Always',
      subTitle:
          'We only stock verified parts from trusted suppliers - because your car deserves the best.',
    ),
    OnboardingPage(
      image: AppAssets.onboardingThree,
      title: 'Out of Stock? We\'ll Find It',
      subTitle:
          'Can\'t see the part you need? Just send a request and we\'ll source it for you.',
    ),
    OnboardingPage(
      image: AppAssets.onboardingFour,
      title: 'Delivered & Paid Your Way',
      subTitle:
          'Choose free pickup or flat-rate delivery. Pay securely and track everything.',
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    for (final page in pages) {
      precacheImage(AssetImage(page.image), Get.context!);
    }
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    fadeAnimation = CurvedAnimation(
      parent: fadeController,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      fadeController.forward(); // Delayed fade-in of UI
    });
  }

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      final nextImage = AssetImage(pages[currentPage.value + 1].image);
      precacheImage(nextImage, Get.context!);

      currentPage.value++;
    } else {
      Get.offAllNamed<void>(AppRoutes.AUTH);
    }
  }
}
