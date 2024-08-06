import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({
    super.key,
    this.border,
    this.gradient,
    this.icon,
    this.title,
    this.iconColor,
    this.textColor,
  });

  final BoxBorder? border;
  final Gradient? gradient;
  final String? icon;
  final String? title;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        gradient: gradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon ?? '',
            height: 20,
            width: 20,
            filterQuality: FilterQuality.high,
            color: iconColor,
          ),
          const SizedBox(height: 8),
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          )
        ],
      ),
    );
  }
}
