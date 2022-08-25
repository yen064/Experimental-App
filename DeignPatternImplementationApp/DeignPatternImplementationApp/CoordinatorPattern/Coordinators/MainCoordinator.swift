//
//  MainCoordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var completion: ((Swift.Result<MainCoordinatingEvent, SDKError>) -> Void)?
    
    // MARK: sub coordinators
    
    var loginCoordinator: (Coordinator & Coordinating)?
    var registerCoordinator: (Coordinator & Coordinating)?
    var memberUpgradeCoordinator: (Coordinator & Coordinating)?
    
    // MARK: - constructor
    
    init() {
//        self.startViewController = UINavigationController()
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK:
    // MARK: Coordinator protocol
    
    var startViewController: UIViewController?
    func eventOccurred(with event: CoordinatingEvent) {
        
        guard let event_ = event as? MainCoordinatingEvent else {
            print("非預期的 CoordinatorEvent")
            return
        }
        
        switch event_.type {
            
        case .loginSuccess:
            print("loginSuccess")
            let okAlertAction = FunctionHelper.defaultOkAlertAction { aa in
//                if let completion_ = self.completion {
//                    completion_()
//                }
                self.memberUpgradeCoordinator?.start()
            }
            FunctionHelper.alert(message: "登入完成", okAlertAction: okAlertAction)
            
        case .afterRegister:
            print("afterRegister")
            let okAlertAction = FunctionHelper.defaultOkAlertAction { aa in
                self.checkLoginStatus()
            }
            FunctionHelper.alert(message: "已完成註冊", okAlertAction: okAlertAction)
            
            
        case .exitFromLogin
            , .exitFromRegister
            , .exitMemberUpgrade:
            if let completion_ = self.completion,
               let err = SDKError.translateFromMainCoordinatingEvent(event_) {
                completion_(.failure(err))
            } else {
                print("exit")
            }
        case .afterMemberUpgrade:
            if let completion_ = completion {
                completion_(.success(event_))
            }
        default:
            print("none?")
        }
        
    }
    
    func start() {
        
        // init sub coordinator as coordinating
        loginCoordinator = LoginCoordinator()
        loginCoordinator?.coordinator = self
        
        registerCoordinator = RegisterCoordinator()
        registerCoordinator?.coordinator = self
        
        memberUpgradeCoordinator = MemberUpgradeCoordinator()
        memberUpgradeCoordinator?.coordinator = self
        
        self.checkLoginStatus() //檢查的起點
    }
    
    
    // MARK: - private methods
    
    private func checkLoginStatus() {
        
        FunctionHelper.loading()
        
        LoginInfoManager.shared.getLoginStatus(true) { result in
            
            FunctionHelper.stopLoading()
            
            switch result {
            case.success(let status):
                switch status {
                case .login:
                    print("目前狀態為: 登入中")
                    
                    let okAlertAction = FunctionHelper.defaultOkAlertAction { aa in
//                        if let completion_ = self.completion {
//                            completion_()
//                        }
                        self.memberUpgradeCoordinator?.start()
                    }
                    FunctionHelper.alert(message: "現已登入中", okAlertAction: okAlertAction)
                    
                case .logout:
                    print("目前狀態為: 登出")
                    self.loginCoordinator?.start()
                    
                case .unregister:
                    print("目前狀態為: 未註冊")
                    self.registerCoordinator?.start()
                    
                }
            case.failure(let err):
                FunctionHelper.alert(message: err.toReason())
            }
        }
    }
}

// MARK: -

class MainCoordinatingEvent: CoordinatingEvent {
    enum EventType {
        //case launch(_ result: Swift.Result<LoginInfoManager.LoginStatus, SDKError>)
        case exitFromLogin
        case loginSuccess
        
        case exitFromRegister
        case afterRegister
        
        case exitMemberUpgrade
        case afterMemberUpgrade
    }
    var type: MainCoordinatingEvent.EventType?
    override var description: String {
        return "\(super.description),\n type=\(String(describing: type)),"
    }
}

// MARK: -
extension SDKError {
    static func translateFromMainCoordinatingEvent(_ event: MainCoordinatingEvent) -> SDKError? {
        var err: SDKError?
        switch event.type {
        case .exitFromLogin:
            err = SDKError.commonError(errCode: 21, reason: "從登入頁離開", err: nil)
        case .exitFromRegister:
            err = SDKError.commonError(errCode: 22, reason: "從註冊流程離開", err: nil)
        case .exitMemberUpgrade:
            err = SDKError.commonError(errCode: 23, reason: "從升級流程離開", err: nil)
        default:
            print("nothing")
        }
        return err
    }
}


// MARK: -
// MARK: 流程圖

/**
 *
 *  https://mermaid.live/edit#pako:eNptkctugzAQRX8FzSpIAfEKL6nd0OxgQ8Sm0IWLXYISbGSM1DTw7zVOifrywrJ8z9y5Hl-hZphADA1H_VFL84pWVJPrsNkMAnGh64bxmJUZamnCGMctRYLxlxuUSW2qj6Q-paxp6UEgMQ5TctXm1SZZCPPMGjaKKS0V9tcnlVTqlJhp5wVYb52leFCm2oNmKm1KbuJtzyWRq0JOmnYQZHXM_9YuCZLvqUa6Fk15mX8df4b79QjZPivKjHSvhBe9HBkm_wylMIxlZoXK1SlYG3uMBLkTKl3Nuv5MRMvotN9sCMW6XlHYQkd4h1osP-W68BWII-lIBbE8YsRPFVR0ltzNc49b2RviN3QeyBbQKNjhQmuIBR_JCj21SKbt7lSPKMRXeIfYDlzT3e380PFd1_I839vCBWI_NEMniNwosu0odCx73sIHY9LBMoOd7dpe6IdW4Lm7wFN2z0pU9vMnLNe-0w
 *  
 *
 graph LR

     S((start))-->M[MainCoordinator]
     M-->|checkLoginStatus|C{ }

     C-->|.logout|L[LoginCoordinator]
     L-->L2[do login]
     L2-->|status = .login|C
     
     R-->R2[do register]
     R2-->|status = .logout|C
     C-->|.unregister|R[RegisterCoordinator]

     C-->|.login|MU[MemberUpgradeCoordinator]
     MU---->MU2[do member update]
     MU2-->|completion|E((end))

 *
 **/
