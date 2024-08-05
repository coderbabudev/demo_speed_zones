import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final profileController = Get.find<ProfileController>();

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
          StringConstant.editProfile,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: ColorConstant.blackTextColor),
        ).paddingOnly(top: 20),
        titleSpacing: 35,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const Center(
              child: Text(
                StringConstant.editProfileSubText,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorConstant.secondaryColor,
                ),
              ),
            ).paddingOnly(top: 15),
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.only(top: 25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorConstant.primaryColor,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Obx(() {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: profileController.imageFile.value != null
                          ? Image.file(
                              profileController.imageFile.value!,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                    );
                  }),
                ),
                GestureDetector(
                  onTap: () => profileController.pickImage(),
                  child: Container(
                    height: 32,
                    width: 32,
                    margin: const EdgeInsets.only(right: 1, bottom: 5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.primaryColor),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 15,
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Container(
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorConstant.lightGreyColor),
              child: Row(
                children: [
                  Image.asset(
                    IconConstant.enableUser,
                    height: 24,
                    width: 24,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Daniel Lawson',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.blackTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 56,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: ColorConstant.lightGreyColor),
              child: Row(
                children: [
                  Image.asset(
                    IconConstant.enableEmail,
                    height: 24,
                    width: 24,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'esmeralda@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.blackTextColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            IntlPhoneField(
              flagsButtonPadding: const EdgeInsets.all(8),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              dropdownIconPosition: IconPosition.trailing,
              dropdownIcon: const Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 25,
                color: ColorConstant.primaryColor,
              ),
              invalidNumberMessage: '',
              decoration: InputDecoration(
                hintText: StringConstant.mobileNumber,
                counterText: '',
                isDense: true,
                filled: true,
                fillColor: ColorConstant.lightGreyColor,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              initialCountryCode: 'IN',
              onCountryChanged: (Country country) {
                print(country.dialCode);
              },
              keyboardType: TextInputType.number,
            ).paddingSymmetric(horizontal: 24),
            const SizedBox(height: 210),
            AuthenticateButton(
              name: StringConstant.continueText,
              onPress: () {},
              image: '',
              color: ColorConstant.primaryColor,
              textColor: ColorConstant.whiteColor,
            ).paddingSymmetric(horizontal: 24, vertical: 20)
          ],
        ),
      ),
    );
  }
}
