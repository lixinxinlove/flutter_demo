import 'package:get/get.dart';

import '../controller/config_controller.dart';
///
class AllBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfigController>(() => ConfigController());
  }
}
