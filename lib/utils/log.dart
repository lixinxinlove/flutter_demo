import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// 控制台日志输出工具
class Log {
  static Logger logger = Logger(level: kReleaseMode ? Level.off : Level.debug);

  /// debug 日志
  static d(dynamic message) {
    try {
      logger.d(message);
    } catch (_) {}
  }

  /// error 日志
  static e(dynamic message) {
    try {
      logger.e(message);
    } catch (_) {}
  }

  static enableLog(bool enabled) {
    if (enabled) {
      Logger.level = Level.debug;
    } else {
      Logger.level = Level.off;
    }
  }
}
