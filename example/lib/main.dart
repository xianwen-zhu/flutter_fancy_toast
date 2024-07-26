import 'package:fancy_toast/fancy_toast_method_channel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fancy_toast/fancy_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _fancyToastPlugin = FancyToast();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // 初始化或其他平台相关的操作
  }

  void _showTextToast() {
    _fancyToastPlugin.showTextToast('这是一个简单的文字 Toast');
  }

  void _showIconToast() {
    _fancyToastPlugin.showIconToast("上传成功", ToastType.success);
  }

  void _showLoadingToast() {
    _fancyToastPlugin.showLoadingToast('正在加载');

    // 设置一个定时器，五秒钟后调用 _hideToast
    Timer(Duration(seconds: 5), () {
      _hideToast();
    });
  }

  void _hideToast() {
    _fancyToastPlugin.hideToast();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fancy Toast Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _showTextToast,
                child: Text('显示纯文本 Toast'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showIconToast,
                child: Text('显示带图标的 Toast'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showLoadingToast,
                child: Text('显示loading'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}