
//
//  FancyToastPlugin.kt
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/27.
//
package com.example.fancy_toast

import com.example.fancytoast.FancyToastManager

import android.app.Activity
import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FancyToastPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {

  private lateinit var channel: MethodChannel
  private lateinit var context: Context
  private var activity: Activity? = null

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, "fancy_toast")
    channel.setMethodCallHandler(this)
    context = binding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "showTextToast" -> {
        val message = call.argument<String>("message")
        val position = call.argument<String>("position") ?: "center"
        if (message != null) {
          val ctx = activity ?: context
          FancyToastManager.instance.showToast(ctx, message, position)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Message argument is missing", null)
        }
      }
      "showIconToast" -> {
        val message = call.argument<String>("message")
        val typeIndex = call.argument<Int>("type")
        val position = call.argument<String>("position") ?: "center"
        if (message != null && typeIndex != null) {
          val style = FancyToastManager.ToastStyle.values().getOrNull(typeIndex)
          if (style != null) {
            val ctx = activity ?: context
            FancyToastManager.instance.showIconToast(ctx, message, style, position)
            result.success(null)
          } else {
            result.error("INVALID_ARGUMENT", "Invalid style type", null)
          }
        } else {
          result.error("INVALID_ARGUMENT", "Message or type argument is missing", null)
        }
      }
      "showLoadingToast" -> {
        val message = call.argument<String>("message")
        val position = call.argument<String>("position") ?: "center"
        if (message != null) {
          val ctx = activity ?: context
          FancyToastManager.instance.showLoading(ctx, message, position)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Message argument is missing", null)
        }
      }
      "hideToast" -> {
        FancyToastManager.instance.dismissActiveToast()
        result.success(null)
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }
}