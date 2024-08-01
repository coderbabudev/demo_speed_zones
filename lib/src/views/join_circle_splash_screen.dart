import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/join_circle_invite_code_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/animation_widget.dart';

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
              image: AssetImage(Assets.splashLayers),
              filterQuality: FilterQuality.high,
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
                    color: AppColors.whiteColor,
                  ),
                ).paddingOnly(top: 31),
                const Text(
                  AppStrings.nowJoinCircle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ).paddingOnly(top: 13),
                Image.asset(
                  Assets.groupCircle,
                  height: 251,
                  width: 240,
                  filterQuality: FilterQuality.high,
                ).paddingOnly(top: 55),
                const Spacer(),
                const Text(
                  AppStrings.nowJoinCircleSubText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ).paddingOnly(left: 37, right: 38),
                AuthenticateButton(
                  image: "",
                  onPress: () =>
                      Get.to(() => const JoinCircleInviteCodeScreen()),
                  textColor: AppColors.blackTextColor,
                  color: AppColors.whiteColor,
                  name: AppStrings.continueText,
                ).paddingOnly(top: 31, bottom: 38, left: 24, right: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
