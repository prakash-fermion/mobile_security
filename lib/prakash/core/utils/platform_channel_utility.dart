import 'package:flutter/services.dart';
import 'package:mobile_security/prakash/core/utils/custom_logger.dart';

class PlatformChannelUtility {
  static const _channel = MethodChannel('com.fermion.mobilesecurity/channel');

  static Future<bool> isDebuggerAttached() async {
    try {
      final bool isDebugger = await _channel.invokeMethod('isDebuggerAttached');
      return isDebugger;
    } on PlatformException catch (e) {
      CustomLogger.error('Error checking debugger attachment: ${e.message}');
      return false;
    }
  }
}
