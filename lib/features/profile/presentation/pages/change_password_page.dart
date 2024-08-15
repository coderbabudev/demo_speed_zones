import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final profileController = Get.find<ProfileController>();

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
                controller: profileController.oldPasswordController,
                hintText: StringConstant.oldPassword,
                suffixIcon: profileController.showOldPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => profileController.showHideOldPassword(),
                obscureText:
                    profileController.showOldPassword.value ? false : true,
              ).paddingOnly(top: 39)),
          Obx(() => AuthTextField(
                controller: profileController.newPasswordController,
                hintText: StringConstant.newPassword,
                suffixIcon: profileController.showNewPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () => profileController.showHideNewPassword(),
                obscureText:
                    profileController.showNewPassword.value ? false : true,
              ).paddingOnly(top: 32)),
          Obx(() => AuthTextField(
                controller: profileController.confirmPasswordController,
                hintText: StringConstant.confirmPassword,
                suffixIcon: profileController.showConfirmPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: IconConstant.enablePassword,
                suffixOnPress: () =>
                    profileController.showHideConfirmPassword(),
                obscureText:
                    profileController.showConfirmPassword.value ? false : true,
              ).paddingOnly(top: 32)),
          const Spacer(),
          Obx(() {
            return AuthenticateButton(
              name: StringConstant.changePassword,
              isLoader: profileController.isLoading.value,
              onPress: () => profileController.changePassword(),
              image: '',
              color: ColorConstant.primaryColor,
              textColor: ColorConstant.whiteColor,
            );
          }).paddingOnly(bottom: 30),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
