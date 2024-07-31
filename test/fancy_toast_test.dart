import 'package:flutter_test/flutter_test.dart';
import 'package:fancy_toast/fancy_toast.dart';
import 'package:fancy_toast/fancy_toast_platform_interface.dart';
import 'package:fancy_toast/fancy_toast_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFancyToastPlatform
    with MockPlatformInterfaceMixin
    implements FancyToastPlatform {

  @override
  Future<void> showTextToast(String message, {ToastPosition position = ToastPosition.bottom}) {
    // TODO: implement showTextToast
    throw UnimplementedError();
  }

  @override
  Future<void> showIconToast(String message, ToastType type, {ToastPosition position = ToastPosition.center}) {
    // TODO: implement showIconToast
    throw UnimplementedError();
  }

  @override
  Future<void> showLoadingToast(String message, {ToastPosition position = ToastPosition.center}) {
    // TODO: implement showLoadingToast
    throw UnimplementedError();
  }

  @override
  Future<void> hideToast() {
    // TODO: implement showLoadingToast
    throw UnimplementedError();
  }

  

}

void main() {
  final FancyToastPlatform initialPlatform = FancyToastPlatform.instance;

  test('$MethodChannelFancyToast is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFancyToast>());
  });

}
