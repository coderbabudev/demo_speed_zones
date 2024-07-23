import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:demo_speed_zones/src/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondaryColor,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
            const Text(
              AppStrings.newPassword,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ).paddingOnly(top: 32),
            const Text(
              AppStrings.newPasswordSubText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColor,
              ),
            ).paddingOnly(top: 17),
            AuthTextField(
              controller: TextEditingController(),
              hintText: AppStrings.newPassword,
              suffixIcon: Icons.visibility_outlined,
              prefixIcon: Assets.enablePassword,
              suffixOnPress: () {},
              obscureText: true,
            ).paddingOnly(top: 48),
            AuthTextField(
              controller: TextEditingController(),
              hintText: AppStrings.confirmPassword,
              suffixIcon: Icons.visibility_outlined,
              prefixIcon: Assets.enablePassword,
              suffixOnPress: () {},
              obscureText: true,
            ).paddingOnly(top: 32),
            const Spacer(),
            AuthenticateButton(
              name: AppStrings.resetPassword,
              onPress: () {},
              image: '',
              color: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ).paddingOnly(top: 48),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
