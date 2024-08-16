import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/auth_controller.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    const passwordPattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$';

    final passwordRegex = RegExp(passwordPattern);
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Column(
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
            Obx(() {
              return AuthTextField(
                controller: authController.newPasswordController,
                hintText: StringConstant.newPassword,
                textInputAction: TextInputAction.next,
                suffixIcon: authController.showNewPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => authController.showHideNewPassword(),
                obscureText:
                    authController.showNewPassword.value ? false : true,
              );
            }).paddingOnly(top: 48),
            Obx(() {
              return AuthTextField(
                controller: authController.confirmPasswordController,
                hintText: StringConstant.confirmPassword,
                textInputAction: TextInputAction.done,
                suffixIcon: authController.showConfirmPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => authController.showHideConfirmPassword(),
                obscureText:
                    authController.showConfirmPassword.value ? false : true,
              );
            }).paddingOnly(top: 32),
            const Spacer(),
            AuthenticateButton(
              name: StringConstant.resetPassword,
              onPress: () {
                if (authController.newPasswordController.text.isNotEmpty &&
                    authController.confirmPasswordController.text.isNotEmpty &&
                    passwordRegex
                        .hasMatch(authController.newPasswordController.text) &&
                    passwordRegex.hasMatch(
                        authController.confirmPasswordController.text) &&
                    (authController.confirmPasswordController.text ==
                        authController.newPasswordController.text) &&
                    (authController.newPasswordController.text.length > 6 ||
                        authController.confirmPasswordController.text.length >
                            6)) {
                } else {
                  if (authController.newPasswordController.text.isEmpty) {
                    showMessageSnackBar(
                        StringConstant.newPasswordFieldIsRequired);
                  } else if (authController
                      .confirmPasswordController.text.isEmpty) {
                    showMessageSnackBar(
                        StringConstant.confirmPasswordFieldIsRequired);
                  } else if (authController.confirmPasswordController.text !=
                      authController.newPasswordController.text) {
                    showMessageSnackBar(
                        StringConstant.confirmPasswordDoesNotMatch);
                  } else if (authController
                              .confirmPasswordController.text.length <=
                          6 ||
                      authController.newPasswordController.text.length <= 6) {
                    showMessageSnackBar(
                        StringConstant.passwordMustBeLongerThan6Characters);
                  } else if (!passwordRegex.hasMatch(
                          authController.newPasswordController.text) ||
                      !passwordRegex.hasMatch(
                          authController.confirmPasswordController.text)) {
                    showMessageSnackBar(StringConstant.weakPassword);
                  }
                }
              },
              image: '',
              color: ColorConstant.primaryColor,
              textColor: ColorConstant.whiteColor,
            ).paddingOnly(top: 48),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
