
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/app_bottom_nav.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../controller/profile_controller.dart';



class PrivacyPolicyView extends GetView<ProfileController> {
  PrivacyPolicyView({
    super.key,

  }) : super();
  




  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(), permanent: true);

    return Scaffold(
                  extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Privacy Policy',
        showBackButton: true,
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: _PrivacyPolicyContent(),
          ),
        ),
      ),
    );

  }}
// Privacy Policy Content Widget
class _PrivacyPolicyContent extends StatefulWidget {
  @override
  State<_PrivacyPolicyContent> createState() => _PrivacyPolicyContentState();
}

class _PrivacyPolicyContentState extends State<_PrivacyPolicyContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'UPDATED ON: JAN 20, 2024',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.6),
                    children: [
                      const TextSpan(
                        text: '1. Lorem ipsum dolor\n',
                        style: TextStyle(
                          color: Color(0xFFFFA726),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const TextSpan(
                        text: '\nLorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus. Lorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus. Natolorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus.\n\nLorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus. Natolorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus.\n\nLorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus. Natolorem Ipsum Dolor Sit Amet Consectetur. Ac Nam Accumsan Praesent Lacus Lorem Mauris. Egestas Lectus Orci Massa Consequat Scelerisque. Eget Nunc Tristique Libero Facilisis Risus.\n',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add more sections here as needed, or replace with API content later
              ],
            ),
          ),
        ),
      ],
    );
  }
}
  


