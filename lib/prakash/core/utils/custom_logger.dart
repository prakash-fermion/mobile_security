import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class CustomLogger {
  CustomLogger._privateConstructor();

  static final CustomLogger _instance = CustomLogger._privateConstructor();

  factory CustomLogger() {
    return _instance;
  }

  static log(String message, {String level = 'INFO'}) {
    final timestamp = DateTime.now().toIso8601String();
    developer.log('[$timestamp][$level] $message');
  }

  static void info(String message) {
    log(message, level: 'INFO');
    debugPrint(message);
  }

  static void warning(String message) {
    log(message, level: 'WARNING');
  }

  static error(String message) {
    log(message, level: 'ERROR');
  }
}
