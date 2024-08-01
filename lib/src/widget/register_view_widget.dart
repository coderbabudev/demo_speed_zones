import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/controller/auth_controller/register_controller.dart';
import 'package:demo_speed_zones/src/utils/util.dart';
import 'package:demo_speed_zones/src/views/forgot_password_screen.dart';
import 'package:demo_speed_zones/src/views/verify_otp_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:demo_speed_zones/src/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController registerController =
      Get.put<RegisterController>(RegisterController());

  @override
  Widget build(BuildContext context) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    return GetBuilder<RegisterController>(builder: (registerValue) {
      registerValue = registerController;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.discoverBestHere,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ).paddingOnly(top: 32, bottom: 48),
            if (!registerValue.isMobileRegister.value)
              AuthTextField(
                controller: registerValue.nameController,
                hintText: AppStrings.inputName,
                prefixIcon: Assets.enableUser,
              ).paddingOnly(bottom: 24),
            if (!registerValue.isMobileRegister.value)
              AuthTextField(
                controller: registerValue.emailController,
                hintText: AppStrings.inputEmail,
                prefixIcon: Assets.enableEmail,
              ).paddingOnly(bottom: 24),
            if (!registerValue.isMobileRegister.value)
              AuthTextField(
                controller: registerValue.passwordController,
                hintText: AppStrings.inputPassword,
                suffixIcon: registerValue.showPassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                prefixIcon: Assets.enablePassword,
                suffixOnPress: () => registerValue.showHidePassword(),
                obscureText: registerValue.showPassword.value ? false : true,
              ).paddingOnly(bottom: 24),
            if (!registerValue.isMobileRegister.value)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: registerValue.isRemember.value,
                        onChanged: (value) =>
                            registerValue.rememberMeCheck(value!),
                        visualDensity: VisualDensity.comfortable,
                        checkColor: AppColors.whiteColor,
                        activeColor: AppColors.primaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        side: const BorderSide(
                          width: 1,
                          strokeAlign: 4,
                          style: BorderStyle.solid,
                          color: Color(0xFFCBCCCD),
                        ),
                      ),
                      const Text(
                        AppStrings.rememberMe,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ForgotPasswordScreen());
                    },
                    child: const Text(
                      AppStrings.forgotPassword,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 48),
            if (registerValue.isMobileRegister.value)
              IntlPhoneField(
                controller: registerValue.mobileNumberController,
                flagsButtonPadding: const EdgeInsets.all(8),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 25,
                  color: AppColors.primaryColor,
                ),
                invalidNumberMessage: '',
                decoration: InputDecoration(
                  hintText: AppStrings.mobileNumber,
                  counterText: '',
                  isDense: true,
                  filled: true,
                  fillColor: AppColors.lightGreyColor,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                initialCountryCode: 'IN',
                onCountryChanged: (Country country) {
                  registerValue.countryCode.value = country.dialCode;
                  print(
                      "registerValue.countryCode.value :- ${registerValue.countryCode.value}");
                },
                keyboardType: TextInputType.number,
              ),
            if (registerValue.isMobileRegister.value)
              const SizedBox(height: 248),
            AuthenticateButton(
              name: AppStrings.register,
              isLoader: registerValue.isLoading.value,
              onPress: registerValue.isMobileRegister.value
                  ? () async {
                      if (registerValue
                              .mobileNumberController.text.isNotEmpty &&
                          registerValue.mobileNumberController.text.length ==
                              10) {
                        registerValue.setLoading(true);
                        await registerValue
                            .signUpWithPhoneNumber(
                                registerValue.mobileNumberController.text
                                    .trim(),
                                registerValue.countryCode.value)
                            .then((value) {
                          Get.to(() => VerifyOTPScreen(
                                isFrom: "PHONE",
                                mobileNumber:
                                    registerValue.mobileNumberController.text,
                                verificationId:
                                    registerValue.verificationId.value,
                              ));
                          registerValue.setLoading(false);
                        });
                      } else {
                        if (registerValue.mobileNumberController.text.isEmpty) {
                          showMessageSnackBar('Phone field is required.');
                        } else if (registerValue
                                .mobileNumberController.text.length !=
                            10) {
                          showMessageSnackBar('Invalid Mobile number.');
                        } else {}
                      }
                      setState(() {});
                    }
                  : () async {
                      if (registerValue.emailController.text.isNotEmpty &&
                          registerValue.nameController.text.length > 2 &&
                          regex.hasMatch(registerValue.emailController.text) &&
                          registerValue.passwordController.text.length > 6 &&
                          registerValue.nameController.text.isNotEmpty &&
                          registerValue.passwordController.text.isNotEmpty) {
                        registerValue.isMobileRegister.value = true;
                        // registerValue.setLoading(true);
                        // await registerValue.signUp(
                        //   name: registerValue.nameController.text.trim(),
                        //   email: registerValue.emailController.text.trim(),
                        //   password: registerValue.passwordController.text.trim(),
                        // );
                        // registerValue.setLoading(false);
                      } else {
                        if (registerValue.nameController.text.isEmpty) {
                          showMessageSnackBar('Name field is required.');
                        } else if (registerValue.nameController.text.length <
                            2) {
                          showMessageSnackBar('Name is too Short.');
                        } else if (registerValue.emailController.text.isEmpty) {
                          showMessageSnackBar('Email field is required.');
                        } else if (!regex
                            .hasMatch(registerValue.emailController.text)) {
                          showMessageSnackBar('Enter a valid email address.');
                        } else if (registerValue
                            .passwordController.text.isEmpty) {
                          showMessageSnackBar('Password field is required.');
                        } else if (registerValue
                                .passwordController.text.length <=
                            6) {
                          showMessageSnackBar(
                              'Password must be longer than 6 character');
                        } else {}
                      }
                      setState(() {});
                    },
              image: '',
              color: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
            AuthenticateButton(
              name: AppStrings.registerWithGoogle,
              onPress: () {},
              image: Assets.googleLogo,
              isShadow: true,
              color: AppColors.whiteColor,
              textColor: AppColors.blackColor,
            ),
          ],
        ),
      );
    });
  }
}
