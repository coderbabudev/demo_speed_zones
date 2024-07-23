import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.suffixIcon,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixOnPress,
    this.validator,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final bool obscureText;
  final void Function()? suffixOnPress;
  final String Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isTextFieldEmpty = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTextFieldState);
  }

  void _updateTextFieldState() {
    setState(() {
      isTextFieldEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscureText ? true : false,
      obscuringCharacter: '●',
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: AppColors.blackColor,
      ),
      cursorColor: AppColors.blackColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.secondaryColor,
        ),
        filled: true,
        fillColor: AppColors.lightGreyColor,
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 50,
        ),
        prefixIcon: Opacity(
          opacity: isTextFieldEmpty ? 0.5 : 1.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Image.asset(
              widget.prefixIcon,
              height: 24,
              width: 24,
            ),
          ),
        ),
        suffixIcon: widget.suffixIcon != null
            ? GestureDetector(
                onTap: widget.suffixOnPress,
                child: Icon(
                  widget.suffixIcon,
                  size: 24,
                  color: AppColors.secondaryColor,
                ),
              )
            : null,
        errorMaxLines: 1,
        errorStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.redColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
