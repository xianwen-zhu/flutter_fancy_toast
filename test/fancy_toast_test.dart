import 'package:flutter_test/flutter_test.dart';
import 'package:fancy_toast/fancy_toast.dart';
import 'package:fancy_toast/fancy_toast_platform_interface.dart';
import 'package:fancy_toast/fancy_toast_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFancyToastPlatform
    with MockPlatformInterfaceMixin
    implements FancyToastPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> showCustomToast(String message, String style) {
    // TODO: implement showCustomToast
    throw UnimplementedError();
  }

  @override
  Future<void> showIconToast(String message, String icon) {
    // TODO: implement showIconToast
    throw UnimplementedError();
  }

  @override
  Future<void> showTextToast(String message) {
    // TODO: implement showTextToast
    throw UnimplementedError();
  }

  

}

void main() {
  final FancyToastPlatform initialPlatform = FancyToastPlatform.instance;

  test('$MethodChannelFancyToast is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFancyToast>());
  });

}
