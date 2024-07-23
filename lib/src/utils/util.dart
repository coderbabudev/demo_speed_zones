import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

showMessageSnackBar(String message) {
  Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
      ),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      backgroundColor: AppColors.redColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
