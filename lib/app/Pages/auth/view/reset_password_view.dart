import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/app_button.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';

import '../../../routes/app_routes.dart';
import '../../../shared/widgets/auth_background.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Text(
                'Reset Password',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Access your garage, track your orders, and find the right parts fast.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(height: 28.h),
              AppTextField(
                controller: emailController,
                hintText: 'Enter Email  or Phone number',
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
              SizedBox(height: 20.h),
              AppButton(
                text: 'Reset Password',
                onPressed: () {},
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                borderRadius: 8,
                height: 44.h,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Back to login',
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
            ],
          ),
        ),
      ),
    );
  }
}
