import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    /// 跨端交互的方法通道
    var channel: FlutterMethodChannel?
    
    
    private var eventSink: FlutterEventSink?
    
    override func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // 注册监听来自flutter调用的处理器
        registerListenFlutterCall()
        
        
        ///EventChannel IOS 单向给Flutter 发送数据
        let controller = window?.rootViewController as! FlutterViewController
        let eventChannel = FlutterEventChannel(name: "eventChannel", binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(self)
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    

    
}



///EventChannel IOS 单向给Flutter 发送数据
extension AppDelegate : FlutterStreamHandler{
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
           self.eventSink = events

           // 模拟定时发送事件
           Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { timer in
               if let sink = self.eventSink {
                   sink("Current time: \(Date())")
               }
           }
           return nil
       }

       func onCancel(withArguments arguments: Any?) -> FlutterError? {
           self.eventSink = nil
           return nil
       }
}






private extension AppDelegate{
    
    /// 获取方法通道
    func methodChannel() -> FlutterMethodChannel {
        if let channel = channel  {
            return channel
        }

        let controller = window?.rootViewController as! FlutterViewController
        let channelName = "methodChannel"
        channel = FlutterMethodChannel(name: channelName,binaryMessenger: controller.binaryMessenger)
        return channel!
    }
    
    
    /// 调Flutter的方法
    /// - Parameters:
    ///   - method: 方法名称
    ///   - arguments: json数据内容
    private func callFlutterMethod(method: ChannelMethodEnum, arguments: String) {
        methodChannel().invokeMethod(method.toStr(), arguments: arguments)
    }
    
    
    /// 注册监听来自flutter调用的处理器
    func registerListenFlutterCall() {
        methodChannel().setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            print("来自flutter的调用\n method: \(call.method)\n arguments: \(call.arguments)");
            let method = ChannelMethodEnum.fromStr(call.method)
            switch method {
            case .appInstallTime:
                self.handleGetAppInstallTime(call: call, result: result)
                
                
                callFlutterMethod(method: .getFlutterVersion, arguments: "ios_version:100")
                
                break
            case .registerNotification:
                self.handleRegisterNotifications()
                break
            default:
                result(FlutterMethodNotImplemented)
                break
            }
        }
        
        
        
    
    }
    
    
    /// 处理获取APP安装事件事件
    func handleGetAppInstallTime(call: FlutterMethodCall, result: @escaping FlutterResult) {
        var installDate: Date?
        if let urlToDocumentsFolder = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            installDate = try? FileManager.default.attributesOfItem(atPath: urlToDocumentsFolder.path)[.creationDate] as? Date
        }

        if let installTime = installDate {
            result("\(installTime)")
        } else {
            result("0")
        }
    }

    /// 处理注册消息推送事件
    func handleRegisterNotifications() {
        //registerNotifications()
    }
    
    
}




enum ChannelMethodEnum:String{
    ///调用Flutter的方法
    case notifiationToken = "notificationToken"
    case registerNotification = "registerNotification"
    case getFlutterVersion = "getFlutterVersion"
    
    ///Fltter调用ios的方法
    case appInstallTime = "appInstallTime"
    
    
    // 未知的方法
    case unknown = "unknown"

    static func fromStr(_ methodName: String) -> ChannelMethodEnum {
        return ChannelMethodEnum(rawValue: methodName) ?? .unknown
    }

    func toStr() -> String {
        return self.rawValue
    }
    
}
