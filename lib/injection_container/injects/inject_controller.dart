import 'package:demo_speed_zones/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/change_password_controller.dart';
import 'package:demo_speed_zones/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';

class InjectableControllers {
  InjectableControllers.inject() {
    Get
      ..lazyPut<DashboardController>(DashboardController.new, fenix: true)
      ..lazyPut<ProfileController>(
        ProfileController.new,
        fenix: true,
      )
      ..lazyPut<ChangePasswordController>(
        ChangePasswordController.new,
        fenix: true,
      );
  }
}
