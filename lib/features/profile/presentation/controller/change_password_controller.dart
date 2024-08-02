import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool showNewPassword = false.obs;
  RxBool showOldPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showHideOldPassword() {
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
}
