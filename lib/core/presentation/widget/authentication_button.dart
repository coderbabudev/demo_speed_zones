import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AuthenticateButton extends StatelessWidget {
  const AuthenticateButton(
      {super.key,
      this.color,
      this.textColor,
      this.name,
      this.image,
      this.onPress,
      this.isShadow = false,
      this.isLoader = false,
      this.isLoaderColor});

  final Color? color;
  final Color? textColor;
  final String? name;
  final String? image;
  final bool isShadow;
  final void Function()? onPress;
  final bool isLoader;
  final Color? isLoaderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 56,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 23),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          boxShadow: [
            if (isShadow)
              BoxShadow(
                color: const Color(0xFFA7A9B7).withOpacity(0.30),
                blurRadius: 40,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Center(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (image!.isNotEmpty)
                Image.asset(
                  image ?? '',
                  filterQuality: FilterQuality.high,
                  height: 24,
                  width: 24,
                ),
              const SizedBox(width: 8),
              isLoader
                  ? CircularProgressIndicator(
                      color: isLoaderColor ?? ColorConstant.whiteColor,
                    )
                  : Text(
                      name ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor ?? ColorConstant.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
