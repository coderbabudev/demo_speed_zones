import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/firebase_db/firebase_db.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/model/circle_manage_model.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/describe_role_screen.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/pages/notification_premission_request_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CircleManagementController extends GetxController {
  RxnInt selectedRole = RxnInt();
  final inviteCodeController = TextEditingController();
  final circleNameController = TextEditingController();
  RxBool isLoading = false.obs;
  final db = DatabaseMethod();
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString inviteCode = ''.obs;
  var imageFile = Rxn<File>();
  RxBool isAllFieldsFilled = false.obs;
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
  void onInit() {
    super.onInit();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    inviteCode.value = String.fromCharCodes(
      Iterable.generate(6, (_) => characters.codeUnitAt(random.nextInt(26))),
    );
    inviteCodeController.addListener(_onCodeChanged);
  }

  void _onCodeChanged() {
    isAllFieldsFilled.value = inviteCodeController.text.length == 6;
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    } catch (e) {
      showMessageSnackBar(e.toString());
    }
    update();
  }

  Future<void> createCircleGroup(String circleName) async {
    Circle circleData = Circle(
      circleName: circleName.toString(),
      circleInviteCode: inviteCode.value,
      createdAt: currentDate,
    );
    isLoading.value = true;
    try {
      await db.createCircle(circleData);
      circleNameController.clear();
      isLoading.value = false;
      Get.to(() => const DescribeRoleInCircleScreen());
    } catch (e) {
      isLoading.value = false;
      showMessageSnackBar(e.toString());
    }
  }

  Future<void> uploadImage(File image) async {
    isLoading.value = true;
    try {
      final storageRef = FirebaseStorage.instance.ref().child(
          'images/${auth.currentUser?.uid}/${image.path.split('/').last}.jpg');
      final uploadTask = storageRef.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .update({'image_url': imageUrl});
      isLoading.value = false;
      Get.to(() => const NotificationPerRequestScreen());
    } catch (e) {
      isLoading.value = false;
      debugPrint('${StringConstant.failedToUploadImage}$e');
    }
  }

  Future<void> onSubmitCode(String inviteCode) async {
    isLoading.value = true;
    try {
      final circleDoc = await FirebaseFirestore.instance
          .collection('circles')
          .doc(inviteCode)
          .get();

      if (circleDoc.exists) {
        final List<dynamic> circleMembers =
            circleDoc.data()?['circle_members'] ?? [];
        final currentUserId = FirebaseAuth.instance.currentUser?.uid;

        if (!circleMembers.contains(currentUserId)) {
          circleMembers.add(currentUserId);
          await FirebaseFirestore.instance
              .collection('circles')
              .doc(inviteCode)
              .update({'circle_members': circleMembers});
          Get.to(() =>
              const DescribeRoleInCircleScreen()); // Navigate to another screen
        } else {
          showMessageSnackBar(StringConstant.userIsAlreadyPartOfThisCircle);
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
        showMessageSnackBar(StringConstant.invalidInviteCode);
      }
    } catch (e) {
      isLoading.value = false;
      showMessageSnackBar('${StringConstant.failedToJoinCircle}$e');
    }
  }

  @override
  void onClose() {
    inviteCodeController.removeListener(_onCodeChanged);
    inviteCodeController.dispose();
    circleNameController.dispose();
    super.onClose();
  }
}
