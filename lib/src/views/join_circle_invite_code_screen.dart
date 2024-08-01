import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/utils/util.dart';
import 'package:demo_speed_zones/src/views/give_circle_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../widget/authentication_button.dart';

class JoinCircleInviteCodeScreen extends StatefulWidget {
  const JoinCircleInviteCodeScreen({super.key});

  @override
  State<JoinCircleInviteCodeScreen> createState() =>
      _JoinCircleInviteCodeScreenState();
}

class _JoinCircleInviteCodeScreenState
    extends State<JoinCircleInviteCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: const Text(
                AppStrings.joiningACircle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(top: 31),
            ),
            Pinput(
              keyboardType: TextInputType.number,
              length: 6,
              focusNode: FocusNode(canRequestFocus: false),
              defaultPinTheme: buildPinTheme(),
              focusedPinTheme: buildPinTheme(),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardAppearance: Brightness.dark,
              textInputAction: TextInputAction.next,
              closeKeyboardWhenCompleted: true,
              pinAnimationType: PinAnimationType.fade,
              isCursorAnimationEnabled: false,
              followingPinTheme: buildPinTheme(),
            ).paddingOnly(top: 50, left: 47, right: 48),
            Center(
              child: const Text(
                AppStrings.joiningACircleSubText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(top: 50, left: 37, right: 38),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(double.infinity, 56),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
                visualDensity: VisualDensity.comfortable,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color(0xFFA7A9B7).withOpacity(0.3),
              ),
              child: const Text(
                AppStrings.submit,
                style: TextStyle(
                  color: AppColors.blackTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ).paddingOnly(left: 24, right: 24, top: 50),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: AppColors.whiteColor,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.whiteColor,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        AppStrings.or,
                        style: TextStyle(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ).paddingOnly(top: 200),
            const Text(
              AppStrings.dontCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(top: 18),
            const Text(
              AppStrings.dontCodeSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(top: 5),
            AuthenticateButton(
              image: "",
              onPress: () => Get.to(() => const GiveCircleNameScreen()),
              textColor: AppColors.blackTextColor,
              color: AppColors.whiteColor,
              name: AppStrings.createANewCircle,
            ).paddingOnly(top: 35, bottom: 38, left: 24, right: 24),
          ],
        ),
      ),
    );
  }
}
