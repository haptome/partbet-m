import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/core/config/app_sizes.dart';
import 'package:partbet/app/shared/widgets/app_button.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import 'package:partbet/app/shared/widgets/trailing_icon_button.dart';

import '../../../routes/app_routes.dart';
import '../../../shared/widgets/social_button.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
@override
Widget build(BuildContext context) {
  final authController = Get.find<AuthController>();

  return SafeArea(
    child: SingleChildScrollView(
      // This allows the screen to resize when keyboard opens
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Image.asset(
                AppAssets.logo,
                height: 100.h,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome Back',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Access your garage, track your orders, and find the right parts fast.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AppTextField(
                controller: emailController,
                hintText: 'Enter email address or Phone number',
                backgroundColor: AppColors.transparent,
                useDarkTextField: false,
                borderColor: AppColors.textWhite100,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() => AppTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: authController.obscurePassword.value,
                    backgroundColor: AppColors.transparent,
                    useDarkTextField: false,
                    borderColor: AppColors.textWhite100,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 12.sp,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        authController.obscurePassword.value =
                            !authController.obscurePassword.value;
                      },
                      icon: ColorFiltered(
                        colorFilter: const ColorFilter.matrix([
                          -1, 0, 0, 0, 255, // Red
                          0, -1, 0, 0, 255, // Green
                          0, 0, -1, 0, 255, // Blue
                          0, 0, 0, 1, 0, // Alpha
                        ]),
                        child: Image.asset(
                          authController.obscurePassword.value
                              ? 'assets/icons/eye.png'
                              : 'assets/icons/eyeOff.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 15.h),
              AppButton(
                text: 'Login',
                onPressed: () {},
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                borderRadius: 8,
                height: 40.h,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<void>(AppRoutes.RESET_PASSWORD);
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                      child: Divider(color: Colors.white.withOpacity(0.2))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Divider(color: Colors.white.withOpacity(0.2))),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialButton(
                    icon: AppAssets.google,
                    label: 'Google',
                    onTap: () {},
                  ),
                  SocialButton(
                    icon: AppAssets.facebook,
                    label: 'Facebook',
                    onTap: () {},
                  ),
                  SocialButton(
                    icon: AppAssets.telegram,
                    label: 'Telegram',
                    onTap: () {},
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an Account?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed<void>(AppRoutes.REGISTRATION);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline,
                      color: Colors.white.withOpacity(0.4), size: 16),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      "We don't access your private info or share anything.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

            ],
          ),
        ),
      ),
    ),
  );
}

}


