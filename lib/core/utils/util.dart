import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/features/profile/presentation/widget/logout_button_widget.dart';
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
          color: ColorConstant.whiteColor,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      backgroundColor: ColorConstant.redColor,
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
          color: ColorConstant.secondaryColor,
        ),
      ),
      child: Center(
        child: Icon(
          icon ?? Icons.arrow_back_rounded,
          size: 20,
          color: ColorConstant.blackColor,
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
        color: ColorConstant.blackColor,
        fontWeight: FontWeight.w500,
        fontFamily: 'Outfit',
      ),
      decoration: BoxDecoration(
        color: ColorConstant.lightGreyColor,
        borderRadius: BorderRadius.circular(8),
      ),
    );

logoutBottomSheet() {
  showModalBottomSheet(
    elevation: 0,
    context: Get.context!,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 260,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 134,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorConstant.grey50),
            ),
            const Text(
              StringConstant.logout,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: ColorConstant.redColor,
              ),
            ).paddingOnly(top: 18),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(
                thickness: 2,
                color: ColorConstant.lightGreyColor,
              ),
            ),
            const Text(
              StringConstant.logoutConfirmText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.blackTextColor,
              ),
            ).paddingOnly(bottom: 30),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const ButtonWidget(
                      title: StringConstant.skip,
                      textColor: ColorConstant.primaryColor,
                      bgColor: Color(0xFFE8EFFF),
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: const ButtonWidget(
                      title: StringConstant.continueText,
                      textColor: ColorConstant.whiteColor,
                      bgColor: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 24)
          ],
        ),
      );
    },
  );
}

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
//                 color: ColorConstant.whiteColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: 65,
//                   width: 65,
//                   margin: const EdgeInsets.only(top: 48),
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: ColorConstant.primaryColor,
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.check,
//                       color: ColorConstant.whiteColor,
//                       size: 40,
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   StringConstant.congratulation,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w500,
//                     color: ColorConstant.blackColor,
//                   ),
//                 ).paddingOnly(top: 16, bottom: 16),
//                 const Text(
//                   StringConstant.congratulationSubText,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: ColorConstant.secondaryColor,
//                   ),
//                 ).paddingOnly(left: 27, right: 27, bottom: 25),
//                 RotationTransition(
//                   turns: controller,
//                   filterQuality: FilterQuality.high,
//                   child: Image.asset(
//                     IconConstant.cupertinoLoader,
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
