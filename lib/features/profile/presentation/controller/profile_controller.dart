import 'dart:io';

import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/features/profile/presentation/model/language_model.dart';
import 'package:demo_speed_zones/features/profile/presentation/model/setting_feature_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var mainFeature = [].obs;
  var otherFeature = [].obs;
  var languageList = [].obs;
  RxInt selectedLanguage = 0.obs;
  var imageFile = Rxn<File>();
  RxBool showNewPassword = false.obs;
  RxBool showOldPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  showHideOldPassword() {
    showOldPassword.value = !showOldPassword.value;
    update();
  }

  showHideNewPassword() {
    showNewPassword.value = !showNewPassword.value;
    update();
  }

  showHideConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
    update();
  }

  @override
  void onInit() {
    generateMainFeature();
    generateOtherFeature();
    showAllLanguages();
    super.onInit();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
    update();
  }

  generateMainFeature() {
    mainFeature.addAll([
      SettingFeature(
        image: IconConstant.editProfile,
        title: 'Edit Profile',
      ),
      SettingFeature(
        image: IconConstant.security,
        title: 'Change Password',
      ),
      SettingFeature(
        image: IconConstant.circleManagement,
        title: 'Circle Management',
      ),
    ]);
    update();
  }

  generateOtherFeature() {
    otherFeature.addAll([
      SettingFeature(
        image: IconConstant.language,
        title: 'Languages',
      ),
      SettingFeature(
        image: IconConstant.faq,
        title: 'FAQ',
      ),
      SettingFeature(
        image: IconConstant.termsAndCondition,
        title: 'Terms of service',
      ),
      SettingFeature(
        image: IconConstant.privacyPolicy,
        title: 'Privacy Policy',
      ),
      SettingFeature(
        image: IconConstant.zendeskHelp,
        title: 'Zendesk help',
      ),
      SettingFeature(
        image: IconConstant.smartNotify,
        title: 'Smart Notifications',
      ),
    ]);
    update();
  }

  showAllLanguages() {
    languageList.addAll([
      Languages(image: IconConstant.englishLng, title: 'English'),
      Languages(image: IconConstant.indonesianLng, title: 'Indonesia'),
      Languages(image: IconConstant.germanyLng, title: 'Deutsch'),
      Languages(image: IconConstant.franceLng, title: 'French'),
      Languages(image: IconConstant.spainLng, title: 'Spanish'),
    ]);
  }
}
