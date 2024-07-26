import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fancy_toast_platform_interface.dart';

/// An implementation of [FancyToastPlatform] that uses method channels.

enum ToastType {
  success,
  error,
  warning,
}
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
  Future<void> showIconToast(String message, ToastType type) async {
    await methodChannel.invokeMethod('showIconToast', {
      'message': message,
      'type': type.index, // Sending the index of the enum to native code
    });
  }

  /// Method to show an loading toast
  @override
  Future<void> showLoadingToast(String message) async {
    await methodChannel.invokeMethod('showLoadingToast', {
      'message': message,
    });
  }

  /// Method to show an hideToast
  @override
  Future<void> hideToast() async {
    await methodChannel.invokeMethod('hideToast', {
    });
  }


}