import 'dart:io';

import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/notification_premission_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/presentation/widget/authentication_button.dart';

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
      imageFile = File(pickedFile.path);
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
                StringConstant.addPhoto,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorConstant.whiteColor,
                ),
              ),
            ).paddingOnly(top: 31),
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
                                IconConstant.noneUser,
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
                  IconConstant.triangle,
                  height: 17,
                  width: 24,
                  filterQuality: FilterQuality.high,
                ).paddingOnly(top: 140)
              ],
            ),
            AuthenticateButton(
              image: IconConstant.choosePhoto,
              textColor: ColorConstant.blackTextColor,
              color: ColorConstant.whiteColor,
              onPress: () => pickImage(),
              name: StringConstant.addPhoto,
            ).paddingOnly(top: 35, bottom: 38, left: 24, right: 24),
            AuthenticateButton(
              image: "",
              textColor: ColorConstant.blackTextColor,
              onPress: imageFile == null ? () {} : () {},
              color: imageFile == null
                  ? const Color(0xFFA7A9B7).withOpacity(0.3)
                  : ColorConstant.whiteColor,
              name: StringConstant.continueText,
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
