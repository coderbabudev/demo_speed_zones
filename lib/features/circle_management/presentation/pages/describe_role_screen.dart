import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/add_change_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DescribeRoleInCircleScreen extends StatefulWidget {
  const DescribeRoleInCircleScreen({super.key});

  @override
  State<DescribeRoleInCircleScreen> createState() =>
      _DescribeRoleInCircleScreenState();
}

class _DescribeRoleInCircleScreenState
    extends State<DescribeRoleInCircleScreen> {
  final describeRole = Get.find<CircleManagementController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              StringConstant.describeYourRole,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(left: 37, top: 20, right: 38, bottom: 50),
            ...List.generate(
              describeRole.roleList.length,
              (index) => GestureDetector(
                onTap: () async {
                  describeRole.selectedRole.value = index;

                  await Future.delayed(const Duration(milliseconds: 300), () {
                    Get.to(() => const SelectProfilePictureScreen());
                  });
                },
                child: Obx(() {
                  return Container(
                    height: 56,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 16),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: describeRole.selectedRole.value == index
                          ? ColorConstant.whiteColor
                          : ColorConstant.primaryColor,
                      border: Border.all(
                        width: describeRole.selectedRole.value == index ? 2 : 1,
                        style: BorderStyle.solid,
                        color: describeRole.selectedRole.value == index
                            ? ColorConstant.blackColor
                            : ColorConstant.whiteColor,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        describeRole.roleList[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: describeRole.selectedRole.value == index
                              ? ColorConstant.blackTextColor
                              : ColorConstant.whiteColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
