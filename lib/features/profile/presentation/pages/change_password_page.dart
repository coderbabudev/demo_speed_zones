import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changePasswordController = Get.find<ChangePasswordController>();

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
        title: const Text(
          StringConstant.changePassword,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstant.blackTextColor),
        ).paddingOnly(top: 20),
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              StringConstant.changePasswordSubText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorConstant.secondaryColor,
              ),
            ),
          ).paddingOnly(top: 18),
          Obx(() => AuthTextField(
                controller: changePasswordController.oldPasswordController,
                hintText: StringConstant.oldPassword,
                suffixIcon: changePasswordController.showOldPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () =>
                    changePasswordController.showHideOldPassword(),
                obscureText: changePasswordController.showOldPassword.value
                    ? false
                    : true,
              ).paddingOnly(top: 39)),
          Obx(() => AuthTextField(
                controller: changePasswordController.newPasswordController,
                hintText: StringConstant.newPassword,
                suffixIcon: changePasswordController.showNewPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () =>
                    changePasswordController.showHideNewPassword(),
                obscureText: changePasswordController.showNewPassword.value
                    ? false
                    : true,
              ).paddingOnly(top: 32)),
          Obx(() => AuthTextField(
                controller: changePasswordController.confirmPasswordController,
                hintText: StringConstant.confirmPassword,
                suffixIcon: changePasswordController.showConfirmPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () =>
                    changePasswordController.showHideConfirmPassword(),
                obscureText: changePasswordController.showConfirmPassword.value
                    ? false
                    : true,
              ).paddingOnly(top: 32)),
          const Spacer(),
          AuthenticateButton(
            name: StringConstant.changePassword,
            onPress: () {},
            image: '',
            color: ColorConstant.primaryColor,
            textColor: ColorConstant.whiteColor,
          ).paddingOnly(bottom: 30),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
