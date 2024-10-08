import 'package:demo_speed_zones/features/auth/presentation/controller/auth_controller.dart';
import 'package:demo_speed_zones/features/circle_management/presentation/controller/circle_management_controller.dart';
import 'package:demo_speed_zones/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class InjectableControllers {
  InjectableControllers.inject() {
    Get
      ..put<AuthController>(AuthController(), permanent: true)
      ..put<CircleManagementController>(CircleManagementController(),
          permanent: true)
      ..put<DashboardController>(DashboardController(), permanent: true)
      ..put<ProfileController>(
        ProfileController(),
        permanent: true,
      );
  }
}
