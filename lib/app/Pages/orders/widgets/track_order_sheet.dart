import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_assets.dart';

class TrackOrderSheet extends StatelessWidget {
  const TrackOrderSheet({Key? key}) : super(key: key);

  final List<String> steps = const [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered'
  ];

  @override
  Widget build(BuildContext context) {
    final currentStep = 1; // 0-based: Pending (0), Processing (1)...

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF23201E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text(
              "Track Order",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            const Text(
              "Track your order in real time",
              style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 28),
            SizedBox(
              height: 80,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  // Draw connectors
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 18,
                    child: Row(
                      children: List.generate(steps.length - 1, (i) {
                        Color color;
                        if (i == 0) {
                          color = const Color(0xFFFF9900).withOpacity(0.5);
                        } else if (i == 1) {
                          color = Colors.white24;
                        } else {
                          color = Colors.white24;
                        }

                        // Custom painter for dashed circle

                        return Expanded(
                          child: Container(
                            height: 2,
                            color: color,
                          ),
                        );
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(steps.length, (index) {
                      Widget stepIcon;
                      BoxDecoration decoration;
                      if (index == 0) {
                        // Pending: solid orange with white check
                        decoration = BoxDecoration(
                          color: const Color(0xFFFF9900),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF9900).withOpacity(0.3),
                              blurRadius: 16,
                              spreadRadius: 2,
                            ),
                          ],
                        );
                        stepIcon = const Icon(Icons.check,
                            color: Colors.white, size: 28);
                        return Column(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: decoration,
                              child: Center(child: stepIcon),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              steps[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      } else if (index == 1) {
                        // Processing: dashed orange border, truck icon
                        return Column(
                          children: [
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: CustomPaint(
                                painter: _DashedCirclePainter(
                                    color: const Color(0xFFFF9900),
                                    dashCount: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                                                AppAssets.delivery,
                                                                width: 10,
                                                                height: 10,
                                                                // colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                                              ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              steps[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Others: gray circle
                        decoration = BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(24),
                        );
                        stepIcon = const Icon(Icons.circle,
                            color: Colors.white24, size: 24);
                        return Column(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: decoration,
                              child: Center(child: stepIcon),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              steps[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C).withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text("Cancel Order",
                    style: TextStyle(
                        color: const Color(0xFFB71C1C),
                        fontWeight: FontWeight.w500,
                        fontSize: 14)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _DashedCirclePainter extends CustomPainter {
  final Color color;
  final int dashCount;

  _DashedCirclePainter({required this.color, this.dashCount = 12});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final double radius = (size.width / 2) - 3;
    final double dashLength = 6;
    final double gapLength = 6;
    final double totalLength = 2 * 3.141592653589793 * radius;
    final double dashAngle = (dashLength / totalLength) * 2 * 3.141592653589793;
    final double gapAngle = (gapLength / totalLength) * 2 * 3.141592653589793;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * (dashAngle + gapAngle);
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2), radius: radius),
        startAngle,
        dashAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
