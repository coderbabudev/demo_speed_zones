import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/animation_widget.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  final languageController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Center(
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
        ),
        titleSpacing: 35,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          StringConstant.selectLanguage,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: ColorConstant.blackTextColor,
          ),
        ).paddingOnly(top: 20),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: languageController.languageList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final languageData = languageController.languageList[index];
              return AnimationWidget(
                animationType: "FADE",
                child: GestureDetector(
                  onTap: () =>
                      languageController.selectedLanguage.value = index,
                  child: Obx(() {
                    return Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorConstant.lightGreyColor,
                        border:
                            languageController.selectedLanguage.value == index
                                ? Border.all(
                                    color: ColorConstant.secondaryColor,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  )
                                : null,
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          languageData.image,
                          height: 18,
                          width: 24,
                          filterQuality: FilterQuality.high,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        trailing: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: languageController.selectedLanguage.value ==
                                    index
                                ? ColorConstant.primaryColor
                                : Colors.transparent,
                            border: languageController.selectedLanguage.value ==
                                    index
                                ? null
                                : Border.all(
                                    color: ColorConstant.secondaryColor,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                          ),
                          child:
                              languageController.selectedLanguage.value == index
                                  ? const Center(
                                      child: Icon(
                                        Icons.check,
                                        size: 18,
                                        color: ColorConstant.whiteColor,
                                      ),
                                    )
                                  : null,
                        ),
                        title: Text(
                          languageData.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.blackTextColor,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
