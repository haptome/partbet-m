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
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/social_button.dart';
import '../controllers/auth_controller.dart';

class RegistrationView extends StatelessWidget {
  RegistrationView({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RxBool obscureConfirmPassword = true.obs;

  @override
 @override
Widget build(BuildContext context) {
  final AuthController authController = Get.find<AuthController>();

  return AuthBackground(
    child: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
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
                SizedBox(height: 24.h),
                Image.asset(
                  AppAssets.logo,
                  height: 80.h,
                ),
                SizedBox(height: 8.h),
                Text(
                  'AutoGear',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp,
                  ),
                ),
                SizedBox(height: 18.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's Get You Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Fill in your details to set up your account and start shopping for the parts you need.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                AppTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                  backgroundColor: const Color.fromARGB(30, 240, 240, 240),
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
                AppTextField(
                  controller: emailController,
                  hintText: 'Email or Phone Number',
                  backgroundColor: const Color.fromARGB(30, 240, 240, 240),
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
                      hintText: 'Create Password',
                      obscureText: authController.obscurePassword.value,
                      backgroundColor: const Color.fromARGB(30, 240, 240, 240),
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
                            -1, 0, 0, 0, 255,
                            0, -1, 0, 0, 255,
                            0, 0, -1, 0, 255,
                            0, 0, 0, 1, 0,
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
                SizedBox(height: 10.h),
                Obx(() => AppTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: obscureConfirmPassword.value,
                      backgroundColor: const Color.fromARGB(30, 240, 240, 240),
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
                          obscureConfirmPassword.value =
                              !obscureConfirmPassword.value;
                        },
                        icon: ColorFiltered(
                          colorFilter: const ColorFilter.matrix([
                            -1, 0, 0, 0, 255,
                            0, -1, 0, 0, 255,
                            0, 0, -1, 0, 255,
                            0, 0, 0, 1, 0,
                          ]),
                          child: Image.asset(
                            obscureConfirmPassword.value
                                ? 'assets/icons/eye.png'
                                : 'assets/icons/eyeOff.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                    )),
                SizedBox(height: 18.h),
                AppButton(
                  text: 'Create Account',
                  onPressed: () {
                    authController.signUpWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                      fullNameController.text,
                    );
                    Get.offAllNamed<void>(AppRoutes.OTP);
                  },
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  borderRadius: 8,
                  height: 44.h,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (v) {},
                      activeColor: AppColors.primary,
                      checkColor: Colors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10.sp,
                          ),
                          children: const [
                            TextSpan(
                                text:
                                    'By creating an account, you agree to our '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy.',
                              style: TextStyle(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: Colors.white.withOpacity(0.2))),
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
                        child: Divider(
                            color: Colors.white.withOpacity(0.2))),
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRoutes.AUTH);
                      },
                      child: Text(
                        'Login',
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
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

}


