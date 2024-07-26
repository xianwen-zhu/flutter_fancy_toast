//
//  FancyToastPlugin.swift
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//
import Flutter
import UIKit

public class FancyToastPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fancy_toast", binaryMessenger: registrar.messenger())
        let instance = FancyToastPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "showTextToast":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String {
                FancyToastManager.shared.showToast(message: message)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showTextToast", details: nil))
            }
            
        case "showIconToast":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String,
               let typeIndex = args["type"] as? Int,
               let type = ToastView.ToastType(rawValue: typeIndex) {
                FancyToastManager.shared.showToast(message: message, style: type)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showIconToast", details: nil))
            }
            
        case "showLoadingToast":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String {
                FancyToastManager.shared.showLoading(message: message)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showLoadingToast", details: nil))
            }
            
        case "hideToast":
                FancyToastManager.shared.dismissActiveToast()

            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
