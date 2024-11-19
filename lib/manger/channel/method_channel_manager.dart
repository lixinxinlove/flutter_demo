import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../api/api.dart';

import '../../utils/log.dart';
import '../app_info/app_info_manager.dart';
import '../netwrok/network_manager.dart';

enum ChannelMethodEnum {
  /// 来自原生调用的方法
  notificationToken,
  notificationMessage,
  deeplink,
  /// 调原生的方法
  registerNotification,
  appInstallTime,
  /// 未知的方法
  unknown;

  static ChannelMethodEnum fromStr(String methodName) {
    switch (methodName) {
      case 'notificationToken':
        return ChannelMethodEnum.notificationToken;
      case 'notificationMessage':
        return ChannelMethodEnum.notificationMessage;
      case 'deeplink':
        return ChannelMethodEnum.deeplink;
      case 'registerNotification':
        return ChannelMethodEnum.registerNotification;
      case 'appInstallTime':
        return ChannelMethodEnum.appInstallTime;
      default:
        return ChannelMethodEnum.unknown;
    }
  }

  String toStr() {
    switch (this) {
      case ChannelMethodEnum.notificationToken:
        return 'notificationToken';
      case ChannelMethodEnum.notificationMessage:
        return 'notificationMessage';
      case ChannelMethodEnum.deeplink:
        return 'deeplink';
      case ChannelMethodEnum.registerNotification:
        return 'registerNotification';
      case ChannelMethodEnum.appInstallTime:
        return 'appInstallTime';
      default:
        return 'unknown';
    }
  }
}

/// Flutter和原生交互通道管理器
class MethodChannelManager {
  MethodChannelManager._internal();

  static final MethodChannelManager _instance =
      MethodChannelManager._internal();

  factory MethodChannelManager() => _instance;

  static const MethodChannel _channel =
      MethodChannel('com.xs.app/flutter_native');

  init() async {
    _registerListenNativeCall();
    await _callNativeGetAppInstallTime();
  }

  /// 调用原生的方法
  Future<T?> _callNativeMethod<T>(ChannelMethodEnum method,
      [dynamic arguments]) async {
    try {
      final T? result = await _channel.invokeMethod(method.toStr(), arguments);
      return result;
    } on PlatformException catch (e) {
      Log.e('调用原生方法失败 $method: ${e.message}');
      return null;
    }
  }

  /// 调用原生获取APP安装时间
  _callNativeGetAppInstallTime() async {
    var installTime =
        await _callNativeMethod<String>(ChannelMethodEnum.appInstallTime);
    Log.d("App---安装时间：$installTime");
    if (installTime != null && installTime != "0") {
      int index = installTime.indexOf("+");
      if (index != -1) {
        installTime = installTime.substring(0, index);
      }
      installTime = installTime.trim();
      AppInfoManager().info.installTime = installTime;
      return;
    }
  }

  /// 调用原生去注册消息推送.
  /// 当注册成功，原生回调_handleNotificationToken方法.
  callNativeRegisterNotification() async {
    await _callNativeMethod(ChannelMethodEnum.registerNotification);
  }

  /// 注册监听来自原生调用的处理器
  _registerListenNativeCall() {
    _channel.setMethodCallHandler((MethodCall call) async {
      Log.d("来自原生的调用\nmethod: ${call.method}\narguments: ${call.arguments}");
      final method = ChannelMethodEnum.fromStr(call.method);
      switch (method) {
        case ChannelMethodEnum.notificationToken:
          return _handleNotificationToken(call.arguments);
        case ChannelMethodEnum.notificationMessage:
          return _handleNotificationMessage(call.arguments);
        case ChannelMethodEnum.deeplink:
          return _handleDeeplink(call.arguments);
        default:
          throw MissingPluginException('原生调用的方法未实现: ${call.method}');
      }
    });
  }

  /// 处理推送token事件
  _handleNotificationToken(dynamic arguments) {
    if (arguments is! String || arguments.isEmpty) {
      Log.e('参数错误');
      return;
    }

    final network = Get.put(NetworkManager());


  }

  /// 处理推送消息事件
  _handleNotificationMessage(dynamic arguments) {
    if (arguments is! String || arguments.isEmpty) {
      Log.e('参数错误');
      return;
    }

    try {
      Map<String, dynamic> map = jsonDecode(arguments);
      // NotificationModel model = NotificationModel.fromJson(map);
      //
      // eventBus.fire(NotificationEvent(msg: "收得到通知"));
      //
      // Log.d("收到通知参数type= ${model.type}");
      // if (model.type == 3) {
      //   Api.sendNotificationRecordUrl(id: model.id ?? 0);
      // }
    } catch (e) {
      Log.e("收到通知参数type= $e");
    }
  }

  /// 处理路由深度链事件
  _handleDeeplink(dynamic arguments) {
    if (arguments is! String || arguments.isEmpty) {
      Log.e('参数错误');
      return;
    }


  }
}
