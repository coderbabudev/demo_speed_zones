import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/controller/auth_controller/new_password_controller.dart';
import 'package:demo_speed_zones/src/utils/util.dart';
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
  NewPasswordController newPasswordController =
      Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<NewPasswordController>(builder: (newPassValue) {
          newPassValue = newPasswordController;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(onTap: () => Get.back()),
              const Text(
                AppStrings.newPassword,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
              const Text(
                AppStrings.newPasswordSubText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryColor,
                ),
              ).paddingOnly(top: 17),
              AuthTextField(
                controller: newPassValue.newPasswordController,
                hintText: AppStrings.newPassword,
                suffixIcon: newPassValue.showNewPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: Assets.enablePassword,
                suffixOnPress: () => newPassValue.showHideNewPassword(),
                obscureText: newPassValue.showNewPassword.value ? false : true,
              ).paddingOnly(top: 48),
              AuthTextField(
                controller: newPassValue.confirmPasswordController,
                hintText: AppStrings.confirmPassword,
                suffixIcon: newPassValue.showConfirmPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: Assets.enablePassword,
                suffixOnPress: () => newPassValue.showHideConfirmPassword(),
                obscureText:
                    newPassValue.showConfirmPassword.value ? false : true,
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
          ).paddingAll(20);
        }),
      ),
    );
  }
}
