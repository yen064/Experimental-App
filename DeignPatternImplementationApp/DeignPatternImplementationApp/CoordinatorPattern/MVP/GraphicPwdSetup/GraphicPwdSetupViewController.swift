//
//  GraphicPwdSetupViewController.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/24.
//

import Foundation
import UIKit

class GraphicPwdSetupViewController: UIViewController, Coordinating, Storyboarded {
    
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "圖形鎖設定頁"
        view.backgroundColor = .systemGreen
    }
    
    @IBAction func onBackButtonTapped(_ sender: Any) {
        
        if coordinator is SecurityPwdSetupCoordinator {
            let event = SecurityPwdSetupCoordinatingEvent(fromCoordinating: self)
            event.type = .quitFromGraphicPwdSetup
            self.coordinator?.eventOccurred(with: event)
            
            return
        }
        
        self.dismiss(animated: true) {
            print("離開了 圖形鎖設定頁")
        }
        
    }
    @IBAction func onIgnoreButtonTapped(_ sender: Any) {
        
        if coordinator is SecurityPwdSetupCoordinator {
            let event = SecurityPwdSetupCoordinatingEvent(fromCoordinating: self)
            event.type = .ignoreGraphicPwdSetup
            self.coordinator?.eventOccurred(with: event)
            
            return
        }
        
        self.dismiss(animated: true) {
            print("離開了 圖形鎖設定頁")
        }
        
    }
    @IBAction func onGraphicPwdSetupButtonTapped(_ sender: Any) {
        
        if coordinator is SecurityPwdSetupCoordinator {
            let event = SecurityPwdSetupCoordinatingEvent(fromCoordinating: self)
            event.type = .finishGraphicPwdSetup
            self.coordinator?.eventOccurred(with: event)
            
            return
        }
        
        self.dismiss(animated: true) {
            print("離開了 圖形鎖設定頁")
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

