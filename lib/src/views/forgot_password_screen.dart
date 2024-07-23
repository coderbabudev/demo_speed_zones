import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/new_password_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:demo_speed_zones/src/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
              AppStrings.forgetPassword,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ).paddingOnly(top: 32),
            const Text(
              AppStrings.forgotSubText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColor,
              ),
            ).paddingOnly(top: 17),
            AuthTextField(
              controller: TextEditingController(),
              hintText: AppStrings.inputEmail,
              prefixIcon: Assets.enableEmail,
            ).paddingOnly(top: 48),
            const Spacer(),
            AuthenticateButton(
              name: AppStrings.submit,
              onPress: () {
                Get.to(() => const NewPasswordScreen());
              },
              image: '',
              color: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
