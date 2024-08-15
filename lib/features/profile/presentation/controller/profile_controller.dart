import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/firebase_db/firebase_db.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/profile/presentation/model/language_model.dart';
import 'package:demo_speed_zones/features/profile/presentation/model/setting_feature_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  RxBool isLoading = false.obs;
  RxString countryCode = '91'.obs;
  String initialCountryCode = 'IN';
  RxBool showOldPassword = false.obs;
  RxBool showConfirmPassword = false.obs;
  final firebaseDBMethod = DatabaseMethod();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  RxString confirmPassword = ''.obs;
  RxString oldPassword = ''.obs;
  RxString newPassword = ''.obs;

  @override
  void onInit() {
    generateMainFeature();
    generateOtherFeature();
    showAllLanguages();
    fetchUserDetails();
    super.onInit();
  }

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

  Future<void> changePassword() async {
    oldPassword.value = oldPasswordController.text.trim();
    newPassword.value = newPasswordController.text.trim();
    confirmPassword.value = confirmPasswordController.text.trim();

    isLoading.value = true;
    if (oldPassword.value.isNotEmpty &&
        newPassword.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        confirmPassword.value == newPassword.value &&
        newPassword.value.length > 6) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          AuthCredential credential = EmailAuthProvider.credential(
            email: user.email.toString(),
            password: oldPasswordController.text.trim(),
          );
          await user.reauthenticateWithCredential(credential);
          await firebaseDBMethod.updatePassword(newPasswordController.text);
          showMessageSnackBar(StringConstant.passwordChangedSuccessfully);
          clearController();
        } on FirebaseAuthException catch (e) {
          showMessageSnackBar(e.message ?? 'Failed to change password');
        }
      }
      isLoading.value = false;
      update();
    } else {
      isLoading.value = false;
      if (oldPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.oldPasswordFieldIsRequired);
      } else if (newPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.newPasswordFieldIsRequired);
      } else if (confirmPassword.value.isEmpty) {
        showMessageSnackBar(StringConstant.confirmPasswordFieldIsRequired);
      } else if (confirmPassword.value != newPassword.value) {
        showMessageSnackBar(StringConstant.confirmPasswordDoesNotMatch);
      } else if (newPassword.value.length < 6) {
        showMessageSnackBar(StringConstant.passwordMustBeLongerThan6Characters);
      } else {}
      // update();
    }
    update();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
    update();
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    try {
      Map<String, dynamic> updates = {};
      if (imageFile.value != null) {
        String imageUrl = await uploadImageToFirebase(imageFile.value!);
        updates['image_url'] = imageUrl; // Add new image URL to updates
      }

      String phoneNumber = phoneNumberController.text.trim();
      if (phoneNumber.isNotEmpty) {
        updates['phone'] = phoneNumber;
        updates['country_code'] = countryCode.value;
      }
      if (updates.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .update(updates);
      }
      isLoading.value = false;
      showMessageSnackBar('Profile updated successfully');
    } catch (e) {
      isLoading.value = false;
      debugPrint('${StringConstant.failedToUploadImage}$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    Reference storageRef = FirebaseStorage.instance.ref().child(
        'images/${auth.currentUser?.uid}/${imageFile.path.split('/').last}.jpg');

    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }

  Future<Map<String, dynamic>?> fetchUserDetails() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return null;
      }
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(currentUser.uid).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
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

  clearController() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    update();
  }
}
