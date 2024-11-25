import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:get/get.dart';

import 'package:locale_plus/locale_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../model/app_info_model.dart';
import '../../utils/log.dart';
import '../../utils/secure_storage.dart';

class AppInfoManager {
  AppInfoManager._internal();

  static final AppInfoManager _instance = AppInfoManager._internal();

  factory AppInfoManager() => _instance;

  AppInfoModel info = AppInfoModel();

  /// 分辨率上的宽高
  int? width;
  int? height;

  /// 设备推送token
  String? deviceToken;

  /// app启动是先初始化APP基本信息
  Future<void> init() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (GetPlatform.isMobile) {
      await FkUserAgent.init();
      String? webViewUserAgent = FkUserAgent.webViewUserAgent;
      if (webViewUserAgent != null) {
        info.ua = webViewUserAgent;
      }
    }

    if (Platform.isAndroid) {
      ///Android 设备信息
      ///获取设备保存的唯一ID
      ///
      ///
      AndroidId _androidIdPlugin = const AndroidId();
      String deviceId = await SecureStorage.instance().read("DEVICE_ID_KEY");

      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;

      print("**************AndroidDeviceInfo*****************");
      print(androidDeviceInfo.data);

      if (deviceId.isEmpty) {
        deviceId = await _androidIdPlugin.getId() ?? const Uuid().v4();
        await SecureStorage.instance().save("DEVICE_ID_KEY", deviceId);
        info.os = 1;
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      print("**************AAndroidPackageInfo*****************");
      print(packageInfo.data);

      ///sdkInt: 34, release: 14,

      final regionCode = await LocalePlus().getRegionCode();
      final languageCode = await LocalePlus().getLanguageCode();

      ///包名
      info.appName = packageInfo.packageName;
      info.country = regionCode ?? '';
      info.sysLanguage = languageCode ?? '';
      info.language = languageCode ?? '';
      info.sysVer = androidDeviceInfo.serialNumber;
      info.model = androidDeviceInfo.serialNumber;
      info.brand = "Android";

      info.visitorId = deviceId;
      info.appVerRegister = packageInfo.version;
      info.appVerLast = packageInfo.version;
      info.appVersion = packageInfo.version;
      info.appBuildVerRegister = packageInfo.buildNumber;
      info.appBuildVerLast = packageInfo.buildNumber;
      info.appBuildVersion = packageInfo.buildNumber;
      info.os = 1;
      info.net = 'wifi';
      info.uuid = deviceId;
    } else {
      ///获取设备保存的唯一ID
      String deviceId = await SecureStorage.instance().read("DEVICE_ID_KEY");
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;

      print(iosDeviceInfo.data);

      if (deviceId.isEmpty) {
        deviceId = iosDeviceInfo.identifierForVendor ?? const Uuid().v4();
        await SecureStorage.instance().save("DEVICE_ID_KEY", deviceId);

        info.os = 2;
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final regionCode = await LocalePlus().getRegionCode();
      final languageCode = await LocalePlus().getLanguageCode();

      ///包名
      info.appName = packageInfo.packageName;
      info.country = regionCode ?? '';
      info.sysLanguage = languageCode ?? '';
      info.language = languageCode ?? '';
      info.sysVer = iosDeviceInfo.systemVersion;
      info.model = modelWithIosMachine(iosDeviceInfo.utsname.machine);
      info.brand = "Apple";

      info.visitorId = deviceId;
      info.appVerRegister = packageInfo.version;
      info.appVerLast = packageInfo.version;
      info.appVersion = packageInfo.version;
      info.appBuildVerRegister = packageInfo.buildNumber;
      info.appBuildVerLast = packageInfo.buildNumber;
      info.appBuildVersion = packageInfo.buildNumber;
      info.os = 1;
      info.net = 'wifi';
      info.uuid = deviceId;
    }

    Log.d(info.toJson());
  }

  void updateResolution(int width, int height) {
    info.resolution = '$width*$height';
    this.width = width;
    this.height = height;
  }

  void updateInstallTime(String installTime) {
    info.installTime = installTime;
  }

  /// 获取iphone机型
  String modelWithIosMachine(String machine) {
    if (machine == "iPhone17,3") {
      return "iPhone 16";
    }
    if (machine == "iPhone17,4") {
      return "iPhone 16 Plus";
    }
    if (machine == "iPhone17,2") {
      return "iPhone 16 Pro Max";
    }
    if (machine == "iPhone17,1") {
      return "iPhone 16 Pro";
    }
    if (machine == "iPhone16,2") {
      return "iPhone 15 Pro Max";
    }
    if (machine == "iPhone16,1") {
      return "iPhone 15 Pro";
    }
    if (machine == "iPhone15,5") {
      return "iPhone 15 Plus";
    }
    if (machine == "iPhone15,4") {
      return "iPhone 15";
    }
    if (machine == "iPhone15,3") {
      return "iPhone 14 Pro Max";
    }
    if (machine == "iPhone15,2") {
      return "iPhone 14 Pro";
    }
    if (machine == "iPhone14,8") {
      return "iPhone 14 Plus";
    }
    if (machine == "iPhone14,7") {
      return "iPhone 14";
    }
    if (machine == "iPhone14,3") {
      return "iPhone 13 Pro Max";
    }
    if (machine == "iPhone14,2") {
      return "iPhone 13 Pro";
    }
    if (machine == "iPhone14,5") {
      return "iPhone 13";
    }
    if (machine == "iPhone14,4") {
      return "iPhone 13 mini";
    }
    if (machine == "iPhone13,4") {
      return "iPhone 12 Pro Max";
    }
    if (machine == "iPhone13,3") {
      return "iPhone 12 Pro";
    }
    if (machine == "iPhone13,2") {
      return "iPhone 12";
    }
    if (machine == "iPhone13,1") {
      return "iPhone 12 Mini";
    }

    if (machine == "iPhone12,1") {
      return "iPhone 11";
    }
    if (machine == "iPhone12,3") {
      return "iPhone 11 Pro";
    }
    if (machine == "iPhone12,5") {
      return "iPhone 11 Pro Max";
    }
    if (machine == "iPhone11,8") {
      return "iiPhone XR";
    }
    if (machine == "iPhone11,4") {
      return "iPhone XS MAX";
    }
    if (machine == "iPhone11,6") {
      return "iPhone XS MAX";
    }
    if (machine == "iPhone10,4") {
      return "iPhone 8";
    }
    if (machine == "iPhone14,6") {
      return "iPhone SE (3rd generation)";
    }
    if (machine == "iPhone12,8") {
      return "iPhone SE (2nd generation)";
    }
    if (machine == "iPhone8,4") {
      return "iPhone SE (1nd generation)";
    }
    return machine;
  }
}
