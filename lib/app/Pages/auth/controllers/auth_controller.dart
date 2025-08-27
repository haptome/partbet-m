import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:partbet/app/models/user_model.dart';
import 'package:partbet/app/core/config/api_routes.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/services/language_service.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:partbet/app/core/services/notification_service.dart';
import 'package:partbet/app/models/authentication_models.dart';
import 'package:partbet/app/models/company_model.dart';
import 'package:partbet/app/shared/widgets/show_custom_toast.dart';
import 'package:partbet/app/core/network/http_util.dart';
import 'package:toastification/toastification.dart';

class AuthController extends GetxController {
  final LanguageService _languageService = LanguageService();
  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  RxBool forgetPassword = false.obs;
  RxBool isChangePasswordOn = false.obs;
  RxBool otpLoader = false.obs;
  RxBool selectedEmail = true.obs;
  RxBool isSignUp = false.obs;
  RxBool isOtpOpen = false.obs;
  RxBool loading = false.obs;
  RxBool loadingGoogle = false.obs;
  RxBool hasConfirmPasswordError = false.obs;
  final Rxn<CompanySettingsModel> companySettingData =
      Rxn<CompanySettingsModel>();

  // social signin loadings
  var loadingFacebook = false.obs;
  var loadingApple = false.obs;

