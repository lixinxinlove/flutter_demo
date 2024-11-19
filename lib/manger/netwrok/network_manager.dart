import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  /// 网络连接
  final Connectivity _connectivity = Connectivity();

  /// 网络状态
  ConnectivityResult connectionStatus = ConnectivityResult.none;

  /// 记录APP启动后第几次切换到可用网络
  int availableCount = 0;

  /// 网络类型
  String networkType() {
    return connectionStatus.name;
  }

  /// 网络是否可用
  bool isAvailable() {
    if (connectionStatus == ConnectivityResult.none ||
        connectionStatus == ConnectivityResult.bluetooth) {
      return false;
    }
    return true;
  }

  /// 是否可连接VPN
  bool isVPN() {
    if (connectionStatus == ConnectivityResult.vpn) {
      return true;
    }
    return false;
  }

  /// 提供监听方法
  /// immediate：是否立即回调一次
  /// callback：网络状态变更的回调
  void listen(
      {bool immediate = true, required Function(NetworkManager) callback}) {
    if (immediate) {
      callback(this);
    }
    addListener(() {
      callback(this);
    });
  }

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();

    // 监听网络变更
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      _updateConnectionStatus(results.first);
    });
  }

  Future<void> _initConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    if (results.isNotEmpty) {
      _updateConnectionStatus(results.first);
      return;
    }

    _updateConnectionStatus(ConnectivityResult.none);
  }

  void _updateConnectionStatus(ConnectivityResult state) {
    if (connectionStatus == state) {
      return;
    }
    connectionStatus = state;

    // 记录切换成可用网络的次数
    if (isAvailable()) {
      availableCount += 1;
    }

    if (state == ConnectivityResult.vpn) {

    }

    update();
  }
}
