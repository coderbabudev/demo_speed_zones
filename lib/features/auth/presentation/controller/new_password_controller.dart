import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController {
  RxBool showNewPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showHideNewPassword() {
    showNewPassword.value = !showNewPassword.value;
    update();
  }

  showHideConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
    update();
  }
}
