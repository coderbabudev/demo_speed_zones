import 'dart:io';

import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/notification_premission_request_screen.dart';
import 'package:demo_speed_zones/src/widget/animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/authentication_button.dart';

class SelectProfilePictureScreen extends StatefulWidget {
  const SelectProfilePictureScreen({super.key});

  @override
  State<SelectProfilePictureScreen> createState() =>
      _SelectProfilePictureScreenState();
}

class _SelectProfilePictureScreenState
    extends State<SelectProfilePictureScreen> {
  File? imageFile;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

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
                AppStrings.addPhoto,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppColors.whiteColor,
                ),
              ),
            ).paddingOnly(top: 31),
            const Text(
              AppStrings.addPhotoSubText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
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
                      Assets.photoBg,
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
                    color: AppColors.whiteColor,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 132,
                    width: 132,
                    margin: EdgeInsets.zero,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGreyColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imageFile != null
                          ? AnimationWidget(
                              animationType: "FADE",
                              child: Image.file(
                                imageFile!,
                                height: 75,
                                width: 60,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                Assets.noneUser,
                                height: 75,
                                width: 60,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                    ),
                  ),
                ),
                Image.asset(
                  Assets.triangle,
                  height: 17,
                  width: 24,
                  filterQuality: FilterQuality.high,
                ).paddingOnly(top: 140)
              ],
            ),
            AuthenticateButton(
              image: Assets.choosePhoto,
              textColor: AppColors.blackTextColor,
              color: AppColors.whiteColor,
              onPress: () => pickImage(),
              name: AppStrings.addPhoto,
            ).paddingOnly(top: 35, bottom: 38, left: 24, right: 24),
            AuthenticateButton(
              image: "",
              textColor: AppColors.blackTextColor,
              onPress: imageFile == null ? () {} : () {},
              color: imageFile == null
                  ? const Color(0xFFA7A9B7).withOpacity(0.3)
                  : AppColors.whiteColor,
              name: AppStrings.continueText,
            ).paddingOnly(top: 90, bottom: 20, left: 24, right: 24),
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
                        color: AppColors.whiteColor,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                  backgroundColor: Colors.transparent,
                  shadowColor: const Color(0xFFA7A9B7).withOpacity(0.3)),
              child: const Text(
                AppStrings.skip,
                style: TextStyle(
                  color: AppColors.whiteColor,
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
