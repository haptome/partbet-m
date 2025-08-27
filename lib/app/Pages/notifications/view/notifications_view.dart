import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'inquiry',
      'title': 'Inquiry updates',
      'date': 'July 12, 2025',
      'message': 'Good news! The part you requested (Alternator – Toyota Yaris) is now available.',
    },
    {
      'type': 'security',
      'title': 'Security Alert',
      'date': 'July 12, 2025',
      'message': 'We noticed a new login to your account from a device or location that you haven’t used before.',
    },
    {
      'type': 'order',
      'title': 'New order submitted',
      'date': 'July 12, 2025',
      'message': 'Your order #A1024 has been received.',
    },
    {
      'type': 'payment',
      'title': 'Payment Confirmed!',
      'date': 'July 12, 2025',
      'message': 'Your payment for Order #A1092 has been successfully received.',
    },
    {
      'type': 'delivery',
      'title': 'Delivery Complete',
      'date': 'July 12, 2025',
      'message': 'Order #A1024 was delivered to your garage.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: const GeneralAppBar(
        title: 'Notifications',
        showBackButton: true,
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final n = notifications[index];
              return _notificationTile(context, n);
            },
          ),
        ),
      ),
    );
  }

  Widget _notificationTile(BuildContext context, Map<String, dynamic> n) {
    final _TypeIcon ti = _typeIcon(n['type'] as String);
    return GestureDetector(
      onTap: () => _openDetail(context, n),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: ti.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(ti.icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(n['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      Text(n['date'] as String, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    n['message'] as String,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context, Map<String, dynamic> n) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        final size = MediaQuery.of(context).size;
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    width: size.width,
                    height: size.height,
                    color: Colors.white.withOpacity(0.08),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: _actionButton(icon: Icons.close, onTap: () => Get.back<void>()),
                        ),
                        const SizedBox(height: 8),
                        Text(n['date'] as String, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 8),
                        Text(n['title'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(n['message'] as String, style: const TextStyle(color: Colors.white70)),
                        const Spacer(),
                        _buildCTA(n['type'] as String),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton({required IconData icon, required VoidCallback onTap}) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      );

  Widget _buildCTA(String type) {
    String label = 'OK';
    VoidCallback onTap = () => Get.back<void>();
    switch (type) {
      case 'inquiry':
        label = 'View Part';
        break;
      case 'payment':
        label = 'Track Order';
        break;
      case 'delivery':
        label = 'Rate Delivery';
        break;
      default:
        label = 'OK';
    }
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _TypeIcon {
  final IconData icon;
  final Color backgroundColor;
  const _TypeIcon(this.icon, this.backgroundColor);
}

_TypeIcon _typeIcon(String type) {
  switch (type) {
    case 'inquiry':
      return _TypeIcon(Icons.search, const Color(0xFF2E8B8B));
    case 'security':
      return _TypeIcon(Icons.security, const Color(0xFFE05252));
    case 'order':
      return _TypeIcon(Icons.shopping_bag_outlined, AppColors.primary);
    case 'payment':
      return _TypeIcon(Icons.check_circle, Colors.green);
    case 'delivery':
      return _TypeIcon(Icons.local_shipping_outlined, Colors.blueGrey);
    default:
      return _TypeIcon(Icons.notifications, AppColors.primary);
  }
}
