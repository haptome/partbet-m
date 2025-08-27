import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/Pages/auth/view/login_view.dart';
import 'package:partbet/app/Pages/splash/controllers/splash_controller.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/core/config/app_sizes.dart';
import 'package:get/get.dart';

import '../../../core/config/app_assets.dart';
import '../../../shared/widgets/auth_background.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AuthBackground(
        child: LoginView(),
      ),
    );
  }
}

/// A reusable widget for the authentication background pattern and gradient.
