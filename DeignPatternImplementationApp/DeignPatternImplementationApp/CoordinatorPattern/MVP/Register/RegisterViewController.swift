//
//  RegisterViewController.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/23.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController, Coordinating, Storyboarded {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "註冊頁 (Step1)"
        view.backgroundColor = .systemPurple
    }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        //由 Coordinator 決定返回按鈕的動作
        if self.coordinator is RegisterCoordinator {
            let event = RegisterCoordinatingEvent(fromCoordinating: self)
            event.type = .quit
            self.coordinator?.eventOccurred(with: event)
            
            return //離開函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設關閉
        self.dismiss(animated: true) {
            print("離開了註冊頁 (Step1)")
        }
    }
    @IBAction func onNextButtonTapped(_ sender: Any) {
        
        //由 Coordinator 決定下一步按鈕的動作
        if self.coordinator is RegisterCoordinator {
            let event = RegisterCoordinatingEvent(fromCoordinating: self)
            event.type = .step2
            self.coordinator?.eventOccurred(with: event)
            
            return //離開函式
        }
        
        //沒有 coordinator 在自己身上, 則寫一個預設動作
        FunctionHelper.alert(message: "註冊下一步")
        
    }
    
    
    // MARK: - Storyboarded
    static func storyboardName() -> String? {
        return "Register"
    }
    
    static func storyboardFromBundle() -> Bundle? {
        return Bundle(for: Self.self)
    }
}
