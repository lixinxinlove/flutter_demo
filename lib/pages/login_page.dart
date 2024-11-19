import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/config_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ConfigController configController = Get.find<ConfigController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final arg = Get.arguments;
    print(arg['userName']);
    print(arg['password']);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text("Login${configController.appVersion}"),
          )
        ],
      ),
    );
  }
}
