import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.textColor,
    required this.bgColor,
  });

  final Color bgColor;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: bgColor,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
