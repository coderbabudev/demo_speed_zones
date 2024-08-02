import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/utils/util.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/login_View_widget.dart';
import 'package:demo_speed_zones/features/auth/presentation/widget/register_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({super.key, this.isWhichFrom = false});

  final bool isWhichFrom;

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
    if (widget.isWhichFrom) {
      tabController.index = 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            backButton(onTap: () => Get.back()),
            Center(
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstant.lightGreyColor,
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: ColorConstant.whiteColor,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  splashBorderRadius: BorderRadius.circular(25.0),
                  indicatorPadding: const EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: ColorConstant.blackColor,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: ColorConstant.secondaryColor,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  tabs: const [
                    Tab(text: StringConstant.logIn),
                    Tab(text: StringConstant.register),
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
