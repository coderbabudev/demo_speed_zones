import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

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
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      backgroundColor: AppColors.redColor,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

Widget backButton({IconData? icon, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(top: 15, bottom: 32),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.secondaryColor,
        ),
      ),
      child: Center(
        child: Icon(
          icon ?? Icons.arrow_back_rounded,
          size: 20,
          color: AppColors.blackColor,
        ),
      ),
    ),
  );
}

PinTheme buildPinTheme() => PinTheme(
      width: 67,
      height: 54,
      margin: const EdgeInsets.only(right: 10),
      textStyle: const TextStyle(
        fontSize: 24,
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Outfit',
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGreyColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

// showCongratulationDialog(BuildContext context, AnimationController controller) {
//   showDialog(
//       context: context,
//       barrierColor: const Color(0xFF161B1D).withOpacity(0.8),
//       builder: (context) {
//         return Dialog(
//           shadowColor: Colors.transparent,
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           insetPadding: EdgeInsets.zero,
//           child: Container(
//             height: 365,
//             width: double.infinity,
//             margin: const EdgeInsets.only(left: 42, right: 51),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: AppColors.whiteColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 65,
//                   width: 65,
//                   margin: const EdgeInsets.only(top: 48),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.primaryColor,
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.check,
//                       color: AppColors.whiteColor,
//                       size: 40,
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   AppStrings.congratulation,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.blackColor,
//                   ),
//                 ).paddingOnly(top: 16, bottom: 16),
//                 const Text(
//                   AppStrings.congratulationSubText,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryColor,
//                   ),
//                 ).paddingOnly(left: 27, right: 27, bottom: 25),
//                 RotationTransition(
//                   turns: controller,
//                   filterQuality: FilterQuality.high,
//                   child: Image.asset(
//                     Assets.cupertinoLoader,
//                     height: 45,
//                     width: 45,
//                     filterQuality: FilterQuality.high,
//                   ),
//                 ),
//                 const SizedBox(height: 46)
//               ],
//             ),
//           ),
//         );
//       });
// }
