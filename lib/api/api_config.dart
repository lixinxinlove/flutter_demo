import 'package:flutter/foundation.dart';

/// 接口(域名和环境)配置
class ApiConfig {
  /// 是否是生产环境
  // static const baseUrl = kReleaseMode ? releaseBaseUrl : testBaseUrl;
  static const baseUrl = releaseBaseUrl;

  /// 接口版本配置
  static const String apiVersion = "v45/";

  /// 生产环境域名
  static const String releaseBaseUrl = "https://phapi.playhiveltd.net/";

  /// 测试环境域名
  static const String testBaseUrl = "https://phapi.playhiveltd.net/";

  /// =========================  接口url   =========================



  ///01、生成访客用户（appId = 20001）
  static const String visitorLoginUrl = "api/noauth/ph/user/visitor";

  ///02、用户登录（appId = 20001）
  static const String reLoginUrl = "api/noauth/ph/user/login";

  /// 03、更新用户最后活跃的ip和登录时间
  static const String ipActiveUrl = "api/ph/user/ipactive";

  /// 04、获取个人信息（vip到期时间、头像、用户id...）
  static const String userInfoUrl = "api/ph/user/vipendtime";

  /// 05、上传图片
  static const String uploadImage = "api/ph/upload";


  ///06 07


  /// 08、adjust 客户端install回调数据上报（app上报）（注册成功后上报）
  static const String adjustUploadUrl = "api/ph/landingpagerecord";

  ///11、批量上报埋点日志
  static const String eventLogUrl = "api/ph/eventlog";

  ///12、添加反馈
  static const String feedbackSystemLogUrl = "api/ph/feedbacklog";
  ///13、添加系统反馈
  static const String feedbackListUrl = "api/ph/feedbacksystemlog";

  /// 14、上报埋点日志（页面耗时事件）
  static const String eventPageLogUrl = "api/ph/eventpagelog";

  /// 15、更新用户设备令牌
  static const String updateDeviceTokenUrl = "api/ph/user/devicetoken";

  ///16、更新推送通知记录
  static const String sendNotificationRecordUrl = "api/ph/sendnotificationrecord";

  /// 17、获取app版本配置-v3
  static const String appVersionConfigV3Url = "api/noauth/v3/appversionconfig";

  /// 18、获取app版本配置-v3（测试接口）
  static const String appVersionConfigTestV3Url = "api/noauth/v3/appversionconfig/test";

  ///19、系统反馈列表
  static const String feedbackSystemLogList = "api/ph/feedbacksystemlog";

  ///20、任务列表  （play 页面  游戏页面）
  static const String taskUrl = "api/ph/task";

  ///21、登录白名单校验
  static const String whiteListUrl = "api/ph/whitelist/login";

  ///22、添加工具反馈
  static const String feedbackToolLogUrl = "api/ph/feedbacktoollog";

  ///23、用户提现
  static const String payoutUrl = "api/ph/payout";

  ///24、用户渠道列表
  static const String userChannelUrl = "api/ph/userchannel";

  ///26、用户提现记录列表
  static const String payoutListUrl = "api/ph/payout";






}
