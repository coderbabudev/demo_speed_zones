import 'package:demo_speed_zones/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxBool whichFrom = false.obs;
  RxInt pageIndex = 0.obs;

  List<Widget> pages = [
    const Center(child: Text("Home")),
    const Center(child: Text("Circles")),
    const Center(child: Text("Places")),
    const ProfilePage(),
  ];

  @override
  void onInit() {
    pageIndex.value = 0;
    super.onInit();
  }
}
