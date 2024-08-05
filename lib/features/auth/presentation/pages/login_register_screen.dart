import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/controller/auth_controller.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/textField_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({super.key, this.isWhichFrom = false});

  final bool isWhichFrom;

  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen>
    with SingleTickerProviderStateMixin {
  final authController = Get.find<AuthController>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    authController.clearTextField();
    tabController = TabController(length: 2, vsync: this);
    if (widget.isWhichFrom) {
      tabController.index = 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (tabController.index == 0) {
          Get.back();
          authController.clearTextField();
        } else if (tabController.index == 1) {
          if (authController.isMobileRegister.value) {
            authController.isMobileRegister.value = false;
          } else {
            authController.clearTextField();
            Get.back();
          }
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorConstant.whiteColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              backButton(onTap: () {
                if (tabController.index == 0) {
                  Get.back();
                } else if (tabController.index == 1) {
                  if (authController.isMobileRegister.value) {
                    authController.isMobileRegister.value = false;
                  } else {
                    Get.back();
                  }
                }
              }).paddingOnly(left: 20, top: 20),
              Center(
                child: Container(
                  height: 55,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorConstant.lightGreyColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: ColorConstant.whiteColor,
                    ),
                    splashFactory: NoSplash.splashFactory,
                    splashBorderRadius: BorderRadius.circular(25.0),
                    indicatorPadding: const EdgeInsets.all(4),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ColorConstant.blackColor,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: ColorConstant.secondaryColor,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    tabs: const [
                      Tab(text: StringConstant.logIn),
                      Tab(text: StringConstant.register),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
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
                          ).paddingOnly(top: 32, bottom: 49, left: 20),
                          AuthTextField(
                            controller: authController.lgnEmailController,
                            hintText: StringConstant.inputEmail,
                            prefixIcon: IconConstant.enableEmail,
                            textInputAction: TextInputAction.next,
                          ).paddingOnly(left: 20, right: 20, bottom: 24),
                          Obx(() {
                            return AuthTextField(
                              controller: authController.lgnPasswordController,
                              hintText: StringConstant.inputPassword,
                              textInputAction: TextInputAction.done,
                              suffixIcon: authController.lgnShowPassword.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              prefixIcon: IconConstant.enablePassword,
                              suffixOnPress: () =>
                                  authController.lgnShowHidePassword(),
                              obscureText: authController.lgnShowPassword.value
                                  ? false
                                  : true,
                            ).paddingOnly(left: 20, right: 20, bottom: 24);
                          }),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() {
                                    return Checkbox(
                                      value: authController.isCheckLgn.value,
                                      onChanged: (value) => authController
                                          .lgnRememberMeCheck(value!),
                                      visualDensity: VisualDensity.comfortable,
                                      checkColor: ColorConstant.whiteColor,
                                      activeColor: ColorConstant.primaryColor,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        width: 1,
                                        strokeAlign: 4,
                                        style: BorderStyle.solid,
                                        color: Color(0xFFCBCCCD),
                                      ),
                                    );
                                  }),
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
                          ).paddingOnly(left: 20, right: 20),
                          const SizedBox(height: 48),
                          Obx(() {
                            return AuthenticateButton(
                              name: StringConstant.logIn,
                              isLoader: authController.isLoading.value,
                              onPress: () async =>
                                  await authController.signIn(),
                              image: '',
                              color: ColorConstant.primaryColor,
                              textColor: ColorConstant.whiteColor,
                            );
                          }).paddingOnly(left: 20, right: 20),
                          AuthenticateButton(
                            name: StringConstant.loginWithGoogle,
                            onPress: () {},
                            image: IconConstant.googleLogo,
                            isShadow: true,
                            color: ColorConstant.whiteColor,
                            textColor: ColorConstant.blackColor,
                          ).paddingOnly(left: 20, right: 20),
                        ],
                      ),
                    ),
                    Obx(() {
                      return !authController.isMobileRegister.value
                          ? ListView(
                              shrinkWrap: true,
                              children: [
                                const Text(
                                  StringConstant.discoverBestHere,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.blackColor,
                                  ),
                                ).paddingOnly(top: 32, bottom: 48, left: 20),
                                AuthTextField(
                                  controller: authController.regNameController,
                                  hintText: StringConstant.inputName,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: IconConstant.enableUser,
                                ).paddingOnly(bottom: 24, left: 20, right: 20),
                                AuthTextField(
                                  controller: authController.regEmailController,
                                  hintText: StringConstant.inputEmail,
                                  prefixIcon: IconConstant.enableEmail,
                                  textInputAction: TextInputAction.next,
                                ).paddingOnly(bottom: 24, left: 20, right: 20),
                                Obx(() {
                                  return AuthTextField(
                                    controller:
                                        authController.regPasswordController,
                                    hintText: StringConstant.inputPassword,
                                    textInputAction: TextInputAction.done,
                                    suffixIcon:
                                        authController.regShowPassword.value
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                    prefixIcon: IconConstant.enablePassword,
                                    suffixOnPress: () =>
                                        authController.regShowHidePassword(),
                                    obscureText:
                                        authController.regShowPassword.value
                                            ? false
                                            : true,
                                  );
                                }).paddingOnly(bottom: 24, left: 20, right: 20),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Obx(() {
                                          return Checkbox(
                                            value:
                                                authController.isRemember.value,
                                            onChanged: (value) => authController
                                                .regRememberMeCheck(value!),
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            checkColor:
                                                ColorConstant.whiteColor,
                                            activeColor:
                                                ColorConstant.primaryColor,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            side: const BorderSide(
                                              width: 1,
                                              strokeAlign: 4,
                                              style: BorderStyle.solid,
                                              color: Color(0xFFCBCCCD),
                                            ),
                                          );
                                        }),
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
                                        Get.to(
                                            () => const ForgotPasswordScreen());
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
                                ).paddingOnly(left: 20, right: 20),
                                const Spacer(),
                                AuthenticateButton(
                                  name: StringConstant.register,
                                  isLoader: authController.isLoading.value,
                                  onPress: () async => await authController
                                      .signUpWithEmailPass(),
                                  image: '',
                                  color: ColorConstant.primaryColor,
                                  textColor: ColorConstant.whiteColor,
                                ).paddingOnly(left: 20, right: 20),
                                AuthenticateButton(
                                  name: StringConstant.registerWithGoogle,
                                  onPress: () {},
                                  image: IconConstant.googleLogo,
                                  isShadow: true,
                                  color: ColorConstant.whiteColor,
                                  textColor: ColorConstant.blackColor,
                                ).paddingOnly(left: 20, right: 20, bottom: 20),
                              ],
                            )
                          : SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    StringConstant.discoverBestHere,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.blackColor,
                                    ),
                                  ).paddingOnly(top: 32, bottom: 48, left: 20),
                                  if (authController.isMobileRegister.value)
                                    IntlPhoneField(
                                      controller: authController
                                          .regMobileNumberController,
                                      flagsButtonPadding:
                                          const EdgeInsets.all(8),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      dropdownIconPosition:
                                          IconPosition.trailing,
                                      textInputAction: TextInputAction.done,
                                      dropdownIcon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 25,
                                        color: ColorConstant.primaryColor,
                                      ),
                                      invalidNumberMessage: '',
                                      decoration: InputDecoration(
                                        hintText: StringConstant.mobileNumber,
                                        counterText: '',
                                        isDense: true,
                                        filled: true,
                                        fillColor: ColorConstant.lightGreyColor,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      initialCountryCode: 'IN',
                                      onCountryChanged: (Country country) {
                                        authController.countryCode.value =
                                            country.dialCode;
                                      },
                                      keyboardType: TextInputType.number,
                                    ).paddingOnly(left: 20, right: 20),
                                  if (authController.isMobileRegister.value)
                                    const SizedBox(height: 248),
                                  Obx(() {
                                    return AuthenticateButton(
                                      name: StringConstant.register,
                                      isLoader: authController.isLoading.value,
                                      onPress: () => authController
                                          .signUpWithPhoneNumber(),
                                      image: '',
                                      color: ColorConstant.primaryColor,
                                      textColor: ColorConstant.whiteColor,
                                    );
                                  }).paddingOnly(left: 20, right: 20),
                                  AuthenticateButton(
                                    name: StringConstant.registerWithGoogle,
                                    onPress: () {},
                                    image: IconConstant.googleLogo,
                                    isShadow: true,
                                    color: ColorConstant.whiteColor,
                                    textColor: ColorConstant.blackColor,
                                  ).paddingOnly(left: 20, right: 20),
                                ],
                              ),
                            );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
