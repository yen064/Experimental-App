//
//  FunctionHelper.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import Foundation
import UIKit

class FunctionHelper {
}
// MARK: - alert
extension FunctionHelper {
    
    static func alert(title: String="提醒您",
                      message: String,
                      okAlertAction: UIAlertAction?=defaultOkAlertAction(),
                      cancelAlertAciton: UIAlertAction?=nil) {
        
        guard let topVC = topViewController() else {
            print("Can't find top viewController.")
            return
        }
        let aa = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        if let ok = okAlertAction {
            aa.addAction(ok)
        }
        if let cancel = cancelAlertAciton {
            aa.addAction(cancel)
        }
        
        DispatchQueue.main.async {
            topVC.present(aa, animated: true, completion: nil)
        }
    }
    
    static func defaultOkAlertAction(_ buttonText: String="確定", handler: ((UIAlertAction) -> Void)?=nil) -> UIAlertAction {
        return UIAlertAction(title: buttonText, style: .default, handler: handler)
    }
    static func defaultCancelAlertAction(_ buttonText: String="取消", handler: ((UIAlertAction) -> Void)?=nil) -> UIAlertAction {
        return UIAlertAction(title: buttonText, style: .cancel, handler: handler)
    }
}
// MARK: - topViewController
extension FunctionHelper {
    static func topViewController() -> UIViewController? {
        guard
            let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController
        else {
            return nil
        }
        var topController = rootViewController
        
        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }
        return topController
    }
}

// MARK: - loading
extension FunctionHelper {
    
    static func loading() {
        
        guard let topVC = FunctionHelper.topViewController() else {
            print("找不到 topVC")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                loading()
            }
            return
        }
        FunctionHelper.stopLoading()
        
        let containerView = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: UIScreen.main.bounds.width,
                                                 height: UIScreen.main.bounds.height))
        
        containerView.tag = FunctionHelper.loadingViewTag()
        //containerView.backgroundColor = topVC.view.backgroundColor?.withAlphaComponent(0.8)
        containerView.backgroundColor = .gray.withAlphaComponent(0.65)
        topVC.view.addSubview(containerView)
        
        containerView.center = topVC.view.center
        
        let spinner = UIActivityIndicatorView(style: .medium)
        containerView.addSubview(spinner)
        spinner.center = containerView.center
        spinner.startAnimating()
    }
    static func stopLoading() {
        
        guard let topVC = FunctionHelper.topViewController() else {
            print("找不到 topVC")
            return
        }
        
        if let spinner = topVC.view.viewWithTag(loadingViewTag()) {
            spinner.removeFromSuperview()
        }
    }
    private static func loadingViewTag() -> Int {
        return 1098709487
    }
}



// MARK: - Bundle
extension FunctionHelper {
    static func bundleIdentifier() -> String {
        return "com.yen064.xxxxx"
    }
    static func bundle() -> Bundle? {
        return Bundle(identifier: bundleIdentifier())
    }
}
