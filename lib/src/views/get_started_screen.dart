import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/login_register_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            Assets.logoWithName,
            fit: BoxFit.cover,
            height: 80,
            width: 205,
          ).paddingOnly(top: 50),
          const Text(
            AppStrings.letsGetStarted,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: AppColors.textBlackColor,
            ),
          ).paddingOnly(top: 60),
          const Text(
            AppStrings.getStartedInfo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryColor,
            ),
          ).paddingOnly(top: 30),
          Column(
            children: [
              AuthenticateButton(
                image: Assets.emailLogo,
                name: AppStrings.signUpEmail,
                color: AppColors.lightGreyColor,
                textColor: AppColors.blackColor,
                onPress: () {
                  Get.to(() => const LoginAndRegisterScreen());
                },
              ),
              const SizedBox(height: 24),
              const Text(
                AppStrings.instantSignUp,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ).paddingOnly(top: 20),
          AuthenticateButton(
            image: Assets.googleLogo,
            name: AppStrings.signUpGoogle,
            color: AppColors.primaryColor,
            onPress: () {},
          ),
          AuthenticateButton(
            image: Assets.appleLogo,
            name: AppStrings.signUpApple,
            color: AppColors.blackColor,
            onPress: () {},
          ),
          AuthenticateButton(
            image: Assets.facebookLogo,
            name: AppStrings.signUpFacebook,
            color: const Color(0xFF1773EA),
            onPress: () {},
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              text: AppStrings.alreadyHaveAccount,
              style: const TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: AppStrings.signIn,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(
                        () => const LoginAndRegisterScreen(),
                      );
                    },
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ).paddingSymmetric(horizontal: 30, vertical: 20),
    );
  }
}
