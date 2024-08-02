import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/login_register_screen.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Column(
        children: [
          Image.asset(
            IconConstant.logoWithName,
            fit: BoxFit.cover,
            height: 80,
            width: 205,
          ).paddingOnly(top: 50),
          const Text(
            StringConstant.letsGetStarted,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: ColorConstant.textBlackColor,
            ),
          ).paddingOnly(top: 60),
          const Text(
            StringConstant.getStartedInfo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorConstant.secondaryColor,
            ),
          ).paddingOnly(top: 30),
          Column(
            children: [
              AuthenticateButton(
                image: IconConstant.emailLogo,
                name: StringConstant.signUpEmail,
                color: ColorConstant.lightGreyColor,
                textColor: ColorConstant.blackColor,
                onPress: () {
                  controller.whichFrom.value = true;
                  Get.to(() => LoginAndRegisterScreen(
                      isWhichFrom: controller.whichFrom.value));
                },
              ),
              const SizedBox(height: 24),
              // const Text(
              //   StringConstant.instantSignUp,
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: ColorConstant.secondaryColor,
              //     fontWeight: FontWeight.normal,
              //   ),
              // )
            ],
          ).paddingOnly(top: 20),
          // AuthenticateButton(
          //   image: Assets.googleLogo,
          //   name: StringConstant.signUpGoogle,
          //   color: ColorConstant.primaryColor,
          //   onPress: () {},
          // ),
          // AuthenticateButton(
          //   image: IconConstant.appleLogo,
          //   name: StringConstant.signUpApple,
          //   color: ColorConstant.blackColor,
          //   onPress: () {},
          // ),
          // AuthenticateButton(
          //   image: IconConstant.facebookLogo,
          //   name: StringConstant.signUpFacebook,
          //   color: const Color(0xFF1773EA),
          //   onPress: () {},
          // ),
          // const Spacer(),
          RichText(
            text: TextSpan(
              text: StringConstant.alreadyHaveAccount,
              style: const TextStyle(
                color: ColorConstant.secondaryColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: StringConstant.signIn,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.to(
                        () => const LoginAndRegisterScreen(),
                      );
                    },
                  style: const TextStyle(
                    color: ColorConstant.primaryColor,
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
