
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/app_bottom_nav.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../controller/profile_controller.dart';



class ProfileView extends GetView<ProfileController> {
  ProfileView({
    super.key,

  }) : super();
  




  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(), permanent: true);
    final userName = 'Dave Hakeem';
    final userInitial = userName.isNotEmpty ? userName[0] : '';
    final userLocation = 'Addis Abeba, Ethiopia';
    return Scaffold(
      backgroundColor: const Color(0xFF18100B),
       appBar: GeneralAppBar(
        title: 'Profile',
          showBackButton: false,
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
      body: SafeArea(
        child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA726),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            userInitial,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome,',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      userLocation,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.location_on, color: Colors.white.withOpacity(0.5), size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    _ProfileCard(
                      iconAsset: AppAssets.profile2,
                      label: 'User Profile',
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.USER_PROFILE);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.contact,
                      label: 'Contact Detail',
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.CONTACT);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.location,
                      label: 'Address',
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.ADDRESS);
                      },
                      isSvgIcon: true,
                    ),
                     SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.location,
                      label: 'Notifications',
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.NOTIFICATION_SETTINGS);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.faq,
                      label: 'FAQ',
                      textColor: AppColors.textWhite60.withOpacity(0.8),
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.FAQ);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.tac,
                      textColor: AppColors.textWhite60.withOpacity(0.8),
                      label: 'Terms & Conditions',

                      onTap: () {
                        Get.toNamed<void>(AppRoutes.TERMS);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.pp,
                      label: 'Privacy Policy',
                      textColor: AppColors.textWhite60.withOpacity(0.8),
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.PRIVACY);
                      },
                      isSvgIcon: true,
                    ),
                    SizedBox(height: 16),
                    _ProfileCard(
                      iconAsset: AppAssets.support,
                      label: 'Support',
                      textColor: AppColors.textWhite60.withOpacity(0.8),
                      onTap: () {
                        Get.toNamed<void>(AppRoutes.SUPPORT);
                      },
                      isSvgIcon: true,
                    ),
                    // const Spacer(),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}


class _ProfileCard extends StatelessWidget {
  final String iconAsset; // SVG or image asset path
  final String label;
  final VoidCallback onTap;
  final bool isSvgIcon;
  final Color textColor;
  const _ProfileCard({
    required this.iconAsset,
    required this.label,
    required this.onTap,
    this.textColor = AppColors.textWhite60,
    this.isSvgIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            isSvgIcon
                ? SvgPicture.asset(
                    iconAsset,
                    width: 26,
                    height: 26,
                    // colorFilter: const ColorFilter.mode(AppColors.textWhite100, BlendMode.srcIn),
                  )
                : Image.asset(
                    iconAsset,
                    width: 26,
                    height: 26,
                    
                  ),
            SizedBox(width: 18),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SvgPicture.asset(
              AppAssets.arrowRight,
              width: 24,
              height: 24,
              // colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

