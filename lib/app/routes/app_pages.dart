import 'package:partbet/app/routes/app_routes.dart';
import 'package:get/get.dart';

// Optimized: Import only what's needed, use lazy instantiation in GetPage
import 'package:partbet/app/Pages/splash/bindings.dart';
import 'package:partbet/app/Pages/splash/views/splash_view.dart';

import 'package:partbet/app/Pages/onboarding/bindings.dart';
import 'package:partbet/app/Pages/onboarding/views/onboarding_view.dart';

import 'package:partbet/app/Pages/auth/bindings.dart';
import 'package:partbet/app/Pages/auth/view/auth_view.dart';
import 'package:partbet/app/Pages/auth/view/otp_verification_view.dart';
import 'package:partbet/app/Pages/auth/view/registration_view.dart';
import 'package:partbet/app/Pages/auth/view/reset_password_view.dart';

import 'package:partbet/app/Pages/main/bindings.dart';
import 'package:partbet/app/Pages/main/views/main_view.dart';

import 'package:partbet/app/Pages/profile/view/user_profile_view.dart';
import 'package:partbet/app/Pages/profile/view/address_view.dart';
import 'package:partbet/app/Pages/profile/view/contact_view.dart';
import 'package:partbet/app/Pages/profile/view/notification_settings_view.dart';
import 'package:partbet/app/Pages/profile/view/faq_view.dart';
import 'package:partbet/app/Pages/profile/view/privacy_policy_view.dart';
import 'package:partbet/app/Pages/profile/view/term_condition_view.dart';
import 'package:partbet/app/Pages/profile/view/support_view.dart';

import 'package:partbet/app/Pages/orders/bindings.dart';
import 'package:partbet/app/Pages/orders/view/orders_view.dart';
import 'package:partbet/app/Pages/orders/view/order_detail_view.dart';
import 'package:partbet/app/Pages/orders/controller/orders_controller.dart';

import 'package:partbet/app/Pages/parts/bindings.dart';
import 'package:partbet/app/Pages/parts/view/product_detail_view.dart';
import 'package:partbet/app/Pages/parts/view/category_view.dart';
import 'package:partbet/app/Pages/parts/view/sub_category_view.dart';
import 'package:partbet/app/Pages/parts/view/search_view.dart';
import 'package:partbet/app/Pages/parts/view/product_images_view.dart';
import 'package:partbet/app/Pages/parts/view/cart_view.dart';
import 'package:partbet/app/Pages/parts/view/checkout_view.dart';

import 'package:partbet/app/Pages/services/view/service_detail_view.dart';

import 'package:partbet/app/Pages/notifications/view/notifications_view.dart';

import 'package:partbet/app/Pages/inquiries/bindings/inquiries_binding.dart';
import 'package:partbet/app/Pages/inquiries/view/inquiries_view.dart';

class AppPages {
  AppPages._(); // Prevents instantiation
  
  // Optimized: Routes use lazy instantiation (widgets created when navigated to)
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthView(),
      binding: OnboardingBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.REGISTRATION,
      page: () => RegistrationView(),
      binding: AuthBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: AuthBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.OTP,
      page: () {
        final params = Get.parameters;
        final destination = params['destination'] ?? '';
        final isEmail = (params['isEmail'] ?? 'true') == 'true';
        return OtpVerificationView(
          destination: destination,
          isEmail: isEmail,
        );
      },
      binding: AuthBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.MAINVIEW,
      page: () => MainView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ADDRESS,
      page: () => const AddressView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.CONTACT,
      page: () => const ContactView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION_SETTINGS,
      page: () => NotificationSettingsView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ORDERS,
      page: () => OrdersScreen(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.ORDER_DETAILS,
      page: () => OrderDetailScreen(order: Get.arguments as OrderModel),
      binding: OrdersBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.PARTS_DETAILS,
      page: () => ProductDetailScreen(product: Get.arguments as Map<String, dynamic>),
      binding: PartsBinding(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.SERVICE_DETAILS,
      page: () => const ServiceDetailView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.FAQ,
      page: () => FaqView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.TERMS,
      page: () => TermConditionView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.PRIVACY,
      page: () => PrivacyPolicyView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.SUPPORT,
      page: () => SupportView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.CATEGORY,
      page: () => const CategoryView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.SUB_CATEGORY,
      page: () => const SubCategoryView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.PRODUCT_IMAGES,
      page: () => const ProductImagesView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => const CheckoutView(),
      binding: MainViewBindings(),
      preventDuplicates: true,
    ),
    GetPage(
      name: AppRoutes.INQUIRIES,
      page: () => InquiriesView(),
      binding: InquiriesBinding(),
      preventDuplicates: true,
    ),
  ];
}

class OnboardingPage {
  const OnboardingPage({
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image;
  final String title;
  final String subTitle;
}
