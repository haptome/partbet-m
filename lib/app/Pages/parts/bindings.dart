import 'package:partbet/app/Pages/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

import 'controller/parts_controller.dart';


class PartsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartsController>(PartsController.new);
  }
}
