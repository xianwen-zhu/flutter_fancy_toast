import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fancy_toast_method_channel.dart';

abstract class FancyToastPlatform extends PlatformInterface {
  /// Constructs a FancyToastPlatform.
  FancyToastPlatform() : super(token: _token);

  static final Object _token = Object();

  static FancyToastPlatform _instance = MethodChannelFancyToast();

  /// The default instance of [FancyToastPlatform] to use.
  ///
  /// Defaults to [MethodChannelFancyToast].
  static FancyToastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FancyToastPlatform] when
  /// they register themselves.
  static set instance(FancyToastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> showTextToast(String message) {
    throw UnimplementedError('showTextToast() has not been implemented.');
  }

  Future<void> showIconToast(String message, ToastType type) {
    throw UnimplementedError('showIconToast() has not been implemented.');
  }

  Future<void> showLoadingToast(String message) {
    throw UnimplementedError('showLoadingToast() has not been implemented.');
  }

  Future<void> hideToast() {
    throw UnimplementedError('hideToast() has not been implemented.');
  }




}

