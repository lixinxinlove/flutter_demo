import 'package:flutter/services.dart';

class BasicMessageChannelDemo {
  static const _channel = BasicMessageChannel("messageChannel", StringCodec());

  BasicMessageChannelDemo._internal();

  static final BasicMessageChannelDemo _instance =
      BasicMessageChannelDemo._internal();

  factory BasicMessageChannelDemo() => _instance;

  initBasicMessageChannel() {
    ///接受信息
    _channel.setMessageHandler((msg) async {
      print("收到原生平台的消息:$msg");
      return "msg";
    });
  }

  ///给原生发送消息
  void sendMeg() async {
    String? msg = await _channel.send("holle ios android");
    print("收到答复：$msg");
  }
}
