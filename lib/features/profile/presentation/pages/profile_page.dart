import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/change_password_page.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/choose_language_page.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/circle_management_page.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: Center(
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(left: 20, top: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorConstant.secondaryColor,
              ),
            ),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 20,
              color: ColorConstant.blackColor,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          StringConstant.profile,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstant.blackTextColor),
        ).paddingOnly(top: 20),
        titleSpacing: 35,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.centerLeft,
            children: [
              Image.asset(
                ImageConstant.userInfoBg,
                height: 72,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                children: [
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: profileController.userImage.value.isEmpty
                            ? Image.asset(
                                ImageConstant.dummyUser,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              )
                            : AnimationWidget(
                                animationType: "FADE",
                                child: CachedNetworkImage(
                                  imageUrl: profileController.userImage.value,
                                  filterQuality: FilterQuality.high,
                                  height: 50,
                                  width: 50,
                                  placeholder: (context, state) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    );
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          profileController.userName.value,
                          style: const TextStyle(
                            color: ColorConstant.whiteColor,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                      Obx(() {
                        return Text(
                          profileController.userPhoneNumber.value,
                          style: TextStyle(
                            color: ColorConstant.whiteColor.withOpacity(0.5),
                            fontSize: 13,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                    ],
                  )
                ],
              )
            ],
          ),
          const Text(
            StringConstant.accountSetting,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstant.blackTextColor,
            ),
          ).paddingOnly(top: 17, bottom: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: profileController.mainFeature.length,
            itemBuilder: (context, index) {
              final data = profileController.mainFeature[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Get.to(() => const EditProfileScreen());
                  } else if (index == 1) {
                    Get.to(() => const ChangePasswordScreen());
                  } else {
                    Get.to(() => const CircleManagementScreen());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListTile(
                    visualDensity: VisualDensity.comfortable,
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.lightGreyColor),
                      child: Center(
                        child: Image.asset(
                          data.image,
                          height: 18,
                          width: 18,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                    title: Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.blackTextColor,
                      ),
                    ),
                    trailing: Image.asset(
                      IconConstant.arrowForward,
                      height: 24,
                      width: 24,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              );
            },
          ),
          const Text(
            StringConstant.other,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstant.blackTextColor,
            ),
          ).paddingOnly(top: 17, bottom: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: profileController.otherFeature.length,
            itemBuilder: (context, index) {
              final data = profileController.otherFeature[index];
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Get.to(() => const ChooseLanguageScreen());
                  } else if (index == 1) {
                  } else if (index == 2) {
                  } else if (index == 3) {
                    Get.to(() => const PrivacyPolicyPage());
                  } else if (index == 4) {
                  } else if (index == 5) {}
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstant.lightGreyColor),
                      child: Center(
                        child: Image.asset(
                          data.image,
                          height: 18,
                          width: 18,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                    title: Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstant.blackTextColor,
                      ),
                    ),
                    trailing: Image.asset(
                      IconConstant.arrowForward,
                      height: 24,
                      width: 24,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => logoutBottomSheet(),
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(double.infinity, 56),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
              visualDensity: VisualDensity.comfortable,
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(
                  color: ColorConstant.grey50,
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              StringConstant.logout,
              style: TextStyle(
                color: ColorConstant.redColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )
        ],
      ).paddingAll(20),
    );
  }
}
