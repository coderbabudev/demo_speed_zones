import 'package:demo_speed_zones/core/firebase_db/firebase_db.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/pages/verify_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final otpController = TextEditingController();
  RxBool isMobileRegister = false.obs;
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  RxBool isRemember = false.obs;
  RxString verificationId = ''.obs;
  RxString countryCode = '91'.obs;
  final _db = DatabaseMethod();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    mobileNumberController.dispose();
    otpController.dispose();
    super.onClose();
  }

  void rememberMeCheck(bool value) {
    isRemember.value = value;
    update();
  }

  showHidePassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  void setLoading(bool value) {
    isLoading.value = value;
    update();
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      _db.createUser(user!.uid, {
        'name': name ?? '',
        'email': user.email,
        'imageUrl': user.photoURL ?? '',
      });
      // Get.to(() => const Das());
      // showMessageSnackBar('Registered Successfully');
      // clearTextField();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showMessageSnackBar('Account Already exists');
      }
    }
  }

  Future<void> signUpWithPhoneNumber(String phoneNumber, String code) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+$code $phoneNumber',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("credential :- $credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        Get.to(
          () => VerifyOTPScreen(
            isFrom: "PHONE",
            mobileNumber: phoneNumber,
            verificationId: verificationId,
          ),
        );
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  clearTextField() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    update();
  }
}
