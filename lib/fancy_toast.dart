
import 'fancy_toast_method_channel.dart';
import 'fancy_toast_platform_interface.dart';

class FancyToast {
  Future<void> showTextToast(String message) {
    return FancyToastPlatform.instance.showTextToast(message);
  }

  Future<void> showIconToast(String message, ToastType type) {
    return FancyToastPlatform.instance.showIconToast(message, type);
  }

  Future<void> showLoadingToast(String message) {
    return FancyToastPlatform.instance.showLoadingToast(message);
  }

  Future<void> hideToast() {
    return FancyToastPlatform.instance.hideToast();
  }



}
