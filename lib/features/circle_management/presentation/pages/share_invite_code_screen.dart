import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/core/constants/string_constants.dart';
import 'package:demo_speed_zones/core/presentation/widget/authentication_button.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareInviteCodeScreen extends StatefulWidget {
  const ShareInviteCodeScreen({
    super.key,
    required this.circleName,
    required this.whichFrom,
  });

  final String circleName;
  final String whichFrom;

  @override
  State<ShareInviteCodeScreen> createState() => _ShareInviteCodeScreenState();
}

class _ShareInviteCodeScreenState extends State<ShareInviteCodeScreen> {
  final circleController = Get.find<CircleManagementController>();

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
                StringConstant.shareInviteCode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  height: 1.2,
                  color: ColorConstant.whiteColor,
                ),
              ).paddingOnly(top: 31),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: ColorConstant.lightGreyColor,
              ),
              padding: const EdgeInsets.only(top: 25, bottom: 61, left: 46),
              child: Text(
                circleController.inviteCode.value,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: ColorConstant.blackTextColor,
                  letterSpacing: 20,
                ),
              ),
            ),
            const Text(
              StringConstant.shareInviteCodeTipText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorConstant.whiteColor,
              ),
            ).paddingOnly(top: 220, left: 37, right: 38),
            AuthenticateButton(
              image: "",
              onPress: () {
                Share.share(circleController.inviteCode.value);
              },
              textColor: ColorConstant.blackTextColor,
              color: ColorConstant.whiteColor,
              name: StringConstant.shareCode,
            ).paddingOnly(top: 50, bottom: 20, left: 24, right: 24),
            Obx(() {
              return ElevatedButton(
                onPressed: () async {
                  await circleController.createCircleGroup(
                    widget.circleName,
                    widget.whichFrom,
                  );
                },
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
                          color: ColorConstant.whiteColor,
                          style: BorderStyle.solid,
                          width: 1,
                        )),
                    backgroundColor: Colors.transparent,
                    shadowColor: const Color(0xFFA7A9B7).withOpacity(0.3)),
                child: circleController.isLoading.value
                    ? const CircularProgressIndicator(
                        color: ColorConstant.whiteColor)
                    : const Text(
                        StringConstant.codeShareDone,
                        style: TextStyle(
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
              );
            }).paddingOnly(left: 24, right: 24, bottom: 38),
          ],
        ),
      ),
    );
  }
}
