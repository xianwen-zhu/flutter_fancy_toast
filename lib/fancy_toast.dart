
import 'fancy_toast_platform_interface.dart';

class FancyToast {
  Future<void> showTextToast(String message) {
    return FancyToastPlatform.instance.showTextToast(message);
  }

  Future<void> showIconToast(String message, String icon) {
    return FancyToastPlatform.instance.showIconToast(message, icon);
  }

  Future<void> showCustomToast(String message, String style) {
    return FancyToastPlatform.instance.showCustomToast(message, style);
  }
}
