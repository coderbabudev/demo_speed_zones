import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/new_password_controller.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
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
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: GetBuilder<NewPasswordController>(builder: (newPassValue) {
          newPassValue = newPasswordController;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(onTap: () => Get.back()),
              const Text(
                StringConstant.newPassword,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.blackColor,
                ),
              ),
              const Text(
                StringConstant.newPasswordSubText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.secondaryColor,
                ),
              ).paddingOnly(top: 17),
              AuthTextField(
                controller: newPassValue.newPasswordController,
                hintText: StringConstant.newPassword,
                suffixIcon: newPassValue.showNewPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => newPassValue.showHideNewPassword(),
                obscureText: newPassValue.showNewPassword.value ? false : true,
              ).paddingOnly(top: 48),
              AuthTextField(
                controller: newPassValue.confirmPasswordController,
                hintText: StringConstant.confirmPassword,
                suffixIcon: newPassValue.showConfirmPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => newPassValue.showHideConfirmPassword(),
                obscureText:
                    newPassValue.showConfirmPassword.value ? false : true,
              ).paddingOnly(top: 32),
              const Spacer(),
              AuthenticateButton(
                name: StringConstant.resetPassword,
                onPress: () {},
                image: '',
                color: ColorConstant.primaryColor,
                textColor: ColorConstant.whiteColor,
              ).paddingOnly(top: 48),
            ],
          ).paddingAll(20);
        }),
      ),
    );
  }
}
