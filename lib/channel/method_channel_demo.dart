import 'package:flutter/services.dart';

class MethodChannelDemo {
  ///1.创建EventChannel 通道
  static const _channel = MethodChannel("methodChannel");

  MethodChannelDemo._internal();

  static final MethodChannelDemo _instance = MethodChannelDemo._internal();

  factory MethodChannelDemo() => _instance;

  initMethodChannel() async {
    final Map<String, dynamic> map = {"name": "haha"};

    ///2.接受信息
    String version = await _channel.invokeMethod("getAppVersion", map);
    print(version);

    ///
    _channel.setMethodCallHandler((v) async {
      String funv = v.method;
    });
  }
}
