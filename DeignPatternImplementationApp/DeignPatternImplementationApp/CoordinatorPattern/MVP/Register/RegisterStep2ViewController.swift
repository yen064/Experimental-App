//
//  RegisterStep2ViewController.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/23.
//

import Foundation
import UIKit

class RegisterStep2ViewController: UIViewController, Coordinating, Storyboarded {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "註冊頁 (Step2)"
        view.backgroundColor = .systemOrange
    }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        //
        //由 Coordinator 決定返回按鈕的動作
        if self.coordinator is RegisterCoordinator {
            let event = RegisterCoordinatingEvent(fromCoordinating: self)
            event.type = .backFromStep2
            self.coordinator?.eventOccurred(with: event)
            
            return //離開函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("離開了註冊頁 (Step2)")
        }
        
    }
    @IBAction func onRegisterSuccessButtonTapped(_ sender: Any) {
        
        //註冊成功, 狀態檢查由 未註冊 切換為 未登入
        LoginInfoManager.shared.logout() //執行此函式可以變更狀態(測試用)

        //由 Coordinator 決定註冊成功後的動作
        if self.coordinator is RegisterCoordinator {
            
            let event = RegisterCoordinatingEvent(fromCoordinating: self)
            event.type = .registerSuccess
            self.coordinator?.eventOccurred(with: event)

            return //記得要寫 return, 中斷函式
        }
        
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("註冊成功, 關閉了註冊頁")
        }
        
    }
    
    // MARK: - Storyboarded
    static func storyboardName() -> String? {
        return "Register"
    }
    
    static func storyboardFromBundle() -> Bundle? {
        return Bundle(for: Self.self)
    }
}
