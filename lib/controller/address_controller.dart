import 'package:get/get.dart';

///地址
class AddressController extends GetxController {

  RxList<String> address = <String>[].obs;

  addAddress() {
    address.add("address");
    update();
  }
}
