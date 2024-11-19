class AppInfoModel {
  AppInfoModel({
    this.appName = '',
    this.visitorId = '',
    this.ipActive = '',
    this.appVerRegister = '',
    this.appVerLast = '',
    this.appVersion = '',
    this.appBuildVerRegister = '',
    this.appBuildVerLast = '',
    this.appBuildVersion = '',
    this.os = 0,
    this.country = '',
    this.net = '',
    this.ipRegister = '',
    this.ua = '',
    this.model = '',
    this.uuid = '',
    this.sysVer = '',
    this.sysLanguage = '',
    this.language = '',
    this.sysArea = '',
    this.resolution = '',
    this.sourceType = 0,
    this.installTime = '',
    this.brand = '',
    this.latlng = '',
    this.isPhysicalDevice = false,
  });

  AppInfoModel.fromJson(dynamic json) {
    appName = json['appName'] ?? '';
    visitorId = json['visitorId'] ?? '';
    ipActive = json['ipActive'] ?? '';
    appVerRegister = json['appVerRegister'] ?? '';
    appVerLast = json['appVerLast'] ?? '';
    appVerLast = json['appVerLast'] ?? '';
    appBuildVerRegister = json['appBuildVerRegister'] ?? '';
    appBuildVerLast = json['appBuildVerLast'] ?? '';
    appBuildVersion = json['appBuildVersion'] ?? '';
    os = json['os'] ?? 0;
    country = json['country'] ?? '';
    net = json['net'] ?? '';
    ipRegister = json['ipRegister'] ?? '';
    ua = json['ua'] ?? '';
    model = json['model'] ?? '';
    uuid = json['uuid'] ?? '';
    sysVer = json['sysVer'] ?? '';
    sysLanguage = json['sysLanguage'] ?? '';
    language = json['language'] ?? '';
    sysArea = json['sysArea'] ?? '';
    resolution = json['resolution'] ?? '';
    sourceType = json['sourceType'] ?? 0;
    installTime = json['installTime'] ?? '';
    latlng = json['latlng'] ?? '';
    isPhysicalDevice = json['isPhysicalDevice'] ?? false;
  }

  String appName = '';
  String visitorId = '';
  String ipActive = '';
  String appVerRegister = '';
  String appVerLast = '';
  String appVersion = '';
  String appBuildVerRegister = '';
  String appBuildVerLast = '0';
  String appBuildVersion = '0';
  int os = 0;
  String country = '';
  String net = 'wifi';
  String ipRegister = '';
  String ua = '';
  String model = '';
  String uuid = '';
  String sysVer = '';
  String sysLanguage = '';
  String language = '';
  String sysArea = '';
  String resolution = '';
  int sourceType = 0;
  String installTime = '';
  String brand = '';
  String latlng = '';
  bool isPhysicalDevice = false; //是否是模拟器

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['appName'] = appName;
    map['visitorId'] = visitorId;
    map['ipActive'] = ipActive;
    map['appVerRegister'] = appVerRegister;
    map['appVerLast'] = appVerLast;
    map['appVersion'] = appVersion;
    map['appBuildVerRegister'] = appBuildVerRegister;
    map['appBuildVerLast'] = appBuildVerLast;
    map['appBuildVersion'] = appBuildVersion;
    map['os'] = os;
    map['country'] = country;
    map['net'] = net;
    map['ipRegister'] = ipRegister;
    map['ua'] = ua;
    map['model'] = model;
    map['uuid'] = uuid;
    map['sysVer'] = sysVer;
    map['sysLanguage'] = sysLanguage;
    map['language'] = language;
    map['sysArea'] = sysArea;
    map['resolution'] = resolution;
    map['sourceType'] = sourceType;
    map['installTime'] = installTime;
    map['brand'] = brand;
    map['latlng'] = latlng;
    map['isPhysicalDevice'] = isPhysicalDevice;
    return map;
  }
}
