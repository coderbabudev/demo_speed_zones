import 'package:demo_speed_zones/src/constants/color_constant.dart';
import 'package:demo_speed_zones/src/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.whiteColor),
      home: const SplashScreen(),
    );
  }
}
