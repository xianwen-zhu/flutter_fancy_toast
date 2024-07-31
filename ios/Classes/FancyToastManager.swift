//
//  FancyToastManager.swift
//  fancy_toast
//
//  Created by 朱先文 on 2024/7/26.
//

import Foundation
import UIKit

class FancyToastManager {
    static let shared = FancyToastManager()
    
    private init() {}
    
    func showToast(message: String, style: ToastView.ToastType? = nil, position: ToastView.Position = .center) {
        DispatchQueue.main.async {
            self.dismissActiveToast()
            if let style = style {
                ToastView.showIconToast(message: message, type: style, position: position)
            } else {
                ToastView.showToast(message: message, position: position)
            }
        }
    }
    
    func showLoading(message: String, position: ToastView.Position = .center) {
        DispatchQueue.main.async {
            self.dismissActiveToast()
            ToastView.showLoadingToast(message: message, position: position)
        }
    }

    func dismissActiveToast() {
        ToastView.hideToast()
    }
}
