import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/give_circle_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class JoinCircleInviteCodeScreen extends StatefulWidget {
  const JoinCircleInviteCodeScreen({super.key});

  @override
  State<JoinCircleInviteCodeScreen> createState() =>
      _JoinCircleInviteCodeScreenState();
}

class _JoinCircleInviteCodeScreenState
    extends State<JoinCircleInviteCodeScreen> {
  final inviteController = Get.find<CircleManagementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                      ).paddingOnly(top: 16),
                    ),
                    Pinput(
                      keyboardType: TextInputType.text,
                      length: 6,
                      controller: inviteController.inviteCodeController,
                      focusNode: FocusNode(canRequestFocus: false),
                      defaultPinTheme: buildPinTheme(),
                      focusedPinTheme: buildPinTheme(),
                      useNativeKeyboard: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Z]')),
                      ],
                      textCapitalization: TextCapitalization.characters,
                      keyboardAppearance: Brightness.dark,
                      textInputAction: TextInputAction.done,
                      closeKeyboardWhenCompleted: true,
                      pinAnimationType: PinAnimationType.fade,
                      isCursorAnimationEnabled: false,
                      followingPinTheme: buildPinTheme(),
                    ).paddingOnly(top: 50, left: 47, right: 47),
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
                    Obx(() {
                      return ElevatedButton(
                        onPressed: inviteController.isAllFieldsFilled.value
                            ? () async {
                                final inviteCode =
                                    inviteController.inviteCodeController.text;
                                await inviteController.onSubmitCode(inviteCode);
                              }
                            : () =>
                                showMessageSnackBar('Enter your invite code.'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.infinity, 56),
                          maximumSize: const Size(double.infinity, 56),
                          minimumSize: const Size(double.infinity, 56),
                          visualDensity: VisualDensity.comfortable,
                          elevation: 0,
                          splashFactory: NoSplash.splashFactory,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor:
                              inviteController.isAllFieldsFilled.value
                                  ? ColorConstant.whiteColor
                                  : const Color(0xFFA7A9B7).withOpacity(0.3),
                        ),
                        child: const Text(
                          StringConstant.submit,
                          style: TextStyle(
                            color: ColorConstant.blackTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).paddingOnly(left: 24, right: 24, top: 50),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
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
                ).paddingOnly(top: 35, bottom: 20, left: 24, right: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
