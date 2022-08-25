//
//  LoginViewController.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, Coordinating, Storyboarded {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "登入頁"
        view.backgroundColor = .systemMint
    }
    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        //由 Coordinator 決定返回按鈕的動作
        if self.coordinator is LoginCoordinator {
            
            let event = LoginCoordinatingEvent(fromCoordinating: self)
            event.type = .quit
            self.coordinator?.eventOccurred(with: event)
            
            
            return //記得要寫 return, 中斷函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("關閉了登入頁")
        }
        
    }
    @IBAction func onLoginButtonTapped(_ sender: Any) {
        
        //執行登入
        LoginInfoManager.shared.login()
        
        
        //由 Coordinator 決定登入成功後的動作
        if self.coordinator is LoginCoordinator {
            
            let event = LoginCoordinatingEvent(fromCoordinating: self)
            event.type = .loginSuccess
            self.coordinator?.eventOccurred(with: event)
            
            
            return //記得要寫 return, 中斷函式
        }
        
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("登入成功, 關閉了登入頁")
        }
        
    }
    
    // MARK: - Storyboarded
    static func storyboardName() -> String? {
        return "Login"
    }
    
    static func storyboardFromBundle() -> Bundle? {
        return Bundle(for: Self.self)
    }
}

