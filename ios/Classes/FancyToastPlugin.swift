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
                let position = args["position"] as? String ?? "bottom"
                let toastPosition = convertToPosition(position: position)
                FancyToastManager.shared.showToast(message: message, position: toastPosition)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showTextToast", details: nil))
            }

        case "showIconToast":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String,
               let typeIndex = args["type"] as? Int,
               let type = ToastView.ToastType(rawValue: typeIndex) {
                let position = args["position"] as? String ?? "center"
                let toastPosition = convertToPosition(position: position)
                FancyToastManager.shared.showToast(message: message, style: type, position: toastPosition)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showIconToast", details: nil))
            }

        case "showLoadingToast":
            if let args = call.arguments as? [String: Any],
               let message = args["message"] as? String {
                let position = args["position"] as? String ?? "center"
                let toastPosition = convertToPosition(position: position)
                FancyToastManager.shared.showLoading(message: message, position: toastPosition)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for showLoadingToast", details: nil))
            }

        case "hideToast":
            FancyToastManager.shared.dismissActiveToast()
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func convertToPosition(position: String) -> ToastView.Position {
        switch position {
        case "top":
            return .top
        case "bottom":
            return .bottom
        default:
            return .center
        }
    }
}
