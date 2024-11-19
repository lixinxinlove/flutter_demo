import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/address_controller.dart';

class AddressPage extends GetView<AddressController> {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AddressController());

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.address.length,
                itemBuilder: (context, index) =>
                    itemView(controller.address[index]),
              ),
            ),
          ),
          Center(
            child: FilledButton(
                onPressed: () {
                  controller.address.add("address");
                },
                child: Text("添加地址")),
          )
        ],
      ),
    );
  }

  Widget itemView(String text) {
    return Text(text);
  }
}
