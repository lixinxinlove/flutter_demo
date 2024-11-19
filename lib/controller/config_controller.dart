import 'package:get/get.dart';

///demo test
class ConfigController extends GetxController {
  var appVersion = "1.0.0".obs;

  setAppVersion(String v) {
    appVersion.value = v;
    update();
  }

  @override
  void onInit() {
    print("ConfigController-->onInit()");
    super.onInit();
  }

  @override
  void onReady() {
    print("ConfigController-->onReady()");
    super.onReady();
  }

  @override
  void onClose() {
    print("ConfigController-->onClose()");
    super.onClose();
  }
}
