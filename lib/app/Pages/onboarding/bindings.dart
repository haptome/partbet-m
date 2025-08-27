
import 'package:partbet/app/Pages/onboarding/controllers/onboarding_controller.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(OnboardingController.new);

    // Get.lazyPut<AuthController>(AuthController.new);
  }
}
