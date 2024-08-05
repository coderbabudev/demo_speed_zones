import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/model/user_model.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/verify_otp_screen.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/firebase_db/firebase_db.dart';

class AuthController extends GetxController {
  final lgnEmailController = TextEditingController();
  final lgnPasswordController = TextEditingController();
  final regEmailController = TextEditingController();
  final regNameController = TextEditingController();
  final regPasswordController = TextEditingController();
  final regMobileNumberController = TextEditingController();
  final regOtpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final forgetEmailController = TextEditingController();

  RxBool lgnShowPassword = false.obs;
  RxBool regShowPassword = false.obs;
  RxBool showNewPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  RxBool isCheckLgn = false.obs;
  RxBool isRemember = false.obs;

  RxBool isMobileRegister = false.obs;
  RxBool isLoading = false.obs;
  RxString verificationId = ''.obs;
  RxString countryCode = '91'.obs;
  final db = DatabaseMethod();
  FirebaseAuth auth = FirebaseAuth.instance;

  void lgnRememberMeCheck(bool value) {
    isCheckLgn.value = value;
    update();
  }

  void regRememberMeCheck(bool value) {
    isRemember.value = value;
    update();
  }

  lgnShowHidePassword() {
    lgnShowPassword.value = !lgnShowPassword.value;
    update();
  }

  regShowHidePassword() {
    regShowPassword.value = !regShowPassword.value;
    update();
  }

  showHideNewPassword() {
    showNewPassword.value = !showNewPassword.value;
    update();
  }

  showHideConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
    update();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }

  Future<void> signIn() async {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    if (lgnEmailController.text.isNotEmpty &&
        lgnPasswordController.text.isNotEmpty &&
        lgnPasswordController.text.length > 6 &&
        regex.hasMatch(lgnEmailController.text)) {
      setLoading(true);
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: lgnEmailController.text.trim(),
          password: lgnPasswordController.text.trim(),
        );
        if (credential.user != null) {
          Get.offAll(() => const DashboardScreen());
          showMessageSnackBar(
            'Login Successfully.',
            bgColor: Colors.green,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          showMessageSnackBar('Unexpected error occurred.');
        }
      } on FirebaseAuthException catch (e) {
        if (e.email != lgnEmailController.text) {
          showMessageSnackBar('No user found for that email.');
        } else {
          showMessageSnackBar('An error occurred: ${e.code}');
        }
      } catch (e) {
        showMessageSnackBar('An error occurred: $e');
      }
      setLoading(false);
    } else {
      setLoading(false);
      if (lgnEmailController.text.isEmpty) {
        showMessageSnackBar('Email field is required.');
      } else if (lgnPasswordController.text.isEmpty) {
        showMessageSnackBar('Password field is required.');
      } else if (!regex.hasMatch(lgnEmailController.text)) {
        showMessageSnackBar('Enter a valid email address.');
      } else if (lgnPasswordController.text.length <= 6) {
        showMessageSnackBar('Password must be longer than 6 characters.');
      }
    }
  }

  Future<void> signUpWithEmailPass() async {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    if (regEmailController.text.isNotEmpty &&
        regNameController.text.length > 2 &&
        regex.hasMatch(regEmailController.text) &&
        regPasswordController.text.length > 6 &&
        regNameController.text.isNotEmpty &&
        regPasswordController.text.isNotEmpty) {
      isMobileRegister.value = true;
    } else {
      if (regNameController.text.isEmpty) {
        showMessageSnackBar('Name field is required.');
      } else if (regNameController.text.length < 2) {
        showMessageSnackBar('Name is too Short.');
      } else if (regEmailController.text.isEmpty) {
        showMessageSnackBar('Email field is required.');
      } else if (!regex.hasMatch(regEmailController.text)) {
        showMessageSnackBar('Enter a valid email address.');
      } else if (regPasswordController.text.isEmpty) {
        showMessageSnackBar('Password field is required.');
      } else if (regPasswordController.text.length <= 6) {
        showMessageSnackBar('Password must be longer than 6 character');
      } else {}
    }
    update();
  }

  Future<void> signUpWithPhoneNumber() async {
    String formattedDate =
        DateFormat('yyyy MMMM dd, hh:mm a').format(DateTime.now());
    UserDetails userDetails = UserDetails(
      name: regNameController.text.trim(),
      email: regEmailController.text.trim(),
      phone: regMobileNumberController.text.toString(),
      createdAt: formattedDate,
    );
    setLoading(true);
    if (regMobileNumberController.text.isNotEmpty &&
        regMobileNumberController.text.length == 10 &&
        isMobileRegister.value) {
      await auth.verifyPhoneNumber(
        phoneNumber: '+$countryCode ${regMobileNumberController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          Get.to(
            () => VerifyOTPScreen(
              isFrom: "PHONE",
              userInfo: userDetails,
              mobileNumber: regMobileNumberController.text.trim(),
              verificationId: verificationId,
            ),
          );
          update();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
      setLoading(false);
    } else {
      setLoading(false);
      if (regMobileNumberController.text.isEmpty) {
        showMessageSnackBar('Phone field is required.');
      } else if (regMobileNumberController.text.length != 10) {
        showMessageSnackBar('Invalid Mobile number.');
      } else {}
    }
    update();
  }

  @override
  void onClose() {
    regEmailController.dispose();
    regNameController.dispose();
    regPasswordController.dispose();
    regMobileNumberController.dispose();
    regOtpController.dispose();
    super.onClose();
  }

  clearTextField() {
    lgnEmailController.clear();
    lgnPasswordController.clear();
    regEmailController.clear();
    regNameController.clear();
    regPasswordController.clear();
    regMobileNumberController.clear();
    countryCode.value = '';
    isMobileRegister.value = false;
    update();
  }
}
