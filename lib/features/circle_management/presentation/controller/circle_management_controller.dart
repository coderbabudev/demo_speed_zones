import 'dart:io';
import 'dart:math';

import 'package:demo_speed_zones/core/firebase_db/firebase_db.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/model/circle_manage_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CircleManagementController extends GetxController {
  RxnInt selectedRole = RxnInt();
  final inviteCodeController = TextEditingController();
  final circleNameController = TextEditingController();
  RxBool isLoading = false.obs;
  final db = DatabaseMethod();
  RxString inviteCode = ''.obs;
  final List<String> roleList = [
    'Mom',
    'Dad',
    'Son / Daughter / Child',
    'Grandparent',
    'Partner / Spouse',
    'Friend',
    'Other',
  ];
  var isAllFieldsFilled = false.obs;
  var imageFile = Rxn<File>();

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
    update();
  }

  Future<void> createCircleGroup(String circleName) async {
    String currentDate =
        DateFormat('yyyy MMMM dd, hh:mm a').format(DateTime.now());
    Circle circleData = Circle(
      circleName: circleName.toString(),
      circleInviteCode: inviteCode.value,
      createdAt: currentDate,
    );
    await db.createCircle(circleData);
    circleNameController.clear();
  }

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

  @override
  void onClose() {
    inviteCodeController.removeListener(_onCodeChanged);
    inviteCodeController.dispose();
    circleNameController.dispose();
    super.onClose();
  }
}
