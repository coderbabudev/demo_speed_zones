import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/join_circle_invite_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinCircleSplashScreen extends StatefulWidget {
  const JoinCircleSplashScreen({super.key});

  @override
  State<JoinCircleSplashScreen> createState() => _JoinCircleSplashScreenState();
}

class _JoinCircleSplashScreenState extends State<JoinCircleSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimationWidget(
        animationType: "FADE",
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstant.splashLayers),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Text(
                  "Hi Daniel Lawson! 👋",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.whiteColor,
                  ),
                ).paddingOnly(top: 16),
                const Text(
                  StringConstant.nowJoinCircle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.whiteColor,
                  ),
                ).paddingOnly(top: 13),
                Image.asset(
                  ImageConstant.groupCircle,
                  height: 251,
                  width: 240,
                  filterQuality: FilterQuality.high,
                ).paddingOnly(top: 55),
                const Spacer(),
                const Text(
                  StringConstant.nowJoinCircleSubText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.whiteColor,
                  ),
                ).paddingOnly(left: 37, right: 38),
                AuthenticateButton(
                  image: "",
                  onPress: () =>
                      Get.to(() => const JoinCircleInviteCodeScreen()),
                  textColor: ColorConstant.blackTextColor,
                  color: ColorConstant.whiteColor,
                  name: StringConstant.continueText,
                ).paddingOnly(top: 31, bottom: 38, left: 24, right: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
