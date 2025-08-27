
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/app_bottom_nav.dart';
import 'package:partbet/app/shared/widgets/filter_chip_widget.dart';
import 'package:partbet/app/shared/widgets/app_text_field.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../../routes/app_routes.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../controller/profile_controller.dart';



class SupportView extends GetView<ProfileController> {
  SupportView({
    super.key,

  }) : super();
  




  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(), permanent: true);

    return Scaffold(
                  extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Support',
        showBackButton: true,
      
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
            child: _SupportContent(),
          ),
        ),
      ),
    );

  }}
// Support Content Widget
class _SupportContent extends StatefulWidget {
  @override
  State<_SupportContent> createState() => _SupportContentState();
}

class _SupportContentState extends State<_SupportContent> {

  
  // Selected support topics
  final List<String> _supportTopics = [
    'Billing and Payment',
    'Technical Problem',
    'Order and Delivery Issue',
    'Report a Bug',
    'Feature Suggestion'
  ];
  
  final Map<String, bool> _selectedTopics = {
    'Billing and Payment': true,
    'Technical Problem': false,
    'Order and Delivery Issue': true,
    'Report a Bug': true,
    'Feature Suggestion': false
  };
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  void _launchEmail(String email) {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      _launchUri(emailUri.toString());
    } catch (e) {
      print('Could not launch email: $e');
    }
  }

  void _launchPhone(String phoneNumber) {
    try {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      _launchUri(phoneUri.toString());
    } catch (e) {
      print('Could not launch phone: $e');
    }
  }

  void _launchUri(String uri) {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      Get.snackbar(
        'Opening',
        'Opening $uri',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.7),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'How can we help you?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'If you have any questions or need assistance, please contact us or fill out the form below.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _launchEmail('support@autogear.com');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.email, width: 20, height: 20),
                      const SizedBox(width: 10),
                      const Text('support@autogear.com', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Divider(color: AppColors.border,),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    _launchPhone('+12345678901');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.call, width: 20, height: 20),
                      const SizedBox(width: 10),
                      const Text('+1 234 567 890', style: TextStyle(color: Colors.white, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const Text(
                  'Select a support topic',
                  style: TextStyle(
                    color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: _supportTopics.map((topic) => FilterChipWidget(
                    label: topic,
                    isSelected: _selectedTopics[topic] ?? false,
                    selectedColor: const Color(0xFF00A3FF),
                    unselectedColor: Colors.white.withOpacity(0.08),
                    selectedTextColor: Colors.white,
                    unselectedTextColor: Colors.white,
                    onTap: () {
                      setState(() {
                        _selectedTopics[topic] = !(_selectedTopics[topic] ?? false);
                      });
                    },
                  )).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Send us a message',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _nameController,
                  hintText: 'Name',
                  backgroundColor: Colors.white.withOpacity(0.08),
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
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  backgroundColor: Colors.white.withOpacity(0.08),
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your email' : null,
                ),
                const SizedBox(height: 14),
                AppTextField(
                  controller: _messageController,
                  hintText: 'Message',
                  backgroundColor: Colors.white.withOpacity(0.08),
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
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter your message' : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA726),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle support message submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent!')),
                        );
                        _nameController.clear();
                        _emailController.clear();
                        _messageController.clear();
                      }
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
}
  


