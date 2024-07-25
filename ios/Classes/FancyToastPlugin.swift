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
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "showTextToast":
      if let args = call.arguments as? [String: Any],
         let message = args["message"] as? String {
        showToast(message: message)
        result(nil)
      }
    case "showIconToast":
      if let args = call.arguments as? [String: Any],
         let message = args["message"] as? String,
         let icon = args["icon"] as? String {
        showToast(message: message, icon: icon)
        result(nil)
      }
    case "showCustomToast":
      if let args = call.arguments as? [String: Any],
         let message = args["message"] as? String,
         let style = args["style"] as? String {
        showToast(message: message, style: style)
        result(nil)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

    private func showToast(message: String, icon: String? = nil, style: String? = nil) {
        // 获取主窗口
        guard let window = UIApplication.shared.keyWindow else { return }
        
        // 创建容器视图
        let toastView = UIView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastView.layer.cornerRadius = 8
        toastView.clipsToBounds = true

        // 添加文本标签
        let messageLabel = UILabel()
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.text = message
        messageLabel.numberOfLines = 0

        // 配置图标（如果有）
        var iconImageView: UIImageView?
        if let icon = icon, let iconImage = UIImage(named: icon) {
            iconImageView = UIImageView(image: iconImage)
            iconImageView?.contentMode = .scaleAspectFit
        }

        // 添加子视图
        if let iconImageView = iconImageView {
            toastView.addSubview(iconImageView)
        }
        toastView.addSubview(messageLabel)

        // 设置布局
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        if let iconImageView = iconImageView {
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            iconImageView.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 10).isActive = true
            iconImageView.centerYAnchor.constraint(equalTo: toastView.centerYAnchor).isActive = true
            iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
            iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 10).isActive = true
        }
        messageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -10).isActive = true
        messageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10).isActive = true

        // 添加到主窗口
        window.addSubview(toastView)

        // 设置位置
        toastView.translatesAutoresizingMaskIntoConstraints = false
        toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -80).isActive = true
        toastView.leadingAnchor.constraint(greaterThanOrEqualTo: window.leadingAnchor, constant: 16).isActive = true
        toastView.trailingAnchor.constraint(lessThanOrEqualTo: window.trailingAnchor, constant: -16).isActive = true

        // 动画显示并移除
        toastView.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            toastView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                toastView.alpha = 0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}
