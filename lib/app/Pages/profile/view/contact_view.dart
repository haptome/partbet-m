import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/shared/widgets/general_app_bar.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_assets.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Contact Detail',
          showBackButton: true,
          trailing: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.notification,
                    color: Colors.white,
                    width: 24,
                    height: 24,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      'Contact Information',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      hintText: '+251 9',
                      controller: _phoneController,
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
                    const SizedBox(height: 10),
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AppTextField(
                      hintText: 'e.g. Dave@gmail.com',
                      controller: _emailController,
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
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                      decoration: BoxDecoration(
                        color: AppColors.transparent.withOpacity(0.047),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                            child: Text(
                              'Connection',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Google
                            _ConnectionTile(
                            icon: AppAssets.google,
                            label: 'Google',
                            value: 'Dave@gmail.com',
                            trailing: SvgPicture.asset(
                              AppAssets.badge,
                              width: 24,
                              height: 24,
                              
                            ),
                          ),
                          const SizedBox(height: 10),

                          Divider(color: Colors.white.withOpacity(0.08), height: 1, thickness: 1, indent: 20, endIndent: 20),
                          const SizedBox(height: 15),
                          
                          _ConnectionTile(
                            icon: AppAssets.facebook,
                            label: 'Facebook',
                            value: '',
                            trailing: SvgPicture.asset(
                              AppAssets.arrow,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.srcIn,
                              ),
                              
                            ),
                          ),
                          const SizedBox(height: 15),

                          Divider(color: Colors.white.withOpacity(0.08), height: 1, thickness: 1, indent: 18, endIndent: 18),
                          const SizedBox(height: 10),
                          
                          _ConnectionTile(
                            icon: AppAssets.telegram,
                            label: 'Telegram',
                            value: '',
                            trailing: SvgPicture.asset(
                              AppAssets.arrow,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(0.5),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFB86B1F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      
    );
}

class _ConnectionTile extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Widget trailing;
  const _ConnectionTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 28, height: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (value.isNotEmpty)
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
}
