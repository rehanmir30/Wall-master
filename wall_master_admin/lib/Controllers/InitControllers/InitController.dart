import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wall_master_admin/Controllers/AuthenticationController.dart';
import 'package:wall_master_admin/Controllers/CategoryController.dart';
import '../CommonController.dart';
import '../LocalizationController.dart';

class InitController with Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(Localization(),permanent: true);
    Get.put(CommonController(),permanent: true);
    Get.put(CategoryController(),permanent: true);
    Get.put(AuthenticationController(),permanent: true);


  }

}