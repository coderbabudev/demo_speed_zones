import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/get_started_screen.dart';
import 'package:demo_speed_zones/src/widget/animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAll(() => const GetStartedScreen());
    });
  }

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
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Column(
                children: [
                  Image.asset(
                    Assets.splashLogo,
                    height: 120,
                    width: 120,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    AppStrings.appText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 32,
                      height: 2.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 170),
              const Column(
                children: [
                  Text(
                    AppStrings.splashText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  )
                ],
              ).paddingOnly(bottom: 40),
            ],
          ),
        ),
      ),
    );
  }
}
