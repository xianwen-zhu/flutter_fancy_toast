//
//  ToastView.swift
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//

import UIKit

class ToastView: UIView {

    static var currentToast: ToastView? // 用于追踪当前显示的 Toast
    static var overlayView: UIView? // 用于阻止用户交互的覆盖视图

    /// 获取资源包
    static func getResourceBundle() -> Bundle? {
        let bundle = Bundle(for: ToastView.self)
        guard let resourceBundleURL = bundle.url(forResource: "Image_Picker", withExtension: "bundle") else {
            return nil
        }
        return Bundle(url: resourceBundleURL)
    }

    /// 显示纯文本 Toast
    static func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else { return }

        // 移除当前的 Toast 和覆盖视图
        currentToast?.removeFromSuperview()
        overlayView?.removeFromSuperview()

        let toastView = ToastView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 4
        toastView.clipsToBounds = true

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)

        toastView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 14),
            label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -14)
        ])

        let maxWidth = window.bounds.width - 40
        let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = label.sizeThatFits(maxSize)
        let toastWidth = max(96, labelSize.width + 40)
        let toastHeight = labelSize.height + 28

        toastView.frame = CGRect(x: (window.bounds.width - toastWidth) / 2, y: window.bounds.height - toastHeight - 50, width: toastWidth, height: toastHeight)
        window.addSubview(toastView)

        toastView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                toastView.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })

        // 设置当前显示的 Toast
        currentToast = toastView
    }

    /// 显示带图标的 Toast
    static func showIconToast(message: String, type: ToastType) {
        guard let window = UIApplication.shared.keyWindow else { return }

        // 移除当前的 Toast 和覆盖视图
        currentToast?.removeFromSuperview()
        overlayView?.removeFromSuperview()

        let toastView = ToastView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 12
        toastView.clipsToBounds = true

        let iconImageView = UIImageView()
        let label = UILabel()

        label.text = message
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)

        toastView.addSubview(iconImageView)
        toastView.addSubview(label)

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -20)
        ])

        if let resourceBundle = getResourceBundle() {
            var iconName: String
            switch type {
            case .success:
                iconName = "icon_success"
            case .error:
                iconName = "icon_error"
            case .warning:
                iconName = "icon_warning"
            }

            iconImageView.image = UIImage(named: iconName, in: resourceBundle, compatibleWith: nil)
        }

        let maxWidth = window.bounds.width - 40
        let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = label.sizeThatFits(maxSize)
        let toastWidth = max(106, labelSize.width + 40)
        let toastHeight = labelSize.height + 60 + 24 // 24为icon的高度

        toastView.frame = CGRect(x: (window.bounds.width - toastWidth) / 2, y: window.bounds.height - toastHeight - 50, width: toastWidth, height: toastHeight)
        window.addSubview(toastView)

        toastView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                toastView.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        })

        currentToast = toastView
    }

    /// 显示加载动画 Toast 并禁用用户交互
    static func showLoadingToast(message: String) -> ToastView? {
        guard let window = UIApplication.shared.keyWindow else { return nil }

        // 移除当前的 Toast 和覆盖视图
        currentToast?.removeFromSuperview()
        overlayView?.removeFromSuperview()

        // 添加全屏透明视图以阻止用户交互
        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor.clear
        overlay.isUserInteractionEnabled = true
        window.addSubview(overlay)
        overlayView = overlay

        let toastView = ToastView()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.layer.cornerRadius = 12
        toastView.clipsToBounds = true

        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.startAnimating()
        let label = UILabel()

        label.text = message
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)

        toastView.addSubview(activityIndicator)
        toastView.addSubview(label)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: toastView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 20),
            activityIndicator.widthAnchor.constraint(equalToConstant: 24),
            activityIndicator.heightAnchor.constraint(equalToConstant: 24),

            label.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -20)
        ])

        let maxWidth = window.bounds.width - 40
        let maxSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = label.sizeThatFits(maxSize)
        let toastWidth = max(106, labelSize.width + 40)
        let toastHeight = max(106, labelSize.height + activityIndicator.frame.height + 60)

        toastView.frame = CGRect(x: (window.bounds.width - toastWidth) / 2, y: window.bounds.height - toastHeight - 50, width: toastWidth, height: toastHeight)
        window.addSubview(toastView)

        toastView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1
        })

        currentToast = toastView
        return toastView // 返回创建的 ToastView 实例
    }

    // Toast类型枚举
    public enum ToastType: Int {
        case success = 0
        case error = 1
        case warning = 2
    }

    // 隐藏当前的 Toast 和覆盖视图
    static func hideToast() {
        currentToast?.removeFromSuperview()
        overlayView?.removeFromSuperview()
    }
}
