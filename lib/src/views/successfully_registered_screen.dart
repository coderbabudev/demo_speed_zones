import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/utils/util.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessFullyRegisteredScreen extends StatefulWidget {
  const SuccessFullyRegisteredScreen({super.key});

  @override
  State<SuccessFullyRegisteredScreen> createState() =>
      _SuccessFullyRegisteredScreenState();
}

class _SuccessFullyRegisteredScreenState
    extends State<SuccessFullyRegisteredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: backButton(icon: Icons.close, onTap: () {})),
            const Text(
              AppStrings.success,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textBlackColor,
                letterSpacing: 0.3,
              ),
            ).paddingOnly(left: 24),
            const Text(
              AppStrings.successSubText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColor,
              ),
            ).paddingOnly(top: 17, left: 24, right: 39),
            Center(
              child: Image.asset(
                Assets.successImage,
                height: 225,
                width: 225,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ).paddingOnly(top: 79),
            Image.asset(
              Assets.logoWithName,
              height: 50,
              width: 135,
              filterQuality: FilterQuality.high,
            ).paddingOnly(top: 20, left: 90),
            Spacer(),
            const AuthenticateButton(
              color: AppColors.primaryColor,
              name: 'Homepage',
              textColor: AppColors.whiteColor,
              image: '',
            )
          ],
        ).paddingAll(20),
      ),
    );
  }
}
