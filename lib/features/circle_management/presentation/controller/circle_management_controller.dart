import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CircleManagementController extends GetxController {
  RxnInt selectedRole = RxnInt();
  final inviteCodeController = TextEditingController();
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

  @override
  void onInit() {
    super.onInit();
    inviteCodeController.addListener(_onCodeChanged);
  }

  void _onCodeChanged() {
    isAllFieldsFilled.value = inviteCodeController.text.length == 6;
  }

  @override
  void onClose() {
    inviteCodeController.removeListener(_onCodeChanged);
    inviteCodeController.dispose();
    super.onClose();
  }
}
