import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/controller/auth_controller/login_controller.dart';
import 'package:demo_speed_zones/src/views/forgot_password_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:demo_speed_zones/src/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (loginValue) {
      loginValue = loginController;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.welcomeBack,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.blackColor,
              ),
            ).paddingOnly(top: 32, bottom: 49),
            AuthTextField(
              controller: loginValue.emailController,
              hintText: AppStrings.inputEmail,
              prefixIcon: Assets.enableEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            AuthTextField(
              controller: loginValue.passwordController,
              hintText: AppStrings.inputPassword,
              suffixIcon: loginValue.showPassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              prefixIcon: Assets.enablePassword,
              suffixOnPress: () => loginValue.showHidePassword(),
              obscureText: loginValue.showPassword.value ? false : true,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: loginValue.isCheck.value,
                      onChanged: (value) => loginValue.rememberMeCheck(value!),
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
            ),
            const SizedBox(height: 48),
            AuthenticateButton(
              name: AppStrings.logIn,
              onPress: () {},
              image: '',
              color: AppColors.primaryColor,
              textColor: AppColors.whiteColor,
            ),
            AuthenticateButton(
              name: AppStrings.loginWithGoogle,
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
