import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/presentation/widget/authentication_button.dart';

class NotificationPerRequestScreen extends StatelessWidget {
  const NotificationPerRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> requestLocationPermission() async {
      final status = await Permission.location.request();
      if (status.isGranted) {
        Get.offAll(() => const DashboardScreen());
      } else if (status.isDenied) {
        showMessageSnackBar('Location permission is Denied');
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(top: 16, bottom: 32, left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.whiteColor,
                    width: 0.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: ColorConstant.whiteColor,
                  ),
                ),
              ),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image.asset(
                      ImageConstant.photoBg,
                      height: 200,
                      width: 207,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(
                  height: 132,
                  width: 132,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.whiteColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      IconConstant.notify,
                      height: 72,
                      width: 72,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Center(
              child: Text(
                StringConstant.allowLocation,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: ColorConstant.whiteColor,
                ),
              ),
            ).paddingOnly(top: 65),
            const Text(
              StringConstant.allowNotificationSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(top: 20, left: 37, right: 38),
            AuthenticateButton(
              image: "",
              textColor: ColorConstant.blackTextColor,
              onPress: () {
                requestLocationPermission().then((value) {
                  Get.offAll(() => const DashboardScreen());
                });
              },
              color: ColorConstant.whiteColor,
              name: StringConstant.allowNotification,
            ).paddingOnly(top: 116, bottom: 38, left: 24, right: 24),
          ],
        ),
      ),
    );
  }
}
