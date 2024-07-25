import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fancy_toast/fancy_toast_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFancyToast platform = MethodChannelFancyToast();
  const MethodChannel channel = MethodChannel('fancy_toast');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

}
