import 'package:flutter_demo/manger/hive/bean/user_bean.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveManger {
  HiveManger._();

  static final HiveManger _instance = HiveManger._();

  factory HiveManger() => _instance;

  init() async {
    await Hive.initFlutter();
  }

  void openUser() async {
   // Hive.registerAdapter<UserBean>(UserBeanA);
    await Hive.openBox<UserBean>('user');
  }
}
