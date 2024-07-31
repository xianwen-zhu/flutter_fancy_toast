//
//  FancyToastPlatform.dart
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'fancy_toast_method_channel.dart';

abstract class FancyToastPlatform extends PlatformInterface {
  FancyToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static FancyToastPlatform _instance = MethodChannelFancyToast();

  static FancyToastPlatform get instance => _instance;

  static set instance(FancyToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> showTextToast(String message, {ToastPosition position = ToastPosition.bottom}) {
    throw UnimplementedError('showTextToast() has not been implemented.');
  }

  Future<void> showIconToast(String message, ToastType type, {ToastPosition position = ToastPosition.center}) {
    throw UnimplementedError('showIconToast() has not been implemented.');
  }

  Future<void> showLoadingToast(String message, {ToastPosition position = ToastPosition.center}) {
    throw UnimplementedError('showLoadingToast() has not been implemented.');
  }

  Future<void> hideToast() {
    throw UnimplementedError('hideToast() has not been implemented.');
  }
}