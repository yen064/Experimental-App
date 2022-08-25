//
//  SixPwdSetupViewController.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/24.
//

import Foundation
import UIKit

class SixPwdSetupViewController: UIViewController, Coordinating, Storyboarded {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "安全密碼六碼設定頁"
        view.backgroundColor = .systemRed
    }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        
        //由 Coordinator 決定返回按鈕的動作
        if self.coordinator is SecurityPwdSetupCoordinator {
            let event = SecurityPwdSetupCoordinatingEvent(fromCoordinating: self)
            event.type = .quit
            self.coordinator?.eventOccurred(with: event)
            
            return //離開函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("離開了 安全密碼六碼設定頁")
        }
        
    }
    @IBAction func onSixPwdSetupButtonTapped(_ sender: Any) {
        
        //由 Coordinator 決定返回按鈕的動作
        if self.coordinator is SecurityPwdSetupCoordinator {
            let event = SecurityPwdSetupCoordinatingEvent(fromCoordinating: self)
            event.type = .finishSixPwdSetup
            self.coordinator?.eventOccurred(with: event)
            
            return //離開函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("離開了 安全密碼六碼設定頁")
        }
    }
    
    // MARK: - Storyboarded
    static func storyboardName() -> String? {
        "Security"
    }
    
    static func storyboardFromBundle() -> Bundle? {
        return Bundle(for: Self.self)
    }
    
}