  var otp = ''.obs;
  RxBool showPaymentPlan = false.obs;
  RxBool isOtherPlanOn = false.obs;
  var sharedPref = EncryptedSharedPreferences.getInstance();
  late Timer _timer;
  RxInt countdownTime = 60.obs;
  final isAmharic = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSites();
    _loadSavedLanguage();
  }

  void loadSites() {}

  void toggleLanguage() async {
    isAmharic.value = !isAmharic.value;
    final languageCode = isAmharic.value ? 'am' : 'en';
    final countryCode = isAmharic.value ? 'ET' : 'US';
    await _languageService.saveLanguage(languageCode, countryCode);
    _changeLanguage(languageCode, countryCode);
  }

  void _changeLanguage(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }

  void _loadSavedLanguage() async {
    final savedLocale = await _languageService.getSavedLocale();
    isAmharic.value = savedLocale.languageCode == 'am';
    Get.updateLocale(savedLocale);
  }

  String get flagAsset =>
      !isAmharic.value ? AppAssets.etFlag : AppAssets.ukFlag;

  String get languageText => !isAmharic.value ? 'አማርኛ' : 'English';
  //to signin with google account
  Future<User?> signInWithGoogle() async {
    loadingGoogle.value = true;
    // try {
    //   final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    //   if (googleUser == null) {
    //     loadingGoogle.value = false;
    //     return null;
    //   }

    //   final GoogleSignInAuthentication googleAuth =
    //       await googleUser.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );

    //   final UserCredential userCredential =
    //       await _auth.signInWithCredential(credential);
    //   return await _handleSignIn(userCredential);
    // } catch (e) {
    //   return null;
    // } finally {
    //   loadingGoogle.value = false;
    // }
  }

  Future<User?> signInWithFacebook() async {
    loadingFacebook.value = true;

    // try {
    //   // Trigger the sign-in flow
    //   final loginResult = await FacebookAuth.instance.login();

    //   if (loginResult.status != LoginStatus.success) return null;

    //   // Facebook authentication with credential
    //   final credential = FacebookAuthProvider.credential(
    //     loginResult.accessToken!.tokenString,
    //   );
    //   final userCredential = await _auth.signInWithCredential(credential);

    //   return await _handleSignIn(userCredential);
    // } catch (e) {
    //   return null;
    // } finally {
    //   loadingFacebook.value = false;
    // }
  }

  Future<User?> _handleSignIn(UserCredential userCredential) async {
    // try {
    //   final user = userCredential.user;

    //   if (user == null) return null;

    //   final idToken = await user.getIdToken() ?? '';
    //   final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

    //   if (isNewUser) {
    //     await signUpHandler(token: idToken);
    //   } else {
    //     await signInHandler(
    //       token: idToken,
    //       email: user.email ?? '',
    //     );
    //   }

    //   return user;
    // } catch (e) {
    //   return null;
    // }
  }

  void startCountdown() {
    loading.value = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownTime.value > 0) {
        countdownTime.value--;
        if (countdownTime.value == 0) {
          otpLoader.value = false;
          countdownTime.value = 60;
        }
      } else {
        otpLoader.value = false;
        _timer.cancel();
      }
    });
  }

  void stopCountdown() {
    _timer.cancel();
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    loading.value = true;
    // final String deviceId =
    //     Platform.isAndroid ? 'androidDeviceId' : 'iosDeviceId';
    // final fcmToken = sharedPref.getString('fcmToken');
    // try {
    //   final SignUpWithEmailModel signUpRequest = SignUpWithEmailModel(
    //     email: email,
    //     password: password,
    //     name: name,
    //     deviceId: deviceId,
    //     fcmToken: fcmToken ?? await getFcmToken(),
    //   );

    //   final response = await dio.post<dynamic>(
    //     ApiRoutes().signUpWithEmail,
    //     data: signUpRequest.toJson(),
    //   );

    //   if (response.statusCode == 201) {
    //     // Sign-up successful, OTP sent
    //     showCustomToast(
    //       type: ToastificationType.success,
    //       title:
    //           'OTP code has been sent to your email. Please check your inbox.',
    //     );
    //     // Ensure response.data is cast to Map<String, dynamic>
    //     final responseData = response.data as Map<String, dynamic>;
    //     // Parse the response into UserModel
    //     final UserModel userModel = UserModel.fromJson(responseData);

    //     // Store the token and user details
    //     await sharedPref.setString(
    //       'token',
    //       userModel.accessToken,
    //       notify: true,
    //     );
    //     await sharedPref.setString('userId', userModel.user.id, notify: true);
    //     await sharedPref.setString(
    //       'userEmail',
    //       userModel.user.email,
    //       notify: true,
    //     );
    //     await sharedPref.setString(
    //       'fullName',
    //       '${userModel.user.firstName} ${userModel.user.lastName}',
    //       notify: true,
    //     );
    //     await sharedPref.setString('phone', userModel.user.phone, notify: true);
    //     await sharedPref.setBoolean('isLoggedWithGoogle', false, notify: true);
    //     isOtpOpen.value = true;
    //   }
    // } finally {
    //   loading.value = false;
    // }
  }

  Future<void> resendOtpHandler(String email) async {
    otpLoader.value = true;
    startCountdown();
    try {
      final ResendOtplModel resendOtpRequest = ResendOtplModel(email: email);
      final response = await dio.post<dynamic>(
        ApiRoutes().resendOtp,
        data: resendOtpRequest.toJson(),
      );

      if (response.statusCode == 200) {
        showCustomToast(
          type: ToastificationType.success,
          title:
              'OTP code has been resent to your email. Please check your inbox.',
        );
      }
    } catch (e) {
      otpLoader.value = false;
    }
  }

  Future<void> otpCheckHandler(String email) async {
    loading.value = true;
    try {
      final OtpCheckHandlerModel otpCheckRequest =
          OtpCheckHandlerModel(email: email, otp: otp.value);

      final response = await dio.post<dynamic>(
        ApiRoutes().verifyEmailWithOtp,
        data: otpCheckRequest.toJson(),
      );
      await getCompanySetting(isRequiredRoute: false);
      if (response.statusCode == 200) {
        final notificationService = NotificationService();
        notificationService.subscribeToTopic('NEW');
        showPaymentPlan.value = true;
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> otpCheckForResetHandler(String email) async {
    loading.value = true;
    try {
      final OtpCheckForResetHandlerModel otpCheckRequest =
          OtpCheckForResetHandlerModel(email: email, otp: otp.value);

      final response = await dio.post<dynamic>(
        ApiRoutes().verifyEmailWithOtpReset,
        data: otpCheckRequest.toJson(),
      );

      if (response.statusCode == 200) {
        loading.value = false;

        isOtpOpen.value = false;
        isChangePasswordOn.value = true;
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> resendEmailHandler(String email) async {
    try {
      await dio.post<dynamic>(
        ApiRoutes().sendVerificationLink,
        data: {
          'email': email,
        },
      );
    } catch (e) {
      return;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    loading.value = true;

    try {
      final SignInWithEmailAndPasswordModel signInRequest =
          SignInWithEmailAndPasswordModel(email: email, password: password);
      final response = await dio.post<dynamic>(
        ApiRoutes().signInWithPassword,
        data: signInRequest.toJson(),
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        // Parse the response into UserModel
        final UserModel userModel = UserModel.fromJson(responseData);

        // Successful login, save token and user details
        await sharedPref.setString(
          'token',
          userModel.accessToken,
          notify: true,
        );
        await sharedPref.setString('userId', userModel.user.id, notify: true);
        await sharedPref.setString(
          'userEmail',
          userModel.user.email,
          notify: true,
        );
        await sharedPref.setString(
          'fullName',
          '${userModel.user.firstName} ${userModel.user.lastName}',
          notify: true,
        );
        await sharedPref.setString('phone', userModel.user.phone, notify: true);
        await sharedPref.setBoolean('isLoggedWithGoogle', false, notify: false);
        await sharedPref.setString(
          'createdAt',
          userModel.user.createdAt,
          notify: true,
        );
        await getCompanySetting();
      }
    } on DioException catch (e) {
      final int statusCode = e.response?.statusCode ?? 0;
      if (statusCode == 406) {
        showCustomToast(
          type: ToastificationType.success,
          title:
              'OTP code has been sent to your email. Please check your inbox.',
        );
        isOtpOpen.value = true;
      }
      await sharedPref.setString(
        'userEmail',
        email,
        notify: true,
      );
    } finally {
      loading.value = false;
    }
  }

  Future<void> signUpHandler({required String token}) async {
    final String deviceId =
        Platform.isAndroid ? 'androidDeviceId' : 'iosDeviceId';
    final fcmToken = sharedPref.getString('fcmToken');

    try {
      final SignUpWithToken signUpRequest = SignUpWithToken(
        token: token,
        deviceId: deviceId,
        fcmToken: fcmToken ?? await getFcmToken(),
      );

      final response = await dio.post<dynamic>(ApiRoutes().signUp,
          data: signUpRequest.toJson());

      if (response.statusCode == 201) {
        final notificationService = NotificationService();
        notificationService.subscribeToTopic('NEW');
        final responseData = response.data as Map<String, dynamic>;
        // Parse the response into UserModel
        final UserModel userModel = UserModel.fromJson(responseData);
        showCustomToast(
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 5),
          title:
              'Your account is created Successful,Your account is not verified. Please verify your email to proceed and login again',
        );
        await sharedPref.setString(
          'token',
          userModel.accessToken,
          notify: true,
        );
        await sharedPref.setString('userId', userModel.user.id, notify: true);
        await sharedPref.setString(
          'userEmail',
          userModel.user.email,
          notify: true,
        );
        await sharedPref.setString(
          'fullName',
          '${userModel.user.firstName} ${userModel.user.lastName}',
          notify: true,
        );
        await sharedPref.setString(
          'phone',
          userModel.user.phoneNumber,
          notify: true,
        );
        await sharedPref.setBoolean(
          'passwordSet',
          userModel.passwordSet ?? false,
          notify: true,
        );
        await sharedPref.setBoolean('isLoggedWithGoogle', true, notify: true);
        await sharedPref.setString(
          'createdAt',
          userModel.user.createdAt,
          notify: true,
        );

        await getCompanySetting();
      }
    } finally {}
  }

  Future<void> signInHandler({
    required String token,
    required String email,
  }) async {
    try {
      final response =
          await dio.post<dynamic>(ApiRoutes().login, data: {'token': token});
      final responseData = response.data as Map<String, dynamic>;
      if (response.statusCode == 200) {
        // Parse the response into UserModel
        final UserModel userModel = UserModel.fromJson(responseData);
        // Successful login, save user details
        await sharedPref.setString(
          'token',
          userModel.accessToken,
          notify: true,
        );
        await sharedPref.setString('userId', userModel.user.id, notify: true);
        await sharedPref.setString(
          'userEmail',
          userModel.user.email,
          notify: true,
        );
        await sharedPref.setString(
          'fullName',
          '${userModel.user.firstName} ${userModel.user.lastName}',
          notify: true,
        );
        await sharedPref.setString(
          'phone',
          userModel.user.phoneNumber ?? '',
          notify: true,
        );
        await sharedPref.setBoolean(
          'passwordSet',
          userModel.passwordSet ?? false,
          notify: true,
        );
        await sharedPref.setString(
          'createdAt',
          userModel.user.createdAt,
          notify: true,
        );
        await sharedPref.setBoolean('isLoggedWithGoogle', true, notify: true);

        await getCompanySetting();
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data['statusCode'] == 406) {
          resendEmailHandler(email);
          showCustomToast(
            type: ToastificationType.error,
            title:
                'Your account is not verified. Please verify your email to proceed.',
          );
        }
      }
    }
  }

  Future<void> getCompanySetting({bool isRequiredRoute = true}) async {
    loading.value = true;
    final token = sharedPref.getString('token');
    try {
      final response = await dio.get<dynamic>(
        ApiRoutes().companySetting,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 && response.data != null) {
        // Ensure response.data is cast to Map<String, dynamic>
        final responseData = response.data as Map<String, dynamic>;
        // Parse the response into UserModel
        final CompanySettingsModel companySetting =
            CompanySettingsModel.fromJson(responseData);
      }
    } finally {
      loading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      // await _googleSignIn.signOut();
      // await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getFcmToken() async {
    String fcmToken = 'iosFcmToken';
    if (Platform.isIOS) {
      return fcmToken;
    }
    // fcmToken = await FirebaseMessaging.instance.getToken() ?? '';
    // final sharedPref = EncryptedSharedPreferences.getInstance();

    // await sharedPref.setString(
    //   'fcmToken',
    //   fcmToken,
    //   notify: true,
    // );
    return fcmToken;
  }
}
