import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewMemberPage extends StatefulWidget {
  const AddNewMemberPage({super.key, required this.circleName});

  final String circleName;

  @override
  State<AddNewMemberPage> createState() => _AddNewMemberPageState();
}

class _AddNewMemberPageState extends State<AddNewMemberPage> {
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
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 15, top: 15),
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
                        child: Image.network(
                          "https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1722556800&semt=sph",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anna",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorConstant.blackTextColor,
                              ),
                            ),
                            Text(
                              "At Home",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: ColorConstant.blackTextColor,
                              ),
                            ),
                            Text(
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
                    ],
                  ),
                );
              },
            ),
          ),
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
