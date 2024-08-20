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
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 20, top: 20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorConstant.secondaryColor,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 20,
                color: ColorConstant.blackColor,
              ),
            ),
          ),
        ),
        titleSpacing: 35,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Obx(() => AuthTextField(
                  controller: authController.oldPasswordController,
                  hintText: StringConstant.oldPassword,
                  suffixIcon: authController.showOldPassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  prefixIcon: IconConstant.enablePassword,
                  suffixOnPress: () => authController.showHideOLDPassword(),
                  obscureText:
                      authController.showOldPassword.value ? false : true,
                ).paddingOnly(top: 48)),
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
            }).paddingOnly(top: 32),
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
              onPress: () => authController.resetPassword(),
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
