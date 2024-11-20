
import 'package:get/get.dart';

class StorageUtil {
  static StorageUtil? _instance;

  StorageUtil._();

  static StorageUtil instance() {
    return _instance ??= StorageUtil._();
  }

}
