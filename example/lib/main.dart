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
    _fancyToastPlugin.showIconToast('这是一个带图标的 Toast', 'icon_name');
  }

  void _showCustomToast() {
    _fancyToastPlugin.showCustomToast('这是一个自定义样式的 Toast', 'custom_style');
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
                onPressed: _showCustomToast,
                child: Text('显示自定义样式的 Toast'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}