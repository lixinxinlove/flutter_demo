import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/address');
                  },
                  child: Text("跳转到地址页面")),
            ],
          ),
          const Center(
            child: Text("Root"),
          )
        ],
      ),
    );
  }
}
