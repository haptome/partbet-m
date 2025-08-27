import 'package:flutter/material.dart';
// import 'package:partbet/app/core/services/calculation_service.dart';
// import 'package:partbet/app/core/services/user_service.dart';
// import 'package:partbet/app/core/services/secure_storage_service.dart';
// import 'package:partbet/app/core/services/wet_mill_service.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/services/secure_storage_service.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SecureStorageService().init());
  // await Get.putAsync(() => CalculationService().init());
  // await Get.putAsync(() => UserService().init());
  // await Get.putAsync(() => SiteService().init());
}
