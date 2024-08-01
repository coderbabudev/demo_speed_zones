import 'dart:math';

import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/constants/string_constants.dart';
import 'package:demo_speed_zones/src/views/describe_role_screen.dart';
import 'package:demo_speed_zones/src/widget/authentication_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareInviteCodeScreen extends StatefulWidget {
  const ShareInviteCodeScreen({super.key, required this.circleName});

  final String circleName;

  @override
  State<ShareInviteCodeScreen> createState() => _ShareInviteCodeScreenState();
}

class _ShareInviteCodeScreenState extends State<ShareInviteCodeScreen> {
  String inviteCode = '';

  @override
  void initState() {
    super.initState();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final random = Random();
    setState(() {
      inviteCode = String.fromCharCodes(
        Iterable.generate(6, (_) => characters.codeUnitAt(random.nextInt(26))),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: const Text(
                AppStrings.shareInviteCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  height: 1.2,
                  color: AppColors.whiteColor,
                ),
              ).paddingOnly(top: 31),
            ),
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.lightGreyColor,
              ),
              padding: const EdgeInsets.only(
                  top: 25, bottom: 61, left: 46, right: 45),
              child: Text(
                inviteCode,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                  letterSpacing: 15,
                ),
              ),
            ),
            const Text(
              AppStrings.shareInviteCodeTipText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ).paddingOnly(top: 220, left: 37, right: 38),
            const AuthenticateButton(
              image: "",
              textColor: AppColors.blackTextColor,
              color: AppColors.whiteColor,
              name: AppStrings.shareCode,
            ).paddingOnly(top: 50, bottom: 20, left: 24, right: 24),
            ElevatedButton(
              onPressed: () => Get.to(() => DescribeRoleInCircleScreen()),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 56),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                  visualDensity: VisualDensity.comfortable,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        color: AppColors.whiteColor,
                        style: BorderStyle.solid,
                        width: 1,
                      )),
                  backgroundColor: Colors.transparent,
                  shadowColor: const Color(0xFFA7A9B7).withOpacity(0.3)),
              child: const Text(
                AppStrings.codeShareDone,
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ).paddingOnly(left: 24, right: 24, bottom: 38),
          ],
        ),
      ),
    );
  }
}
