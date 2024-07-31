//
//  MethodChannelFancyToast.dart
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'fancy_toast_platform_interface.dart';

enum ToastType {
  success,
  error,
  warning,
}

enum ToastPosition {
  top,
  center,
  bottom,
}

class MethodChannelFancyToast extends FancyToastPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('fancy_toast');

  String _convertPositionToString(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return 'top';
      case ToastPosition.center:
        return 'center';
      case ToastPosition.bottom:
        return 'bottom';
      default:
        return 'center';
    }
  }

  @override
  Future<void> showTextToast(String message, {ToastPosition position = ToastPosition.center}) async {
    await methodChannel.invokeMethod('showTextToast', {
      'message': message,
      'position': _convertPositionToString(position),
    });
  }

  @override
  Future<void> showIconToast(String message, ToastType type, {ToastPosition position = ToastPosition.center}) async {
    await methodChannel.invokeMethod('showIconToast', {
      'message': message,
      'type': type.index,
      'position': _convertPositionToString(position),
    });
  }

  @override
  Future<void> showLoadingToast(String message, {ToastPosition position = ToastPosition.center}) async {
    await methodChannel.invokeMethod('showLoadingToast', {
      'message': message,
      'position': _convertPositionToString(position),
    });
  }

  @override
  Future<void> hideToast() async {
    await methodChannel.invokeMethod('hideToast');
  }
}