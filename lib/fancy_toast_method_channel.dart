import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fancy_toast_platform_interface.dart';

/// An implementation of [FancyToastPlatform] that uses method channels.
class MethodChannelFancyToast extends FancyToastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fancy_toast');


  /// Method to show a text toast
  @override
  Future<void> showTextToast(String message) async {
    await methodChannel.invokeMethod('showTextToast', {'message': message});
  }

  /// Method to show an icon toast
  @override
  Future<void> showIconToast(String message, String iconName) async {
    await methodChannel.invokeMethod('showIconToast', {
      'message': message,
      'iconName': iconName,
    });
  }

  /// Method to show a custom toast
  @override
  Future<void> showCustomToast(String message, String customStyle) async {
    await methodChannel.invokeMethod('showCustomToast', {
      'message': message,
      'customStyle': customStyle,
    });
  }
}