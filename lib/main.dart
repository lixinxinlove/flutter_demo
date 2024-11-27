import 'package:flutter/material.dart';
import 'package:flutter_demo/router/routers.dart';
import 'package:get/get.dart';


import 'binding/binding.dart';
import 'channel/basic_message_channel_demo.dart';
import 'channel/event_channel_demo.dart';
import 'channel/method_channel_demo.dart';
import 'db/database.dart';
import 'db/tables.dart';
import 'manger/app_info/app_info_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await XCache.preInit();



  final database = AppDatabase();

  await database.into(database.todoItem).insert(TodoItemCompanion.insert(
    title: 'todo: finish drift setup',
    content: 'We can now write queries and define our own tables.',
  ));
  List<TodoItemData> allItems = await database.select(database.todoItem).get();

  print('items in database: $allItems');


  if (GetPlatform.isMobile) {
    await AppInfoManager().init();
  }

//  await MethodChannelManager().init();
  //await UserManager.init();

  Future.delayed(Duration.zero, () {
    if (GetPlatform.isMobile) {
      ///三种通信方式
      BasicMessageChannelDemo().initBasicMessageChannel();
      EventChannelDemo().initEventChannel();
      MethodChannelDemo().initMethodChannel();
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: AllBinding(),

      ///全局绑定 GetXController
      defaultTransition: Transition.downToUp,
      getPages: Routers.routers,
      initialRoute: "/",
    );
  }
}
