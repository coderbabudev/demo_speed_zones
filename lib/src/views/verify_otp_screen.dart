import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/controller/auth_controller/register_controller.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.isFrom});

  final String isFrom;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (otpValue) {
        otpValue = registerController;
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 20,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
              ),
              if (widget.isFrom == 'PHONE')
                const Text(
                  AppStrings.verifyPhone,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ).paddingOnly(top: 32),
              if (widget.isFrom == 'CODE')
                const Text(
                  AppStrings.verifyCode,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackColor,
                  ),
                ).paddingOnly(top: 32),
              if (widget.isFrom == 'PHONE')
                const Text(
                  '${AppStrings.verifyPhoneSubText} ${9099465265}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor,
                  ),
                ).paddingOnly(top: 17),
              if (widget.isFrom == 'CODE')
                const Text(
                  '${AppStrings.verifyCodeSubText}\n ${'abc@gmail.com'}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColor,
                  ),
                ).paddingOnly(top: 17),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Pinput(
                        controller: otpValue.otpController,
                        keyboardType: TextInputType.number,
                        length: otpValue.otpLength.value,
                        focusNode: FocusNode(canRequestFocus: false),
                        defaultPinTheme: buildPinTheme(),
                        focusedPinTheme: buildPinTheme(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardAppearance: Brightness.dark,
                        textInputAction: TextInputAction.next,
                        closeKeyboardWhenCompleted: true,
                        pinAnimationType: PinAnimationType.fade,
                        isCursorAnimationEnabled: false,
                        followingPinTheme: buildPinTheme())
                  ],
                ),
              ).paddingOnly(top: 20),
              Center(
                child: RichText(
                  text: const TextSpan(
                    text: AppStrings.dontGetCode,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: AppStrings.resend,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ).paddingOnly(top: 48),
              const Spacer(),
              AuthenticateButton(
                name: AppStrings.verifyNow,
                onPress: () {},
                image: '',
                color: AppColors.primaryColor,
                textColor: AppColors.whiteColor,
              ),
            ],
          ).paddingAll(20),
        );
      }),
    );
  }

  PinTheme buildPinTheme() => PinTheme(
        width: 67,
        height: 54,
        margin: const EdgeInsets.only(right: 10),
        textStyle: const TextStyle(
          fontSize: 24,
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'Outfit',
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(8),
        ),
      );
}
