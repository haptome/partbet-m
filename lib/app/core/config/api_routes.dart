import 'package:partbet/app/utils/env_loader.dart';

class ApiRoutes {
  // ApiRoutes._(); // Prevents instantiation

  static String get base => Env.baseUrl;

  // static const login = '/auth/login';
  // static const register = '/auth/register';
  // static const userProfile = '/user/profile';
  // static const userSettings = '/user/settings';

  // static String userDetail(String id) => '/user/$id';
    factory ApiRoutes() => _instance;

  // Private constructor
  ApiRoutes._privateConstructor() {
    url = base ;
    

    // Initialize URLs using instance variables
    signUpWithEmail = '$url/user-auth/sign-up-with-email';
    resendOtp = '$url/user-auth/re-send-verification-otp';
    forgetPassword = '$url/user-auth/forgot-password';
    changePassword = '$url/user-auth/reset-password';
    isVerified = '$url/user-auth/is-verified';
    verifyEmailWithOtp = '$url/user-auth/verify-email-with-otp';
    verifyEmailWithOtpReset = '$url/user-auth/verify-reset-otp';
    updatePassword = '$url/user/password';
    reSendVerificationOtp = '$url/user-auth/re-send-verification-otp';
    signInWithPassword = '$url/user-auth/login';
    signUp = '$url/user-auth/sign-up';
    login = '$url/user-auth/login';
    sendVerificationLink = '$url/user-auth/re-send-verification-link';

    processImage = '$url2/process';
    fetchAllImage = '$url/images/all';
    deleteImage = '$url/images';

    updateUser = '$url/user';

    subscription = '$url/subscription';
    subscribe = '$url/subscription/subscribe';
    verifySubscription = '$url/subscription/successfully-subscribed';
    activeSubscription = '$url/subscription/active-subscription';
    activeFreeTrailSubscription = '$url/subscription/free-trial';
    cancelSubscription = '$url/subscription/cancel-active-subscription';

    companySetting = '$url/company-setting';
    publicCompanySetting = '$url/company-setting/public';

    suggestion = '$url/help-support/feature';
    contactUs = '$url/help-support/contact';

    getNotification = '$url/notification';
    getPromotions = '$url/promotion';
  }

  // Single instance
  static final ApiRoutes _instance = ApiRoutes._privateConstructor();

  late String url;
  late String url2;

  // Authentication URLs (converted from static to instance variables)
  late String signUpWithEmail;
  late String resendOtp;
  late String forgetPassword;
  late String changePassword;
  late String isVerified;
  late String verifyEmailWithOtp;
  late String verifyEmailWithOtpReset;
  late String updatePassword;
  late String reSendVerificationOtp;
  late String signInWithPassword;
  late String signUp;
  late String login;
  late String sendVerificationLink;

  // Image URLs
  late String processImage;
  late String fetchAllImage;
  late String deleteImage;

  // User Management URL
  late String updateUser;

  // Subscription URLs
  late String subscription;
  late String subscribe;
  late String verifySubscription;
  late String activeSubscription;
  late String activeFreeTrailSubscription;
  late String cancelSubscription;

  // Company Setting URLs
  late String companySetting;
  late String publicCompanySetting;

  // Settings
  late String suggestion;
  late String contactUs;
  late String getNotification;
  late String getPromotions;
}
