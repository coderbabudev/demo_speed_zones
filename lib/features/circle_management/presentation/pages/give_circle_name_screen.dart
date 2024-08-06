import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/share_invite_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GiveCircleNameScreen extends StatefulWidget {
  const GiveCircleNameScreen({super.key});

  @override
  State<GiveCircleNameScreen> createState() => _GiveCircleNameScreenState();
}

class _GiveCircleNameScreenState extends State<GiveCircleNameScreen> {
  final circleController = Get.find<CircleManagementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: const Text(
                StringConstant.giveCircleName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.whiteColor,
                ),
              ).paddingOnly(top: 31),
            ),
            TextFormField(
              controller: circleController.circleNameController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.blackTextColor,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                fillColor: ColorConstant.whiteColor,
                isDense: true,
                filled: true,
                hintText: 'Circle name',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.secondaryColor,
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
              StringConstant.tipText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(top: 50, left: 37, right: 38),
            const Spacer(),
            AuthenticateButton(
              image: "",
              textColor: ColorConstant.blackTextColor,
              onPress: () {
                if (circleController.circleNameController.text.isNotEmpty) {
                  Get.to(() => ShareInviteCodeScreen(
                        circleName: circleController.circleNameController.text,
                      ));
                } else {
                  if (circleController.circleNameController.text.isEmpty) {
                    showMessageSnackBar('Please Enter your Circle Name');
                  }
                }
              },
              color: ColorConstant.whiteColor,
              name: StringConstant.continueText,
            ).paddingOnly(left: 24, right: 24, bottom: 38),
          ],
        ),
      ),
    );
  }
}
