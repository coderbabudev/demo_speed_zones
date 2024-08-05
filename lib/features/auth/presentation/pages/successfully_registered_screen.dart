import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/join_circle_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessFullyRegisteredScreen extends StatefulWidget {
  const SuccessFullyRegisteredScreen({super.key});

  @override
  State<SuccessFullyRegisteredScreen> createState() =>
      _SuccessFullyRegisteredScreenState();
}

class _SuccessFullyRegisteredScreenState
    extends State<SuccessFullyRegisteredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: AnimationWidget(
        animationType: "FADE",
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: backButton(
                  icon: Icons.close,
                  onTap: () {},
                ),
              ).paddingOnly(top: 20, right: 20),
              const Text(
                StringConstant.success,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.textBlackColor,
                  letterSpacing: 0.3,
                ),
              ).paddingOnly(left: 24),
              const Text(
                StringConstant.successSubText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.secondaryColor,
                ),
              ).paddingOnly(top: 17, left: 24, right: 39),
              Center(
                child: Image.asset(
                  ImageConstant.successImage,
                  height: 225,
                  width: 225,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ).paddingOnly(top: 79),
              Image.asset(
                IconConstant.logoWithName,
                height: 50,
                width: 135,
                filterQuality: FilterQuality.high,
              ).paddingOnly(top: 20, left: 120),
              const Spacer(),
              AuthenticateButton(
                color: ColorConstant.primaryColor,
                onPress: () => Get.to(() => const JoinCircleSplashScreen()),
                name: 'Homepage',
                textColor: ColorConstant.whiteColor,
                image: '',
              ).paddingOnly(left: 20, right: 20, bottom: 28)
            ],
          ),
        ),
      ),
    );
  }
}
