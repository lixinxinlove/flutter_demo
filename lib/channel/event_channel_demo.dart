import 'package:flutter/services.dart';

class EventChannelDemo {

  ///1.创建EventChannel 通道
  static const _channel = EventChannel("eventChannel");

  EventChannelDemo._internal();

  static final EventChannelDemo _instance =
  EventChannelDemo._internal();

  factory EventChannelDemo() => _instance;

  initEventChannel() {
    ///2.接受信息
    _channel.receiveBroadcastStream().listen((dynamic event) {
      print("收到原生数据：$event");
    }, onError: (error) {
      print("收到原生数据：error");
    }, cancelOnError: true);
  }

}
