import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/authentication_button.dart';

class NotificationPerRequestScreen extends StatelessWidget {
  const NotificationPerRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                margin: const EdgeInsets.only(top: 31, bottom: 32, left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 0.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: AppColors.whiteColor,
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
                      Assets.photoBg,
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
                    color: AppColors.whiteColor,
                  ),
                  child: Center(
                    child: Image.asset(
                      Assets.notify,
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
                AppStrings.allowLocation,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: AppColors.whiteColor,
                ),
              ),
            ).paddingOnly(top: 65),
            const Text(
              AppStrings.allowNotificationSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(top: 20, left: 37, right: 38),
            const AuthenticateButton(
              image: "",
              textColor: AppColors.blackTextColor,
              color: AppColors.whiteColor,
              name: AppStrings.allowNotification,
            ).paddingOnly(top: 116, bottom: 38, left: 24, right: 24),
          ],
        ),
      ),
    );
  }
}
