import 'package:demo_speed_zones/core/constants/color_constant.dart';
import 'package:demo_speed_zones/features/splash/presentation/pages/splash_screen.dart';
import 'package:demo_speed_zones/injection_container/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Speed & Zones',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Outfit',
        appBarTheme:
            const AppBarTheme(backgroundColor: ColorConstant.whiteColor),
        primaryColor: ColorConstant.primaryColor,
        scaffoldBackgroundColor: ColorConstant.primaryColor,
        useMaterial3: false,
      ),
      home: const SplashScreen(),
    );
  }
}
