import 'package:encrypt_shared_preferences/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/core/config/app_theme.dart';
import 'package:partbet/app/core/config/app_constant.dart';
import 'package:partbet/app/core/localization/translations.dart';
import 'package:partbet/app/core/services/language_service.dart';
import 'package:partbet/app/core/services/notification_service.dart';

import 'package:partbet/app/init/app_binding.dart';
import 'package:partbet/app/routes/app_pages.dart';
import 'package:partbet/app/routes/app_routes.dart';

import 'package:get/get.dart';
import 'package:partbet/app/utils/env_loader.dart';
import 'package:partbet/firebase_options.dart';

import 'app/init/service_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional
  ]);
  await AppTranslations.loadTranslations();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
  // Load the appropriate env file
  await Env.load();

  await initServices();
  await LanguageService().getSavedLocale();

  final savedLocale = await LanguageService().getSavedLocale();
    await EncryptedSharedPreferences.initialize('initializationKey');
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // final notificationService = NotificationService();
  // notificationService.initialize();
  // await notificationService.subscribeToTopic('GUEST');
  // await notificationService.subscribeToTopic('ALL');
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(
    MyApp(savedLocale: savedLocale));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.savedLocale, super.key});
  final Locale savedLocale;
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) => GetMaterialApp(
          translations: AppTranslations(),
          locale: savedLocale,
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: AppTheme.light,
          initialBinding: AppBindings(),
          getPages: AppPages.routes,
          initialRoute: AppRoutes.SPLASH,
        ),
      );
}
