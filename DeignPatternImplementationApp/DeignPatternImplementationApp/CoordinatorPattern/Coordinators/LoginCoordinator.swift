//
//  LoginCoordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/23.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator, Coordinating {
    
    // MARK: Coordinating protocol
    var coordinator: Coordinator?
    
    // MARK: -
    // MARK: Coordinator protocol
    var startViewController: UIViewController?
    
    func eventOccurred(with event: CoordinatingEvent) {
        
        guard let event_ = event as? LoginCoordinatingEvent,
              let vc = event_.coordinating as? UIViewController & Coordinating
        else {
            print("非預期的 CoordinatorEvent")
            return
        }
        
        switch event_.type {
        default:
            //預設事件發生時,
            //  所有的 event_.type 都要做 dismiss
            vc.dismiss(animated: true) {
                if self.coordinator is MainCoordinator {
                    
                    var type__: MainCoordinatingEvent.EventType
                    switch event_.type {
                    case .loginSuccess:
                        type__ = .loginSuccess
                    default:
                        type__ = .exitFromLogin
                    }
                    
                    let event__: MainCoordinatingEvent = MainCoordinatingEvent(fromCoordinating: self)
                    event__.type = type__
                    self.coordinator?.eventOccurred(with: event__)
                    
                } //end of ... if self.coordinator is ~
            } //end of ... vc.dismiss ~
        }
        
    }
    
    func start() {
        guard
            var vc: (UIViewController & Coordinating & Storyboarded) = LoginViewController.instantiate()
        else {
            print("找不到 LoginViewController()")
            return
        }
        startViewController = UINavigationController()
        startViewController?.modalPresentationStyle = .fullScreen
        startViewController?.modalTransitionStyle = .crossDissolve
        
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        guard let startVC = startViewController else {
            print("LoginCoordinator 沒有起始的 startViewController!")
            return
        }
        FunctionHelper.topViewController()?.present(startVC, animated: true)
    }
    
    
    
}

// MARK: -

class LoginCoordinatingEvent: CoordinatingEvent {
    enum EventType {
        case quit
        case loginSuccess
    }
    var type: LoginCoordinatingEvent.EventType?
}
