import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/give_circle_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/presentation/widget/authentication_button.dart';

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
                StringConstant.joiningACircle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.whiteColor,
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
                StringConstant.joiningACircleSubText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                  color: ColorConstant.whiteColor,
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
                StringConstant.submit,
                style: TextStyle(
                  color: ColorConstant.blackTextColor,
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
                    color: ColorConstant.whiteColor,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.primaryColor,
                      border: Border.all(
                        color: ColorConstant.whiteColor,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        StringConstant.or,
                        style: TextStyle(
                          color: ColorConstant.whiteColor,
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
              StringConstant.dontCode,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(top: 18),
            const Text(
              StringConstant.dontCodeSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(top: 5),
            AuthenticateButton(
              image: "",
              onPress: () => Get.to(() => const GiveCircleNameScreen()),
              textColor: ColorConstant.blackTextColor,
              color: ColorConstant.whiteColor,
              name: StringConstant.createANewCircle,
            ).paddingOnly(top: 35, bottom: 38, left: 24, right: 24),
          ],
        ),
      ),
    );
  }
}
