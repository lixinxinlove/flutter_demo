import 'package:flutter/material.dart';
import 'package:get/get.dart';

///中间件
class AddressMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    //判断
    print(route);
    return null;
    return const RouteSettings(name: "/login",arguments: {
      "userName":"lixinxin",
      "password":"8888888"
    });
  }
}
