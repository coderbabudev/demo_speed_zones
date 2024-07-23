import 'package:demo_speed_zones/src/services/database_services.dart';
import 'package:demo_speed_zones/src/utils/util.dart';
import 'package:demo_speed_zones/src/views/home_screen.dart';
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
  final _db = DatabaseMethod();

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
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      _db.createUser(user!.uid, {
        'name': name ?? '',
        'email': user.email,
        'imageUrl': user.photoURL ?? '',
      });
      Get.to(() => const HomeScreen());
      showMessageSnackBar('Registered Successfully');
      clearTextField();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        showMessageSnackBar('Account Already exists');
      }
    }
  }

  textFieldValidation() {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);
    if (nameController.text.isEmpty) {
      showMessageSnackBar('Name field is required.');
    } else if (nameController.text.length < 2) {
      showMessageSnackBar('Name is too Short.');
    } else if (emailController.text.isEmpty) {
      showMessageSnackBar('Email field is required.');
    } else if (!regex.hasMatch(emailController.text)) {
      showMessageSnackBar('Enter a valid email address.');
    } else if (passwordController.text.isEmpty) {
      showMessageSnackBar('Password field is required.');
    } else if (passwordController.text.length < 6) {
      showMessageSnackBar('Password must be longer than 6 character');
    } else {}
    update();
  }

  clearTextField() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    update();
  }
}
