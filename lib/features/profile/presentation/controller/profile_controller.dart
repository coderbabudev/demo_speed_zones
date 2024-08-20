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
  RxString countryCode = ''.obs;
  RxString countryFlag = ''.obs;
  List<Map<String, dynamic>> circleMembersList = [];
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
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhoneNumber = ''.obs;
  RxString userImage = ''.obs;

  @override
  void onInit() {
    generateMainFeature();
    generateOtherFeature();
    showAllLanguages();
    fetchUserDetails();
    clearController();
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
          showMessageSnackBar(
              bgColor: Colors.green,
              StringConstant.passwordChangedSuccessfully);
          clearController();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            showMessageSnackBar(StringConstant.oldPasswordWasIncorrect);
          } else if (e.code == 'requires-recent-login') {
            showMessageSnackBar(
                StringConstant.pleaseLogInAgainToUpdateYourPassword);
          } else {
            showMessageSnackBar('Error: ${e.message}');
          }
        } catch (e) {
          showMessageSnackBar('${StringConstant.anErrorOccurred}$e');
        } finally {
          isLoading.value = false;
          update();
        }
      } else {
        showMessageSnackBar(StringConstant.noUserIsCurrentlyLoggedIn);
        isLoading.value = false;
        update();
      }
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
        Reference storageRef = FirebaseStorage.instance.ref().child(
            'images/${auth.currentUser?.uid}/${imageFile.value!.path.split('/').last}');

        UploadTask uploadTask = storageRef.putFile(imageFile.value!);
        TaskSnapshot snapshot = await uploadTask;

        String imageUrl = await snapshot.ref.getDownloadURL();
        updates['image_url'] = imageUrl;
      }

      String phoneNumber = phoneNumberController.text.trim();
      if (phoneNumber.isNotEmpty ||
          countryFlag.isNotEmpty ||
          countryCode.isNotEmpty) {
        updates['phone'] = phoneNumber;
        updates['country_flag'] = countryFlag.value;
        updates['country_code'] = '+${countryCode.value}';
      }
      if (updates.isNotEmpty) {
        updates['updated_at'] = updateDate;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .update(updates);
      }
      isLoading.value = false;
      showMessageSnackBar(
          bgColor: Colors.green, StringConstant.profileUpdatedSuccessfully);
    } catch (e) {
      isLoading.value = false;
      debugPrint('${StringConstant.failedToUploadImage}$e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> fetchUserDetails() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser == null) {
        return null;
      }
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(currentUser.uid).get();

      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final phoneNumber = userData['phone'].toString();
        userName.value = userData['name'] ?? '';
        userEmail.value = userData['email'] ?? '';
        userImage.value = userData['image_url'] ?? '';
        countryFlag.value = userData['country_flag'] ?? '';
        countryCode.value = userData['country_code'] ?? '';
        phoneNumberController.text = userData['phone'] ?? '';
        if (phoneNumber.length >= 10) {
          userPhoneNumber.value =
              '${userData['country_code']} ${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
        }
        update();
      } else {
        return null;
      }
    } catch (e) {
      print('${StringConstant.errorFetchingUserDetails}$e');
      return null;
    }
    update();
  }

  Future<void> fetchCircleMembers(String circleId) async {
    isLoading.value = true;
    try {
      circleMembersList.clear();

      DocumentSnapshot circleSnapshot =
          await firestore.collection('circles').doc(circleId).get();

      if (circleSnapshot.exists) {
        List<dynamic> members = circleSnapshot['circle_members'];
        String ownerId = circleSnapshot['circle_admin_uid'];

        List<Map<String, dynamic>> tempMembersList = [];

        for (String userId in members) {
          DocumentSnapshot userSnapshot =
              await firestore.collection('users').doc(userId).get();

          if (userSnapshot.exists) {
            Map<String, dynamic> userData =
                userSnapshot.data() as Map<String, dynamic>;

            userData['circle_admin_uid'] = userId == ownerId;

            tempMembersList.add(userData);
          }
        }
        Map<String, dynamic>? ownerData;
        tempMembersList.removeWhere((member) {
          if (member['circle_admin_uid'] == true) {
            ownerData = member;
            return true;
          }
          return false;
        });

        if (ownerData != null) {
          circleMembersList.insert(0, ownerData!);
        }
        circleMembersList.addAll(tempMembersList);

        isLoading.value = false;
        update();
      }
    } catch (e) {
      isLoading.value = false;
      print('${StringConstant.errorFetchingMembers}$e');
    }
  }

  Future<void> deleteCircleMember(int index, circleId) async {
    isLoading.value = true;
    try {
      circleMembersList.removeAt(index);
      final docRef = firestore.collection('circles').doc(circleId);
      final docSnap = await docRef.get();
      List queue = docSnap.get('circle_members');
      docRef.update({
        "circle_members": FieldValue.arrayRemove([queue[index]])
      });
      isLoading.value = false;
    } catch (e) {
      showMessageSnackBar(e.toString());
    }
  }

  generateMainFeature() {
    mainFeature.addAll([
      SettingFeature(
        image: IconConstant.editProfile,
        title: StringConstant.editProfile,
      ),
      SettingFeature(
        image: IconConstant.security,
        title: StringConstant.changePassword,
      ),
      SettingFeature(
        image: IconConstant.circleManagement,
        title: StringConstant.circleManagement,
      ),
    ]);
    update();
  }

  generateOtherFeature() {
    otherFeature.addAll([
      SettingFeature(
        image: IconConstant.language,
        title: StringConstant.languages,
      ),
      SettingFeature(
        image: IconConstant.faq,
        title: StringConstant.fAQ,
      ),
      SettingFeature(
        image: IconConstant.termsAndCondition,
        title: StringConstant.termsOfService,
      ),
      SettingFeature(
        image: IconConstant.privacyPolicy,
        title: StringConstant.privacyPolicy,
      ),
      SettingFeature(
        image: IconConstant.zendeskHelp,
        title: StringConstant.zendeskHelp,
      ),
      SettingFeature(
        image: IconConstant.smartNotify,
        title: StringConstant.smartNotifications,
      ),
    ]);
    update();
  }

  showAllLanguages() {
    languageList.addAll([
      Languages(image: IconConstant.englishLng, title: StringConstant.english),
      Languages(
          image: IconConstant.indonesianLng, title: StringConstant.indonesia),
      Languages(image: IconConstant.germanyLng, title: StringConstant.deutsch),
      Languages(image: IconConstant.franceLng, title: StringConstant.french),
      Languages(image: IconConstant.spainLng, title: StringConstant.spanish),
    ]);
  }

  clearController() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    update();
  }
}
