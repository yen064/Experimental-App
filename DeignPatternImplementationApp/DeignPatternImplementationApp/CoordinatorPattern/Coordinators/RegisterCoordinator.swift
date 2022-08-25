//
//  RegisterCoordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/23.
//

import Foundation
import UIKit

class RegisterCoordinator: Coordinator, Coordinating {
    
    // MARK: - Coordinating
    var coordinator: Coordinator?
    
    var startViewController: UIViewController?
    
    func eventOccurred(with event: CoordinatingEvent) {
        
        guard let event_ = event as? RegisterCoordinatingEvent else {
            print("非預期的 CoordinatorEvent")
            return
        }
        
        switch event_.type {
        case .quit:
            
            guard
                let vc = event_.coordinating as? UIViewController & Coordinating
            else {
                print("找不到註冊頁 (Step1)")
                return
            }
            vc.dismiss(animated: true) {
                if self.coordinator is MainCoordinator {
                    let event = MainCoordinatingEvent(fromCoordinating: self)
                    event.type = .exitFromRegister
                    self.coordinator?.eventOccurred(with: event)
                }
            }
            
        case .step2:
            print("goto step2")
            
            if var nextVC: (UIViewController & Coordinating & Storyboarded) = RegisterStep2ViewController.instantiate() {
                
                nextVC.coordinator = self
                navigationController?.pushViewController(nextVC, animated: true)
                
            } else {
                print("找不到 RegisterStep2ViewController()")
            }
            
        case .backFromStep2:
            
            print("backFromStep2")
            navigationController?.popViewController(animated: true)
            
        case .registerSuccess:
            print("registerSuccess")
            
            guard
                let vc = event_.coordinating as? UIViewController & Coordinating
            else {
                return
            }
            vc.dismiss(animated: true) {
                if self.coordinator is MainCoordinator {
                    let event = MainCoordinatingEvent(fromCoordinating: self)
                    event.type = .afterRegister
                    self.coordinator?.eventOccurred(with: event)
                }
            }
        default:
            print("none?")
        }
    }
    
    func start() {
        guard
            var vc: (UIViewController & Coordinating & Storyboarded) = RegisterViewController.instantiate()
        else {
            print("找不到 RegisterViewController()")
            return
        }
        startViewController = UINavigationController()
        startViewController?.modalPresentationStyle = .fullScreen
        startViewController?.modalTransitionStyle = .crossDissolve
        
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        guard let startVC = startViewController else {
            print("RegisterCoordinator 沒有起始的 startViewController!")
            return
        }
        FunctionHelper.topViewController()?.present(startVC, animated: true)
    }
    
}

// MARK: -

class RegisterCoordinatingEvent: CoordinatingEvent {
    enum EventType {
        case quit
        case step2
        case backFromStep2
        case registerSuccess
    }
    var type: RegisterCoordinatingEvent.EventType?
}
