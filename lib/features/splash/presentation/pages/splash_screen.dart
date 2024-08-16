import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/auth_controller.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:demo_speed_zones/features/get_started/presentation/pages/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    User? user = authController.auth.currentUser; //

    if (user != null) {
      DocumentSnapshot userDoc = await authController.firebaseDb
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        Get.offAll(() => const DashboardScreen());
      } else {
        await authController.auth.signOut();
        Get.offAll(() => const GetStartedScreen());
      }
    } else {
      Get.offAll(() => const GetStartedScreen());
    }
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
              image: AssetImage(ImageConstant.splashLayers),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const SizedBox(),
              Column(
                children: [
                  Image.asset(
                    IconConstant.splashLogo,
                    height: 120,
                    width: 120,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    StringConstant.appText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.whiteColor,
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
                    StringConstant.splashText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    color: ColorConstant.whiteColor,
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
