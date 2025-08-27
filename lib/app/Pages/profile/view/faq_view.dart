
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



class FaqView extends GetView<ProfileController> {
  FaqView({
    super.key,

  }) : super();
  




  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(), permanent: true);

    return Scaffold(
            extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'FAQ',
        showBackButton: true,
        
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: _FaqContent(),
          ),
        ),
      ),
    );

  }}
// FAQ Content Widget
class _FaqContent extends StatefulWidget {
  @override
  State<_FaqContent> createState() => _FaqContentState();
}

class _FaqContentState extends State<_FaqContent> {
  int _expandedIndex = 0;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'How to pay for a part?',
      'answer': 'Lorem ipsum dolor sit amet consectetur. Morbi tristique semper sit aliquam justo magna adipiscing venenatis. In sed potenti cursus sociis ligula tellus mattis.'
    },
    {
      'question': 'How to change my profile data?',
      'answer': 'Lorem ipsum dolor sit amet consectetur. Morbi tristique semper sit aliquam justo magna adipiscing venenatis. In sed potenti cursus sociis ligula tellus mattis.'

    },
    {
      'question': 'How to change my address of delivery?',
      'answer': 'Lorem ipsum dolor sit amet consectetur. Morbi tristique semper sit aliquam justo magna adipiscing venenatis. In sed potenti cursus sociis ligula tellus mattis.'
    },
    {
      'question': 'How to cancel an order?',
      'answer': 'Lorem ipsum dolor sit amet consectetur. Morbi tristique semper sit aliquam justo magna adipiscing venenatis. In sed potenti cursus sociis ligula tellus mattis.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Our most asked questions in Auto Gear',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.separated(
            itemCount: _faqs.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, i) {
              final isExpanded = _expandedIndex == i;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _expandedIndex = _expandedIndex == i ? -1 : i;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: isExpanded ? const Color(0xFFFFA726) : Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _faqs[i]['question']!,
                              style: TextStyle(
                                color: isExpanded ? Colors.white : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: isExpanded ? Colors.white : Colors.white,
                            size: 26,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded && _faqs[i]['answer']!.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        _faqs[i]['answer']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
  


