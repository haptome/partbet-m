import 'package:flutter/material.dart';
import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/config/app_color.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });
  final int selectedIndex;
  final void Function(int) onTap;

  @override
  State<AppBottomNav> createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> with SingleTickerProviderStateMixin {
  late int _oldIndex;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _oldIndex = widget.selectedIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    // Show indicator on initial tab
    if (widget.selectedIndex == 0) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant AppBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != _oldIndex) {
      _controller.forward(from: 0);
      _oldIndex = widget.selectedIndex;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _buildItem({
    required int index,
    required String iconPath,
    required String label,
  }) {
    final bool isSelected = widget.selectedIndex == index;
    return BottomNavigationBarItem(
      icon: SizedBox(
        width: 60,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // Animated indicator above the bar
            if (isSelected)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) => Positioned(
                    top: -16,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: _animation.value,
                      child: Container(
                        height: 20,
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 13 + 10 * _animation.value,
                          width: 10 + 24 * _animation.value,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: RadialGradient(
                              center: Alignment.topCenter,
                              radius: 0.8,
                              colors: [
                                AppColors.primary.withOpacity(0.7 * _animation.value),
                                AppColors.primary.withOpacity(0.4 * _animation.value),
                                AppColors.primary.withOpacity(0.2 * _animation.value),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.4,0.8, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.25 * _animation.value),
                                blurRadius: 12 * _animation.value,
                                offset: const Offset(0, 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.primary : AppColors.textBlack60,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: isSelected ? 12 : 10,
                    color: isSelected ? AppColors.primary : AppColors.textBlack60,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF232327), // Top color (dark)
              Color(0xFF151619), // Bottom color (darker)
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: widget.selectedIndex,
          onTap: (i) {
            if (i != widget.selectedIndex) {
              _controller.forward(from: 0);
            }
            widget.onTap(i);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textWhite100,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildItem(
              index: 0,
              iconPath: AppAssets.homeIcon,
              label: 'Home',
            ),
            _buildItem(
              index: 1,
              iconPath: AppAssets.parts,
              label: 'Parts',
            ),
            _buildItem(
              index: 2,
              iconPath: AppAssets.service,
              label: 'Service',
            ),
            _buildItem(
              index: 3,
              iconPath: AppAssets.order,
              label: 'Orders',
            ),
            _buildItem(
              index: 4,
              iconPath: AppAssets.profile,
              label: 'Profile',
            ),
          ],
        ),
      );
}
