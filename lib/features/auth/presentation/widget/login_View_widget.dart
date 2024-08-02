import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/login_controller.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
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
              StringConstant.welcomeBack,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: ColorConstant.blackColor,
              ),
            ).paddingOnly(top: 32, bottom: 49),
            AuthTextField(
              controller: loginValue.emailController,
              hintText: StringConstant.inputEmail,
              prefixIcon: IconConstant.enableEmail,
            ),
            const SizedBox(height: 24),
            AuthTextField(
              controller: loginValue.passwordController,
              hintText: StringConstant.inputPassword,
              suffixIcon: loginValue.showPassword.value
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              prefixIcon: IconConstant.enablePassword,
              suffixOnPress: () => loginValue.showHidePassword(),
              obscureText: loginValue.showPassword.value ? false : true,
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
                      checkColor: ColorConstant.whiteColor,
                      activeColor: ColorConstant.primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        width: 1,
                        strokeAlign: 4,
                        style: BorderStyle.solid,
                        color: Color(0xFFCBCCCD),
                      ),
                    ),
                    const Text(
                      StringConstant.rememberMe,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPasswordScreen());
                  },
                  child: const Text(
                    StringConstant.forgotPassword,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            AuthenticateButton(
              name: StringConstant.logIn,
              onPress: () {},
              image: '',
              color: ColorConstant.primaryColor,
              textColor: ColorConstant.whiteColor,
            ),
            AuthenticateButton(
              name: StringConstant.loginWithGoogle,
              onPress: () {},
              image: IconConstant.googleLogo,
              isShadow: true,
              color: ColorConstant.whiteColor,
              textColor: ColorConstant.blackColor,
            ),
          ],
        ),
      );
    });
  }
}
