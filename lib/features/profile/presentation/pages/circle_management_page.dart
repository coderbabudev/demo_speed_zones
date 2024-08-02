import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/profile/presentation/pages/add_new_member_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleManagementScreen extends StatefulWidget {
  const CircleManagementScreen({super.key});

  @override
  State<CircleManagementScreen> createState() => _CircleManagementScreenState();
}

class _CircleManagementScreenState extends State<CircleManagementScreen> {
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
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          StringConstant.circleManagement,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 24,
            color: ColorConstant.blackTextColor,
          ),
        ).paddingOnly(top: 20),
        titleSpacing: 35,
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: 18,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 25, right: 25),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => const AddNewMemberPage(
                        circleName: "Friends",
                      ),
                    );
                  },
                  child: Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorConstant.lightGreyColor,
                    ),
                    child: const Center(
                      child: Text(
                        "My Family",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: ColorConstant.blackTextColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          const AuthenticateButton(
            image: "",
            textColor: ColorConstant.whiteColor,
            color: ColorConstant.primaryColor,
            name: StringConstant.createCircle,
          ).paddingSymmetric(horizontal: 24),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstant.whiteColor,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFFA7A9B7).withOpacity(0.3),
                      blurRadius: 40,
                      offset: const Offset(0, 4))
                ]),
            child: const Center(
              child: Text(
                StringConstant.joinCircle,
                style: TextStyle(
                  color: ColorConstant.blackTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ).paddingOnly(left: 25, right: 25, bottom: 25, top: 20),
        ],
      ),
    );
  }
}
