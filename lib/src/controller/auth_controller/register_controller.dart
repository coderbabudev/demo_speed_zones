import 'package:demo_speed_zones/src/services/database_services.dart';
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
  RxInt otpLength = 4.obs;
  RxBool isLoading = false.obs;
  RxBool showPassword = false.obs;
  RxBool isRemember = false.obs;
  final _db = DatabaseMethod();

  void rememberMeCheck(bool value) {
    isRemember.value = value;
    update();
  }

  showHidePassword() {
    showPassword.value = !showPassword.value;
    update();
  }

  Future<void> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    isLoading.value = true;
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
      isLoading.value = false;
      Get.to(() => const HomeScreen());
      Get.showSnackbar(
        const GetSnackBar(
          title: '',
          message: 'Registered Successfully',
          duration: Duration(seconds: 2),
        ),
      );
      clearField();
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.showSnackbar(
          const GetSnackBar(
            title: '',
            message: 'Account Already exists',
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  clearField() {
    emailController.clear();
    nameController.clear();
    passwordController.clear();
    update();
  }
}
