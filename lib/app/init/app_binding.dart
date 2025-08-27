import 'package:dio/dio.dart';
import 'package:partbet/app/core/network/api_client.dart';
import 'package:partbet/app/core/services/secure_storage_service.dart';
import 'package:get/get.dart';

import '../Pages/auth/controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Core network setup
    Get.put<Dio>(ApiClient.createDio());

    // App-wide Services
    Get.put<SecureStorageService>(SecureStorageService());
    Get.put<AuthController>(AuthController());

    // Global Controller (optional)

  }
}
