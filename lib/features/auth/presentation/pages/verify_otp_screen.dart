import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/auth_controller.dart';
import 'package:demo_speed_zones/features/auth/presentation/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({
    super.key,
    required this.isFrom,
    required this.mobileNumber,
    this.verificationId,
    required this.userInfo,
  });

  final UserDetails userInfo;
  final String isFrom;
  final String mobileNumber;
  final String? verificationId;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(onTap: () => Get.back()),
            if (widget.isFrom == 'PHONE')
              const Text(
                StringConstant.verifyPhone,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.blackColor,
                ),
              ).paddingOnly(top: 32),
            if (widget.isFrom == 'CODE')
              const Text(
                StringConstant.verifyCode,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.blackColor,
                ),
              ).paddingOnly(top: 32),
            if (widget.isFrom == 'PHONE')
              Text(
                '${StringConstant.verifyPhoneSubText} ${widget.mobileNumber}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.secondaryColor,
                ),
              ).paddingOnly(top: 17),
            if (widget.isFrom == 'CODE')
              const Text(
                '${StringConstant.verifyCodeSubText}\n ${'abc@gmail.com'}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorConstant.secondaryColor,
                ),
              ).paddingOnly(top: 17),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Pinput(
                    controller: authController.regOtpController,
                    keyboardType: TextInputType.number,
                    length: 6,
                    focusNode: FocusNode(canRequestFocus: false),
                    defaultPinTheme: buildPinTheme(),
                    focusedPinTheme: buildPinTheme(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardAppearance: Brightness.dark,
                    textInputAction: TextInputAction.done,
                    closeKeyboardWhenCompleted: true,
                    pinAnimationType: PinAnimationType.fade,
                    isCursorAnimationEnabled: false,
                    followingPinTheme: buildPinTheme(),
                  )
                ],
              ),
            ).paddingOnly(top: 20),
            Center(
              child: RichText(
                text: const TextSpan(
                  text: StringConstant.dontGetCode,
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: StringConstant.resend,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ).paddingOnly(top: 48),
            const Spacer(),
            Obx(() {
              return AuthenticateButton(
                name: StringConstant.verifyNow,
                isLoader: authController.isLoading.value,
                onPress: widget.isFrom == "PHONE"
                    ? () => authController.verifyOTP(
                          widget.verificationId ?? '',
                          widget.userInfo,
                        )
                    : () {},
                image: '',
                color: ColorConstant.primaryColor,
                textColor: ColorConstant.whiteColor,
              );
            }),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
