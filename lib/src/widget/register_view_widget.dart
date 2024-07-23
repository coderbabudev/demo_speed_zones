import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/controller/auth_controller/register_controller.dart';
import 'package:demo_speed_zones/src/services/validation_services.dart';
import 'package:demo_speed_zones/src/views/forgot_password_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:demo_speed_zones/src/widget/textField_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterController registerController = Get.put(RegisterController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (registerValue) {
      registerValue = registerController;
      return SingleChildScrollView(
        child: Form(
          key: formKey,
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
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name field is required.';
                    } else if (value.length <= 2) {
                      return 'Name is too short.';
                    } else {
                      return '';
                    }
                  },
                ).paddingOnly(bottom: 24),
              if (!registerValue.isMobileRegister.value)
                AuthTextField(
                  controller: registerValue.emailController,
                  hintText: AppStrings.inputEmail,
                  prefixIcon: Assets.enableEmail,
                  validator: (value) => validateEmail(value!) ?? '',
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                  ],
                ).paddingOnly(bottom: 24),
              if (!registerValue.isMobileRegister.value)
                AuthTextField(
                  controller: registerValue.passwordController,
                  hintText: AppStrings.inputPassword,
                  suffixIcon: registerValue.showPassword.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  prefixIcon: Assets.enablePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password field is required.';
                    }
                    return '';
                  },
                  suffixOnPress: () => registerValue.showHidePassword(),
                  obscureText: registerValue.showPassword.value ? false : true,
                  keyboardType: TextInputType.emailAddress,
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                  keyboardType: TextInputType.number,
                  onChanged: (phone) {
                    if (kDebugMode) {
                      print(phone.completeNumber);
                    }
                  },
                ),
              if (registerValue.isMobileRegister.value)
                const SizedBox(height: 248),
              AuthenticateButton(
                name: AppStrings.register,
                isLoader: registerValue.isLoading.value,
                onPress: () async {
                  // if (formKey.currentState!.validate()) {
                  //   formKey.currentState?.save();
                  await registerValue.signUp(
                      name: registerValue.nameController.text.trim(),
                      email: registerValue.emailController.text.trim(),
                      password: registerValue.passwordController.text.trim());
                  // }
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
        ),
      );
    });
  }
}
