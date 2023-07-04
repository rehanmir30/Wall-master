import 'package:get/get.dart';
import 'package:wallmaster/Controllers/CommonController.dart';
import 'package:wallmaster/Controllers/LocalizationController.dart';

import '../AuthenticationController.dart';

class InitController with Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(Localization(),permanent: true);
    Get.put(CommonController(),permanent: true);
    Get.put(AuthenticationController(),permanent: true);


  }

}