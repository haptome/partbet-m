import 'package:flutter/material.dart';
import 'package:partbet/app/core/config/app_color.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final double width;
  final double height;
  final double switchHeight;
  final double switchWidth;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.activeTrackColor = const Color(0xFFFF9500),
    this.inactiveTrackColor = const Color(0xFF3A3A3C),
    this.width = 55.0,
    this.height = 31.0,
    this.switchHeight = 8.0,
    this.switchWidth = 8.0,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late Animation<Offset> _slideAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-12.0, 0.0),
      end: Offset(widget.width - widget.switchWidth - 34, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          color: widget.value ? widget.activeTrackColor : widget.inactiveTrackColor,
        ),
        padding: const EdgeInsets.all(2.0),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: _slideAnimation.value,
              child: Container(
                width: widget.switchWidth,
                height: widget.switchHeight,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.inactiveColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}