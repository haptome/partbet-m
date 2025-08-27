
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:partbet/app/core/config/app_color.dart';
import '../../../shared/widgets/auth_background.dart';
import '../../../shared/widgets/general_app_bar.dart';
import '../../../shared/widgets/custom_switch.dart';



class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: GeneralAppBar(
        title: 'Notification',
        showBackButton: true,
      
      ),
      body: AuthBackground(
        padding: 0,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            child: NotificationSettingsContent(),
          ),
        ),
      ),
    );
  }
}
// Notification Settings Content Widget
class NotificationSettingsContent extends StatefulWidget {
  @override
  State<NotificationSettingsContent> createState() => _NotificationSettingsContentState();
}

class _NotificationSettingsContentState extends State<NotificationSettingsContent> {
  // Toggle states
  bool enableAllNotifications = false;
  bool pushNotifications = false;
  bool inAppNotification = true;
  bool inquiryUpdates = true;
  bool orderUpdates = true;
  bool settingAndSupport = false;
  bool deliveryAndTracking = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First container - General notification settings
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Enable All Notifications
                _buildToggleRow(
                  title: 'Enable All Notifications',
                  subtitle: 'Turn all notifications on or off.',
                  value: enableAllNotifications,
                  onChanged: (value) {
                    setState(() {
                      enableAllNotifications = value;
                      // Update all other toggles to match
                      if (value) {
                        pushNotifications = true;
                        inAppNotification = true;
                        inquiryUpdates = true;
                        orderUpdates = true;
                        settingAndSupport = true;
                        deliveryAndTracking = true;
                      } else {
                        pushNotifications = false;
                        inAppNotification = false;
                        inquiryUpdates = false;
                        orderUpdates = false;
                        settingAndSupport = false;
                        deliveryAndTracking = false;
                      }
                    });
                  },
                ),
                const SizedBox(height: 8),
                Divider(color: AppColors.divider,),
                const SizedBox(height: 8),
                // Push Notifications
                _buildToggleRow(
                  title: 'Push Notifications',
                  value: pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      pushNotifications = value;
                      _updateAllNotificationsState();
                    });
                  },
                ),
                 const SizedBox(height: 8),
                Divider(color: AppColors.divider,),
                const SizedBox(height: 8),

                // In-App Notification
                _buildToggleRow(
                  title: 'In-App Notification',
                  value: inAppNotification,
                  onChanged: (value) {
                    setState(() {
                      inAppNotification = value;
                      _updateAllNotificationsState();
                    });
                  },
                  activeColor: const Color(0xFFFF9500),
                ),
                const SizedBox(height: 16),

              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Second container - Manage Notifications
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Manage Notifications header
                const Text(
                  'Manage Notifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                 const SizedBox(height: 20),
               
                
                // Inquiry Updates
                _buildToggleRow(
                  title: 'Inquiry Updates',
                  subtitle: 'Be notified when the status of your out-of-stock availability inquiry changes.',
                  value: inquiryUpdates,
                  onChanged: (value) {
                    setState(() {
                      inquiryUpdates = value;
                      _updateAllNotificationsState();
                    });
                  },
                  activeColor: const Color(0xFFFF9500),
                ),
                 const SizedBox(height: 8),
                Divider(color: AppColors.divider,),
                const SizedBox(height: 8),
                
                // Order Updates
                _buildToggleRow(
                  title: 'Order Updates',
                  subtitle: 'Get updates about your order status from confirmation to delivery.',
                  value: orderUpdates,
                  onChanged: (value) {
                    setState(() {
                      orderUpdates = value;
                      _updateAllNotificationsState();
                    });
                  },
                  activeColor: const Color(0xFFFF9500),
                ),
                 const SizedBox(height: 8),
                Divider(color: AppColors.divider,),
                const SizedBox(height: 8),
                
                // Setting And Support
                _buildToggleRow(
                  title: 'Setting And Support',
                  subtitle: 'Receive messages from our team about your activity.',
                  value: settingAndSupport,
                  onChanged: (value) {
                    setState(() {
                      settingAndSupport = value;
                      _updateAllNotificationsState();
                    });
                  },
                ),
                const SizedBox(height: 8),
                Divider(color: AppColors.divider,),
                const SizedBox(height: 8),
                
                // Delivery & Tracking
                _buildToggleRow(
                  title: 'Delivery & Tracking',
                  subtitle: 'Get notified when your order is on the way or delivered.',
                  value: deliveryAndTracking,
                  onChanged: (value) {
                    setState(() {
                      deliveryAndTracking = value;
                      _updateAllNotificationsState();
                    });
                  },
                  activeColor: const Color(0xFFFF9500),
                ),
                const SizedBox(height: 16),

              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to update the state of enableAllNotifications
  void _updateAllNotificationsState() {
    if (pushNotifications && inAppNotification && inquiryUpdates && 
        orderUpdates && settingAndSupport && deliveryAndTracking) {
      enableAllNotifications = true;
    } else {
      enableAllNotifications = false;
    }
  }

  // Helper method to build toggle row
  Widget _buildToggleRow({
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color activeColor = const Color(0xFFFF9500),
  }) {
    return Row(
      crossAxisAlignment: subtitle != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                    ),
                  ),
                ),
            ],
          ),
        ),
        CustomSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          inactiveColor: Colors.white,
        ),
      ],
    );
  }
}
  


