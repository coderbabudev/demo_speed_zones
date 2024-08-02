import 'package:demo_speed_zones/injection_container/injects/inject_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Controllers
  InjectableControllers.inject();
}
