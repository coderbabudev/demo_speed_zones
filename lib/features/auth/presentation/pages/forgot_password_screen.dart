import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/new_password_screen.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
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
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(onTap: () => Get.back()),
            const Text(
              StringConstant.forgetPassword,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: ColorConstant.blackColor,
              ),
            ),
            const Text(
              StringConstant.forgotSubText,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstant.secondaryColor,
              ),
            ).paddingOnly(top: 17),
            AuthTextField(
              controller: TextEditingController(),
              hintText: StringConstant.inputEmail,
              prefixIcon: IconConstant.enableEmail,
            ).paddingOnly(top: 48),
            const Spacer(),
            AuthenticateButton(
              name: StringConstant.submit,
              onPress: () {
                Get.to(() => const NewPasswordScreen());
              },
              image: '',
              color: ColorConstant.primaryColor,
              textColor: ColorConstant.whiteColor,
            ),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
