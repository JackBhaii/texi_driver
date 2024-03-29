

import 'package:driver/controller/profile_controller.dart';
import 'package:get/get.dart';

import 'document_controller.dart';
import 'user_controller.dart';
import 'vehicle_info_controller.dart';

class BindingController implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleController>(() => VehicleController(),fenix: false);
    Get.lazyPut<UserController>(() => UserController(),fenix: false);
    Get.lazyPut<DocumentController>(() => DocumentController(),fenix: false);
    Get.lazyPut<ProfileController>(() => ProfileController(),fenix: false);



  }

}