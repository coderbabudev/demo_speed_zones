import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/add_change_photo_screen.dart';
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
  int? selectedRole;
  final List<String> roleList = [
    'Mom',
    'Dad',
    'Son / Daughter / Child',
    'Grandparent',
    'Partner / Spouse',
    'Friend',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            const Text(
              AppStrings.describeYourRole,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(left: 37, top: 31, right: 38, bottom: 50),
            ...List.generate(
              roleList.length,
              (index) => GestureDetector(
                onTap: () async {
                  setState(() {
                    selectedRole = index;
                  });
                  await Future.delayed(const Duration(seconds: 1), () {
                    Get.to(() => const SelectProfilePictureScreen());
                  });
                },
                child: Container(
                  height: 56,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: selectedRole == index
                        ? AppColors.whiteColor
                        : AppColors.primaryColor,
                    border: Border.all(
                      width: selectedRole == index ? 2 : 1,
                      style: BorderStyle.solid,
                      color: selectedRole == index
                          ? AppColors.blackColor
                          : AppColors.whiteColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      roleList[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: selectedRole == index
                            ? AppColors.blackTextColor
                            : AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
