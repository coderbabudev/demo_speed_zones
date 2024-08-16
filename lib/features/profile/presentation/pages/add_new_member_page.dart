import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewMemberPage extends StatefulWidget {
  const AddNewMemberPage({
    super.key,
    required this.circleName,
    required this.circleId,
  });

  final String circleName;
  final String circleId;

  @override
  State<AddNewMemberPage> createState() => _AddNewMemberPageState();
}

class _AddNewMemberPageState extends State<AddNewMemberPage> {
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileController.fetchCircleMembers(widget.circleId);
  }

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
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          widget.circleName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: ColorConstant.blackTextColor,
          ),
        ).paddingOnly(top: 20),
      ),
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: profileController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : profileController.circleMembersList.isEmpty
                      ? const Center(
                          child: Text("No Members Found."),
                        )
                      : ListView.builder(
                          itemCount: profileController.circleMembersList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 30,
                          ),
                          itemBuilder: (context, index) {
                            final member =
                                profileController.circleMembersList[index];
                            final bool isOwner =
                                member['circle_admin_uid'] ?? false;
                            return Container(
                              padding:
                                  const EdgeInsets.only(bottom: 15, top: 15),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: ColorConstant.lightGreyColor,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: member['image_url'] == null
                                        ? Image.asset(
                                            ImageConstant.dummyUser,
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: member['image_url'],
                                            placeholder: (context, state) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            fit: BoxFit.cover,
                                            filterQuality: FilterQuality.high,
                                            height: 50,
                                            width: 50,
                                          ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          member['name'] ?? '',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: ColorConstant.blackTextColor,
                                          ),
                                        ),
                                        Text(
                                          member['email'] ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: ColorConstant.blackTextColor,
                                          ),
                                        ),
                                        const Text(
                                          "Since 7:36 pm yesterday",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: ColorConstant.blackTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!isOwner) ...[
                                    Image.asset(
                                      IconConstant.bookmark,
                                      height: 24,
                                      width: 24,
                                      filterQuality: FilterQuality.high,
                                    ),
                                    const SizedBox(width: 20),
                                    Image.asset(
                                      IconConstant.delete,
                                      height: 24,
                                      width: 24,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ]
                                ],
                              ),
                            );
                          },
                        ),
            );
          }),
          AuthenticateButton(
            name: StringConstant.addNewMember,
            onPress: () {},
            image: '',
            color: ColorConstant.primaryColor,
            textColor: ColorConstant.whiteColor,
          ).paddingOnly(bottom: 30, left: 24, right: 24),
        ],
      ),
    );
  }
}
