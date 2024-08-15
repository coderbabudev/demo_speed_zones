import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/notification_premission_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/widget/authentication_button.dart';

class SelectProfilePictureScreen extends StatefulWidget {
  const SelectProfilePictureScreen({super.key});

  @override
  State<SelectProfilePictureScreen> createState() =>
      _SelectProfilePictureScreenState();
}

class _SelectProfilePictureScreenState
    extends State<SelectProfilePictureScreen> {
  final circleManagementController = Get.find<CircleManagementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const Center(
              child: Text(
                StringConstant.addPhoto,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.whiteColor,
                ),
              ),
            ).paddingOnly(top: 16),
            const Text(
              StringConstant.addPhotoSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(left: 38, right: 37, top: 13, bottom: 50),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Image.asset(
                      ImageConstant.photoBg,
                      height: 200,
                      width: 207,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                Container(
                  height: 132,
                  width: 132,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.whiteColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 132,
                    width: 132,
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.lightGreyColor,
                    ),
                    child: Obx(() {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: circleManagementController.imageFile.value !=
                                null
                            ? AnimationWidget(
                                animationType: "FADE",
                                child: Image.file(
                                  circleManagementController.imageFile.value!,
                                  height: 75,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              )
                            : Center(
                                child: Image.asset(
                                  IconConstant.noneUser,
                                  height: 75,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                ),
                              ),
                      );
                    }),
                  ),
                ),
                Image.asset(
                  IconConstant.triangle,
                  height: 17,
                  width: 24,
                  filterQuality: FilterQuality.high,
                ).paddingOnly(top: 140)
              ],
            ),
            Obx(() {
              return AuthenticateButton(
                image: IconConstant.choosePhoto,
                textColor: ColorConstant.blackTextColor,
                color: ColorConstant.whiteColor,
                onPress: () => circleManagementController.pickImage(),
                name: circleManagementController.imageFile.value == null
                    ? StringConstant.addPhoto
                    : StringConstant.changePhoto,
              );
            }).paddingOnly(top: 35, bottom: 38, left: 24, right: 24),
            Obx(() {
              return AuthenticateButton(
                image: "",
                textColor: ColorConstant.blackTextColor,
                isLoader: circleManagementController.isLoading.value,
                isLoaderColor: ColorConstant.blackColor,
                onPress: circleManagementController.imageFile.value == null
                    ? () {}
                    : () async => await circleManagementController.uploadImage(
                        circleManagementController.imageFile.value!),
                color: circleManagementController.imageFile.value == null
                    ? const Color(0xFFA7A9B7).withOpacity(0.3)
                    : ColorConstant.whiteColor,
                name: StringConstant.continueText,
              );
            }).paddingOnly(top: 90, bottom: 20, left: 24, right: 24),
            ElevatedButton(
              onPressed: () =>
                  Get.to(() => const NotificationPerRequestScreen()),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 56),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                  visualDensity: VisualDensity.comfortable,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: ColorConstant.whiteColor,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                  backgroundColor: Colors.transparent,
                  shadowColor: const Color(0xFFA7A9B7).withOpacity(0.3)),
              child: const Text(
                StringConstant.skip,
                style: TextStyle(
                  color: ColorConstant.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ).paddingOnly(left: 24, right: 24, bottom: 38),
          ],
        ),
      ),
    );
  }
}
