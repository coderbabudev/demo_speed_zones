// import 'package:demo_speed_zones/src/constants/color_constant.dart';
// import 'package:demo_speed_zones/src/constants/string_constants.dart';
// import 'package:demo_speed_zones/src/utils/util.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FaceRecognitionScreen extends StatefulWidget {
//   const FaceRecognitionScreen({super.key});
//
//   @override
//   State<FaceRecognitionScreen> createState() => _FaceRecognitionScreenState();
// }
//
// class _FaceRecognitionScreenState extends State<FaceRecognitionScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat(); // Repeats the animation indefinitely
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 backButton(),
//                 const Text(
//                   AppStrings.faceRecognition,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.blackColor,
//                   ),
//                 ),
//                 const Text(
//                   AppStrings.faceRecognitionSubText,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.secondaryColor,
//                   ),
//                 ).paddingOnly(top: 17),
//                 // Expanded(
//                 //   child: Container(
//                 //     margin: const EdgeInsets.symmetric(vertical: 10),
//                 //     child: ,
//                 //   ),
//                 // ),
//                 const Spacer(),
//                 const Center(
//                   child: Text(
//                     "100%",
//                     style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 40,
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 ),
//                 const Center(
//                   child: Text(
//                     "Verifying your face...",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 18,
//                         color: AppColors.whiteColor,
//                         height: 0),
//                   ),
//                 ),
//                 const SizedBox(height: 37),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           showCongratulationDialog(
//                               context, animationController);
//                         },
//                         child: Container(
//                           height: 56,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(100),
//                               color: const Color(0xFFE8EFFF)),
//                           child: const Center(
//                             child: Text(
//                               AppStrings.skip,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16,
//                                 color: AppColors.primaryColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         height: 56,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: const Color(0xFF405DF7),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             AppStrings.continueText,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 16,
//                               color: AppColors.whiteColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ).paddingAll(20)
//           ],
//         ),
//       ),
//     );
//   }
// }
