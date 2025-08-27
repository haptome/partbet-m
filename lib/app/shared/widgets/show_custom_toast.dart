import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

bool isToastActive = false;

void showCustomToast({
  String title = 'Hello, World!',
  ToastificationType type = ToastificationType.success,
  Duration autoCloseDuration = const Duration(seconds: 3),
  bool showButton = false,
}) {
  Color backgroundColor;
  Color foregroundColor;
  Icon icon;
  switch (type) {
    case ToastificationType.success:
      backgroundColor = Colors.white;
      foregroundColor = const Color(0xff161F28);
      icon = const Icon(Icons.check_circle, color: Colors.green);
      break;
    case ToastificationType.error:
      backgroundColor = Colors.white;
      foregroundColor = const Color(0xffD01818);
      icon = const Icon(Icons.close, color: Color(0xffD01818));
      break;
    default:
      backgroundColor = Colors.white;
      foregroundColor = const Color(0xff161F28);
      icon = const Icon(Icons.check_box, color: Colors.green);
  }

  if (isToastActive) return;

  isToastActive = true;

  toastification.show(
    alignment: Alignment.topCenter,
    type: type,
    style: ToastificationStyle.flat,
    autoCloseDuration: autoCloseDuration,
    description: showButton
        ? Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () => {
                 
                  openAppSettings(),
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove padding
                ),
                child: Text(
                  'open settings',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        : Text(
            title,
            style:
                TextStyle(color: foregroundColor, fontWeight: FontWeight.w500),
          ),
    // alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    icon: icon,
    showIcon: true,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    padding: const EdgeInsets.only(left: 12, right: 0, top: 16, bottom: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    showProgressBar: false,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: false,
    callbacks: ToastificationCallbacks(
      onAutoCompleteCompleted: (toastItem) {
        isToastActive = false;
      },
      onDismissed: (toastItem) {
        isToastActive = false;
      },
    ),
  );
}
