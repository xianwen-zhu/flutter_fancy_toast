package com.example.fancy_toast

import android.content.Context
import android.widget.Toast
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FancyToastPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel: MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(binding: FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "fancy_toast")
    channel.setMethodCallHandler(this)
    context = binding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "showTextToast" -> {
        val message = call.argument<String>("message")
        message?.let {
          Toast.makeText(context, it, Toast.LENGTH_SHORT).show()
        }
        result.success(null)
      }
      "showIconToast" -> {
        val message = call.argument<String>("message")
        // Here, you would need to handle showing an icon in the toast
        message?.let {
          Toast.makeText(context, it, Toast.LENGTH_SHORT).show()
        }
        result.success(null)
      }
      "showCustomToast" -> {
        val message = call.argument<String>("message")
        // Implement custom toast view here
        message?.let {
          Toast.makeText(context, it, Toast.LENGTH_SHORT).show()
        }
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}