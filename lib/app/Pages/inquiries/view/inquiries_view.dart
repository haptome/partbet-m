import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partbet/app/core/config/app_color.dart';
import 'package:partbet/app/shared/widgets/auth_background.dart';

import 'inquiries_see_all_view.dart';

class InquiriesView extends StatelessWidget {
  InquiriesView({super.key});

  final List<Map<String, dynamic>> inquiries = [
    {
      'id': '2345',
      'title': 'Inquiry #2345',
      'desc': 'Brake Pads • Toyota Corolla 2015',
      'status': 'Pending',
      'price': '2500 Birr',
    },
    {
      'id': '1024',
      'title': 'Inquiry #1024',
      'desc': 'Alternator • Nissan Sunny 2018',
      'status': 'Available',
      'price': '7830 Birr',
    },
    {
      'id': '8351',
      'title': 'Inquiry #8351',
      'desc': 'Oil Filter • Toyota Vitz 2010',
      'status': 'Unavailable',
      'price': '—',
    },
    {
      'id': '6281',
      'title': 'Inquiry #6281',
      'desc': 'Fuel Pump • Honda Civic 2012',
      'status': 'Available',
      'price': '3400 Birr',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'My Inquiries',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: inquiries.length,
                    itemBuilder: (context, index) {
                      final inquiry = inquiries[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/inquiry-details', arguments: inquiry);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: _inquiryCard(inquiry),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InquiriesSeeAllView(inquiries: inquiries),
                      ),
                    );
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color bg;
    switch (status.toLowerCase()) {
      case 'available':
        bg = Colors.green;
        break;
      case 'unavailable':
        bg = Colors.redAccent;
        break;
      case 'pending':
        bg = const Color(0xFFCE6E00);
        break;
      default:
        bg = const Color(0xFFCE6E00);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }

  Widget _inquiryCard(Map<String, dynamic> q) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF3E2A15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.transparent),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(q['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(width: 6),
                _statusChip(q['status'] as String),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              q['desc'] as String,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(q['price'] as String, style: const TextStyle(color: Color(0xFFB86B1F), fontWeight: FontWeight.w700)),
                q['status'] == 'Available' ? Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(color: const Color(0xFFB86B1F), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
                ) : const SizedBox(),
              ],
            ),
          ],
        ),
      );
}