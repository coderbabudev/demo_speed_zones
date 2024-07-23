import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/widget/login_View_widget.dart';
import 'package:demo_speed_zones/src/widget/register_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({super.key});

  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 40,
                width: 40,
                margin: const EdgeInsets.only(top: 15, bottom: 32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondaryColor,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: AppColors.whiteColor,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  splashBorderRadius: BorderRadius.circular(25.0),
                  indicatorPadding: const EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.blackColor,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: AppColors.secondaryColor,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: AppStrings.logIn),
                    Tab(text: AppStrings.register),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  LoginView(),
                  RegisterView(),
                ],
              ),
            )
          ],
        ).paddingAll(20),
      ),
    );
  }
}
