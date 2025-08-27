import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/app_button.dart';

import '../../../routes/app_routes.dart';
import '../../../shared/widgets/auth_background.dart';

class OtpVerificationView extends StatelessWidget {
  final String destination; // e.g. 'Email ha**@gmail.com' or 'phone 0927****68'
  final bool isEmail;
  final int secondsLeft;
  final List<String> codeDigits;
  final VoidCallback? onResend;
  final VoidCallback? onVerify;
  final VoidCallback? onBackToLogin;
  final VoidCallback? onRegister;

  const OtpVerificationView({
    super.key,
    required this.destination,
    required this.isEmail,
    this.secondsLeft = 0,
    this.codeDigits = const ['', '', '', '', '', ''],
    this.onResend,
    this.onVerify,
    this.onBackToLogin,
    this.onRegister,
  });

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
                'OTP Verification',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13.sp,
                  ),
                  children: [
                    TextSpan(
                      text: "We've sent a 6-digit code to your ",
                    ),
                    TextSpan(
                      text: isEmail ? 'Email ' : 'phone ',
                    ),
                    TextSpan(
                      text: destination,
                      style: TextStyle(color: AppColors.primary),
                    ),
                    const TextSpan(text: '\nPlease enter it to continue.'),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              _OtpInputFields(onCompleted: onVerify),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Text(
                    'Resend Code',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '00:${secondsLeft.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              AppButton(
                text: 'Verify',
                onPressed: onVerify ?? () {
                  // Default action if no callback provided
                  Get.offAllNamed(AppRoutes.MAINVIEW); 
                },
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                borderRadius: 8,
                height: 44.h,
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      if (isEmail) {
                        Get.offAllNamed(AppRoutes.REGISTRATION);
                      } else {
                        Get.offAllNamed(AppRoutes.AUTH);
                      }
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


class _OtpInputFields extends StatefulWidget {
  final VoidCallback? onCompleted;
  const _OtpInputFields({this.onCompleted});

  @override
  State<_OtpInputFields> createState() => _OtpInputFieldsState();
}

class _OtpInputFieldsState extends State<_OtpInputFields> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int idx) {
    if (value.length == 1 && idx < 5) {
      _focusNodes[idx + 1].requestFocus();
    }
    if (value.isEmpty && idx > 0) {
      _focusNodes[idx - 1].requestFocus();
    }
    if (_controllers.every((c) => c.text.length == 1)) {
      // Unfocus all fields when all 6 digits are filled
      FocusScope.of(context).unfocus();
      widget.onCompleted?.call();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (i) => SizedBox(
        width: 44.w,
        child: TextField(
          controller: _controllers[i],
          focusNode: _focusNodes[i],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 1,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: const Color.fromARGB(30, 240, 240, 240),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
          onChanged: (v) => _onChanged(v, i),
          onTap: () => _controllers[i].selection = TextSelection(baseOffset: 0, extentOffset: _controllers[i].text.length),
          inputFormatters: [
            // Only allow digits
            FilteringTextInputFormatter.digitsOnly,
          ],
        ),
      )),
    );
  }
}
