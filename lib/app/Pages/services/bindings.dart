import 'package:partbet/app/Pages/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

import 'controller/services_controller.dart';


class ServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(ServicesController.new);
  }
}
