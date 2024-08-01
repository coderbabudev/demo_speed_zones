import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/share_invite_code_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

class GiveCircleNameScreen extends StatefulWidget {
  const GiveCircleNameScreen({super.key});

  @override
  State<GiveCircleNameScreen> createState() => _GiveCircleNameScreenState();
}

class _GiveCircleNameScreenState extends State<GiveCircleNameScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: const Text(
                AppStrings.giveCircleName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(top: 31),
            ),
            TextFormField(
              controller: nameController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.blackTextColor,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: AppColors.whiteColor,
                isDense: true,
                filled: true,
                hintText: 'Circle name',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColor,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none),
              ),
            ).paddingOnly(top: 80, left: 24, right: 24),
            const Text(
              AppStrings.tipText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(top: 50, left: 37, right: 38),
            const Spacer(),
            AuthenticateButton(
              image: "",
              textColor: AppColors.blackTextColor,
              onPress: () => Get.to(() => ShareInviteCodeScreen(
                    circleName: nameController.text,
                  )),
              color: AppColors.whiteColor,
              name: AppStrings.continueText,
            ).paddingOnly(left: 24, right: 24, bottom: 38),
          ],
        ),
      ),
    );
  }
}
