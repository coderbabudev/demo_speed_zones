import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  RxBool isCheck = false.obs;

  void rememberMeCheck(bool value) {
    isCheck.value = value;
    update();
  }

  showHidePassword() {
    showPassword.value = !showPassword.value;
    update();
  }
}
