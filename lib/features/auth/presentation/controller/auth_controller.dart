import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/firebase_db/firebase_db.dart';
import 'package:demo_speed_zones/core/services/shared_prefrences_services.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/model/user_model.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/successfully_registered_screen.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/verify_otp_screen.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final oldPasswordController = TextEditingController();
  UserDetails userData = const UserDetails();

  RxBool lgnShowPassword = false.obs;
  RxBool regShowPassword = false.obs;
  RxBool showOldPassword = false.obs;
  RxBool showNewPassword = false.obs;
  RxBool showConfirmPassword = false.obs;

  RxBool isLoggedIn = false.obs;
  RxBool isRememberLgn = false.obs;
  RxBool isRememberReg = false.obs;

  RxBool isMobileRegister = false.obs;
  RxBool isLoading = false.obs;
  RxString verificationId = ''.obs;
  RxString countryCode = '91'.obs;
  RxString countryFlag = 'IN'.obs;
  RxBool isPhoneVerified = false.obs;
  RxString confirmPassword = ''.obs;
  RxString oldPassword = ''.obs;
  RxString newPassword = ''.obs;
  final db = DatabaseMethod();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseDb = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        final userDoc =
            await firebaseDb.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          isLoggedIn.value = true;
        } else {
          isLoggedIn.value = false;
          await auth.signOut(); // Sign out if user is deleted
        }
      } else {
        isLoggedIn.value = false;
      }
    });
    loadUserCredentials();
    db.fetchUserdata(userData.name.toString());
  }

  void lgnRememberMeCheck(bool value) {
    isRememberLgn.value = value;
    update();
  }

  Future<void> loadUserCredentials() async {
    lgnEmailController.text =
        SharedPrefs().getString(SharedPrefs.lgnEmailKey) ?? '';
    lgnPasswordController.text =
        SharedPrefs().getString(SharedPrefs.lgnPasswordKey) ?? '';
    regNameController.text =
        SharedPrefs().getString(SharedPrefs.regNameKey) ?? '';
    regEmailController.text =
        SharedPrefs().getString(SharedPrefs.regEmailKey) ?? '';
    regPasswordController.text =
        SharedPrefs().getString(SharedPrefs.regPasswordKey) ?? '';
    isRememberLgn.value = lgnEmailController.text.isNotEmpty;
    isRememberReg.value = regEmailController.text.isNotEmpty;
    update();
  }

  void regRememberMeCheck(bool value) {
    isRememberReg.value = value;
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

  showHideOLDPassword() {
    showOldPassword.value = !showOldPassword.value;
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

  Future<void> signIn() async {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    if (lgnEmailController.text.isNotEmpty &&
        lgnPasswordController.text.isNotEmpty &&
        lgnPasswordController.text.length > 6 &&
        regex.hasMatch(lgnEmailController.text)) {
      isLoading.value = true;
      try {
        final credential = await auth.signInWithEmailAndPassword(
          email: lgnEmailController.text.trim(),
          password: lgnPasswordController.text.trim(),
        );
        if (credential.user != null) {
          if (isRememberLgn.value) {
            await SharedPrefs().saveString(
                SharedPrefs.lgnEmailKey, lgnEmailController.text.trim());
            await SharedPrefs().saveString(
                SharedPrefs.lgnPasswordKey, lgnPasswordController.text.trim());
          } else {
            await SharedPrefs().clear(SharedPrefs.lgnEmailKey);
            await SharedPrefs().clear(SharedPrefs.lgnPasswordKey);
          }
          Get.offAll(() => const DashboardScreen());
          showMessageSnackBar(StringConstant.loginSuccessfully,
              bgColor: Colors.green, snackPosition: SnackPosition.TOP);
        } else {
          showMessageSnackBar(StringConstant.unexpectedErrorOccurred);
        }
      } on FirebaseAuthException catch (e) {
        if (e.email != lgnEmailController.text) {
          showMessageSnackBar(StringConstant.noUserFoundForThatEmail);
        } else if (e.code == 'wrong-password') {
          showMessageSnackBar(StringConstant.incorrectPassword);
        } else {
          showMessageSnackBar('${StringConstant.anErrorOccurred}${e.code}');
        }
      } catch (e) {
        showMessageSnackBar('${StringConstant.anErrorOccurred}$e');
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      if (lgnEmailController.text.isEmpty) {
        showMessageSnackBar(StringConstant.emailFieldIsRequired);
      } else if (lgnPasswordController.text.isEmpty) {
        showMessageSnackBar(StringConstant.passwordFieldIsRequired);
      } else if (!regex.hasMatch(lgnEmailController.text)) {
        showMessageSnackBar(StringConstant.enterAValidEmailAddress);
      } else if (lgnPasswordController.text.length <= 6) {
        showMessageSnackBar(StringConstant.passwordMustBeLongerThan6Characters);
      }
    }
  }

  Future<void> signUpWithEmailPass() async {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    isLoading.value = true;
    if (regEmailController.text.isNotEmpty &&
        regNameController.text.length > 2 &&
        regex.hasMatch(regEmailController.text) &&
        regPasswordController.text.length > 6 &&
        regNameController.text.isNotEmpty &&
        regPasswordController.text.isNotEmpty) {
      isMobileRegister.value = true;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      if (regNameController.text.isEmpty) {
        showMessageSnackBar(StringConstant.nameFieldIsRequired);
      } else if (regNameController.text.length < 2) {
        showMessageSnackBar(StringConstant.nameIsTooShort);
      } else if (regEmailController.text.isEmpty) {
        showMessageSnackBar(StringConstant.emailFieldIsRequired);
      } else if (!regex.hasMatch(regEmailController.text)) {
        showMessageSnackBar(StringConstant.enterAValidEmailAddress);
      } else if (regPasswordController.text.isEmpty) {
        showMessageSnackBar(StringConstant.passwordFieldIsRequired);
      } else if (regPasswordController.text.length <= 6) {
        showMessageSnackBar(StringConstant.passwordMustBeLongerThan6Characters);
      } else {}
    }
    update();
  }

  Future<void> signUpWithPhoneNumber() async {
    final userDetails = UserDetails(
      name: regNameController.text.trim(),
      email: regEmailController.text.trim(),
      countryCode: '+${countryCode.value}',
      phone: regMobileNumberController.text.toString(),
      countryFlag: countryFlag.value,
      createdAt: currentDate,
    );
    isLoading.value = true;
    if (regMobileNumberController.text.isNotEmpty &&
        regMobileNumberController.text.length == 10 &&
        isMobileRegister.value) {
      await auth.verifyPhoneNumber(
        phoneNumber: '+$countryCode ${regMobileNumberController.text.trim()}',
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          showMessageSnackBar('$e');
        },
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
      isLoading.value = false;
    } else {
      isLoading.value = false;
      if (regMobileNumberController.text.isEmpty) {
        showMessageSnackBar(StringConstant.phoneFieldIsRequired);
      } else if (regMobileNumberController.text.length != 10) {
        showMessageSnackBar(StringConstant.invalidMobileNumber);
      } else {}
    }
    update();
  }

  Future<void> verifyOTP(String verificationId, UserDetails userInfo) async {
    if (regOtpController.text.isNotEmpty && regOtpController.text.length == 6) {
      isLoading.value = true;
      try {
        PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: regOtpController.text.toString(),
        );
        UserCredential phoneUserCredential =
            await auth.signInWithCredential(phoneCredential);

        AuthCredential emailCredential = EmailAuthProvider.credential(
          email: regEmailController.text.trim(),
          password: regPasswordController.text.trim(),
        );

        await phoneUserCredential.user!.linkWithCredential(emailCredential);
        UserDetails updatedUserInfo = UserDetails(
          userId: userInfo.userId,
          name: userInfo.name,
          email: userInfo.email,
          phone: userInfo.phone,
          isPhoneVerified: true,
          photoUrl: userInfo.photoUrl,
          location: userInfo.location,
          createdAt: userInfo.createdAt,
          updatedAt: userInfo.updatedAt,
          countryFlag: userInfo.countryFlag,
          countryCode: userInfo.countryCode,
          isEnable: userInfo.isEnable,
          isDeleted: userInfo.isDeleted,
        );
        if (isRememberReg.value) {
          await SharedPrefs().saveString(
              SharedPrefs.regNameKey, regNameController.text.trim());
          await SharedPrefs().saveString(
              SharedPrefs.regEmailKey, regEmailController.text.trim());
          await SharedPrefs().saveString(
              SharedPrefs.regPasswordKey, regPasswordController.text.trim());
        } else {
          await SharedPrefs().clear(SharedPrefs.regNameKey);
          await SharedPrefs().clear(SharedPrefs.regEmailKey);
          await SharedPrefs().clear(SharedPrefs.regPasswordKey);
        }
        print("updatedUserInfo :-- $updatedUserInfo");
        print("updatedUserInfo :-- ${updatedUserInfo.countryCode}");
        print("updatedUserInfo :-- ${updatedUserInfo.phone}");
        db.createUser(updatedUserInfo);
        Get.offAll(
            () => SuccessFullyRegisteredScreen(userInfo: updatedUserInfo));
        regOtpController.clear();
      } on FirebaseAuthException catch (e) {
        regOtpController.clear();
        showMessageSnackBar(e.code);
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      if (regOtpController.text.isEmpty) {
        showMessageSnackBar(StringConstant.oTPFieldIsRequired);
      } else if (regOtpController.text.length != 6) {
        showMessageSnackBar(StringConstant.invalidOTP);
      }
    }
    update();
  }

  Future<void> resetPassword() async {
    oldPassword.value = oldPasswordController.text.trim();
    newPassword.value = newPasswordController.text.trim();
    confirmPassword.value = confirmPasswordController.text.trim();
    const passwordPattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{6,}$';

    final passwordRegex = RegExp(passwordPattern);
    isLoading.value = true;
    if (oldPassword.value.isNotEmpty &&
        newPassword.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        passwordRegex.hasMatch(newPasswordController.text) &&
        confirmPassword.value == newPassword.value &&
        newPassword.value.length > 6) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email.toString(),
            password: oldPasswordController.text.trim(),
          );
          await user.reauthenticateWithCredential(credential);
          await db.updatePassword(newPasswordController.text);
          showMessageSnackBar(
              bgColor: Colors.green,
              StringConstant.passwordChangedSuccessfully);
          clearController();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            showMessageSnackBar(StringConstant.oldPasswordWasIncorrect);
          } else if (e.code == 'requires-recent-login') {
            showMessageSnackBar(
                StringConstant.pleaseLogInAgainToUpdateYourPassword);
          } else {
            showMessageSnackBar('Error: ${e.message}');
          }
        } catch (e) {
          showMessageSnackBar('${StringConstant.anErrorOccurred}$e');
        } finally {
          isLoading.value = false;
          update();
        }
      } else {
        showMessageSnackBar(StringConstant.noUserIsCurrentlyLoggedIn);
        isLoading.value = false;
        update();
      }
    } else {
      isLoading.value = false;
      if (oldPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.oldPasswordFieldIsRequired);
      } else if (newPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.newPasswordFieldIsRequired);
      } else if (confirmPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.confirmPasswordFieldIsRequired);
      } else if (confirmPassword.value != newPassword.value) {
        showMessageSnackBar(StringConstant.confirmPasswordDoesNotMatch);
      } else if (newPassword.value.length < 6) {
        showMessageSnackBar(StringConstant.passwordMustBeLongerThan6Characters);
      } else if (!passwordRegex.hasMatch(newPasswordController.text)) {
        showMessageSnackBar(StringConstant.weakPassword);
      } else {}
      // update();
    }
    update();
  }

  clearTextField() {
    if (!isRememberLgn.value) {
      lgnEmailController.clear();
      lgnPasswordController.clear();
    }
    if (!isRememberReg.value) {
      regEmailController.clear();
      regNameController.clear();
      regPasswordController.clear();
    }
    regMobileNumberController.clear();
    countryCode.value = '';
    isMobileRegister.value = false;
    update();
  }

  clearController() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    update();
  }

  @override
  void onClose() {
    regEmailController.dispose();
    regNameController.dispose();
    regPasswordController.dispose();
    regMobileNumberController.dispose();
    regOtpController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
