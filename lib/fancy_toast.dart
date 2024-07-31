//
//  FancyToast.dart
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//

import 'fancy_toast_method_channel.dart';
import 'fancy_toast_platform_interface.dart';

class FancyToast {
  Future<void> showTextToast(String message, {ToastPosition position = ToastPosition.bottom}) {
    return FancyToastPlatform.instance.showTextToast(message, position: position);
  }

  Future<void> showIconToast(String message, ToastType type, {ToastPosition position = ToastPosition.center}) {
    return FancyToastPlatform.instance.showIconToast(message, type, position: position);
  }

  Future<void> showLoadingToast(String message, {ToastPosition position = ToastPosition.center}) {
    return FancyToastPlatform.instance.showLoadingToast(message, position: position);
  }

  Future<void> hideToast() {
    return FancyToastPlatform.instance.hideToast();
  }
}
