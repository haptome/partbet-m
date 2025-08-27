import 'package:partbet/app/Pages/auth/bindings.dart';

import 'package:partbet/app/Pages/main/bindings.dart';
import 'package:partbet/app/Pages/main/views/main_view.dart';

import 'package:partbet/app/Pages/onboarding/bindings.dart';
import 'package:partbet/app/Pages/onboarding/views/onboarding_view.dart';
import 'package:partbet/app/Pages/orders/bindings.dart';
import 'package:partbet/app/Pages/parts/view/category_view.dart';
import 'package:partbet/app/Pages/parts/view/sub_category_view.dart';
import 'package:partbet/app/Pages/profile/view/faq_view.dart';
import 'package:partbet/app/Pages/profile/view/support_view.dart';

import 'package:partbet/app/Pages/splash/bindings.dart';
import 'package:partbet/app/Pages/splash/views/splash_view.dart';

import 'package:partbet/app/routes/app_routes.dart';
import 'package:get/get.dart';

import '../Pages/auth/view/auth_view.dart';
import '../Pages/auth/view/otp_verification_view.dart';
import '../Pages/auth/view/registration_view.dart';

import '../Pages/auth/view/reset_password_view.dart';
import '../Pages/orders/controller/orders_controller.dart';
import '../Pages/orders/view/order_detail_view.dart';
import '../Pages/orders/view/orders_view.dart';
import '../Pages/parts/bindings.dart';
import '../Pages/parts/view/product_detail_view.dart';
import '../Pages/profile/view/notification_settings_view.dart';
import '../Pages/profile/view/privacy_policy_view.dart';
import '../Pages/profile/view/term_condition_view.dart';
import '../Pages/profile/view/user_profile_view.dart';
import '../Pages/profile/view/address_view.dart';
import '../Pages/profile/view/contact_view.dart';
import 'package:partbet/app/Pages/parts/view/search_view.dart';
import 'package:partbet/app/Pages/parts/view/product_images_view.dart';
import 'package:partbet/app/Pages/parts/view/cart_view.dart';
import 'package:partbet/app/Pages/notifications/view/notifications_view.dart';
import 'package:partbet/app/Pages/parts/view/checkout_view.dart';
import 'package:partbet/app/Pages/services/view/service_detail_view.dart';
import 'package:partbet/app/Pages/inquiries/view/inquiries_view.dart';
import 'package:partbet/app/Pages/inquiries/bindings/inquiries_binding.dart';

class AppPages {
  AppPages._(); // Prevents instantiation
  static final routes = [
    // GetPage(
    //   name: AppRoutes.INITIAL,
    //   page: () => HomeView(),
    //   binding: HomeBindings(),
    // ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTRATION,
      page: () => RegistrationView(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: AppRoutes.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: AuthBindings(),
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
    ),
    GetPage(
      name: AppRoutes.MAINVIEW,
      page: () => MainView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.USER_PROFILE,
      page: () => const UserProfileView(),
      binding: MainViewBindings(),

    ),
    GetPage(
      name: AppRoutes.ADDRESS,
      page: () => const AddressView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.CONTACT,
      page: () => const ContactView(),
      binding: MainViewBindings(),),
          GetPage(
      name: AppRoutes.NOTIFICATION_SETTINGS,
      page: () =>  NotificationSettingsView(),
      binding: MainViewBindings(),),
          GetPage(
      name: AppRoutes.ORDERS,
      page: () =>  OrdersScreen(),
      binding: MainViewBindings(),),
    GetPage(
      name: AppRoutes.ORDER_DETAILS,
      page: () => OrderDetailScreen(order: Get.arguments as OrderModel),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.PARTS_DETAILS,
      page: () => ProductDetailScreen(product: Get.arguments as Map<String, dynamic>),
      binding: PartsBinding(),
    ),
    GetPage(
      name: AppRoutes.SERVICE_DETAILS,
      page: () => const ServiceDetailView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.FAQ,
      page: () => FaqView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.TERMS,
      page: () => TermConditionView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.PRIVACY,
      page: () => PrivacyPolicyView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.SUPPORT,
      page: () => SupportView(),
      binding: MainViewBindings(),
    ),
        GetPage(
      name: AppRoutes.CATEGORY,
      page: () => const CategoryView(),
      binding: MainViewBindings(),
    ),
        GetPage(
      name: AppRoutes.SUB_CATEGORY,
      page: () => const SubCategoryView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.PRODUCT_IMAGES,
      page: () => const ProductImagesView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.CART,
      page: () => const CartView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.CHECKOUT,
      page: () => const CheckoutView(),
      binding: MainViewBindings(),
    ),
    GetPage(
      name: AppRoutes.INQUIRIES,
      page: () =>  InquiriesView(),
      binding: InquiriesBinding(),
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

// Removed OrderDetailScreen class as it is not a Widget and not needed here.

