import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/image_constant.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/widget/bottm_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      bottomNavigationBar: Container(
        height: 76,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: ColorConstant.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFB8B8D2),
              offset: Offset(0, 2),
              blurRadius: 15,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => dashboardController.pageIndex.value = 0,
                child: Obx(
                  () => BottomNavBarWidget(
                    border: dashboardController.pageIndex.value == 0
                        ? const Border(
                            bottom: BorderSide(
                              width: 3,
                              color: ColorConstant.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          )
                        : null,
                    gradient: dashboardController.pageIndex.value == 0
                        ? LinearGradient(
                            colors: [
                              ColorConstant.primaryColor.withOpacity(0.5),
                              ColorConstant.whiteColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          )
                        : null,
                    icon: IconConstant.home,
                    title: "Home",
                    iconColor: dashboardController.pageIndex.value == 0
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                    textColor: dashboardController.pageIndex.value == 0
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => dashboardController.pageIndex.value = 1,
                child: Obx(
                  () => BottomNavBarWidget(
                    border: dashboardController.pageIndex.value == 1
                        ? const Border(
                            bottom: BorderSide(
                              width: 3,
                              color: ColorConstant.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          )
                        : null,
                    gradient: dashboardController.pageIndex.value == 1
                        ? LinearGradient(
                            colors: [
                              ColorConstant.primaryColor.withOpacity(0.5),
                              ColorConstant.whiteColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          )
                        : null,
                    icon: IconConstant.circles,
                    title: "Circles",
                    iconColor: dashboardController.pageIndex.value == 1
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                    textColor: dashboardController.pageIndex.value == 1
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => dashboardController.pageIndex.value = 2,
                child: Obx(
                  () => BottomNavBarWidget(
                    border: dashboardController.pageIndex.value == 2
                        ? const Border(
                            bottom: BorderSide(
                              width: 3,
                              color: ColorConstant.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          )
                        : null,
                    gradient: dashboardController.pageIndex.value == 2
                        ? LinearGradient(
                            colors: [
                              ColorConstant.primaryColor.withOpacity(0.5),
                              ColorConstant.whiteColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          )
                        : null,
                    icon: IconConstant.places,
                    title: "Places",
                    iconColor: dashboardController.pageIndex.value == 2
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                    textColor: dashboardController.pageIndex.value == 2
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => dashboardController.pageIndex.value = 3,
                child: Obx(
                  () => BottomNavBarWidget(
                    border: dashboardController.pageIndex.value == 3
                        ? const Border(
                            bottom: BorderSide(
                              width: 3,
                              color: ColorConstant.primaryColor,
                              style: BorderStyle.solid,
                            ),
                          )
                        : null,
                    gradient: dashboardController.pageIndex.value == 3
                        ? LinearGradient(
                            colors: [
                              ColorConstant.primaryColor.withOpacity(0.5),
                              ColorConstant.whiteColor.withOpacity(0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                          )
                        : null,
                    icon: IconConstant.profile,
                    title: "Profile",
                    iconColor: dashboardController.pageIndex.value == 3
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                    textColor: dashboardController.pageIndex.value == 3
                        ? ColorConstant.primaryColor
                        : ColorConstant.grey50,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: dashboardController.pageIndex.value,
          children: dashboardController.pages,
        ),
      ),
    );
  }
}
