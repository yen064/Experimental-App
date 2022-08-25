//
//  SecurityPwdSetupCoordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/24.
//

import Foundation
import UIKit

class SecurityPwdSetupCoordinator: Coordinator, Coordinating {
    
    var coordinator: Coordinator?
    
    var startViewController: UIViewController?
    
    func eventOccurred(with event: CoordinatingEvent) {
        
        guard let event_ = event as? SecurityPwdSetupCoordinatingEvent,
              let vc = event.coordinating as? UIViewController & Coordinating
        else {
            print("非預期的 CoordinatorEvent")
            return
        }
        switch event_.type {
            
        case .finishSixPwdSetup:
            
            //做完六碼, 去圖形鎖設定頁
            if
                coordinator is MemberUpgradeCoordinator,
                var graphicPwdSetupVC: (UIViewController & Coordinating & Storyboarded) = GraphicPwdSetupViewController.instantiate() {
                
                graphicPwdSetupVC.coordinator = self
                navigationController?.pushViewController(graphicPwdSetupVC, animated: true)
                
                return //離開函式
            }
            
            //沒有上層 coordinator, 則執行一般離開
            vc.dismiss(animated: true) {
                print("離開了安全密碼設定頁")
            }
            
        case .quit
            , .quitFromGraphicPwdSetup
            , .ignoreGraphicPwdSetup
            , .finishGraphicPwdSetup:
            
            //q
            vc.dismiss(animated: true) {
                if self.coordinator is MemberUpgradeCoordinator {
                    
                    var type__: MemberUpgradeCoordinatingEvent.EventType
                    
                    switch event_.type {
                    case .ignoreGraphicPwdSetup
                        , .finishGraphicPwdSetup:
                        
                        //忽略圖形鎖設定, 代表有做完基本的 6碼, 視為完成 nextStep1
                        type__ = .finishNextStep1
                        
                    default:
                        //其餘都視為離開
                        type__ = .quitNextStep1
                    }
                    
                    let event__ = MemberUpgradeCoordinatingEvent(fromCoordinating: self)
                    event__.type = type__
                    self.coordinator?.eventOccurred(with: event__)
                }
            } // end of ... q
            
        default:
            print("do nothing")
        }
    }
    
    func start() {
        guard
            var vc: (UIViewController & Coordinating & Storyboarded) = SixPwdSetupViewController.instantiate()
        else {
            print("找不到 SixPwdSetupViewController()")
            return
        }
        startViewController = UINavigationController()
        startViewController?.modalPresentationStyle = .fullScreen
        startViewController?.modalTransitionStyle = .crossDissolve
        
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
        
        guard let startVC = startViewController else {
            print("SixPwdSetupCoordinator 沒有起始的 startViewController!")
            return
        }
        FunctionHelper.topViewController()?.present(startVC, animated: true)
    }
    
}
// MARK: -
class SecurityPwdSetupCoordinatingEvent: CoordinatingEvent {
    enum EventType {
        case quit
        case finishSixPwdSetup
        case quitFromGraphicPwdSetup
        case ignoreGraphicPwdSetup
        case finishGraphicPwdSetup
    }
    var type: SecurityPwdSetupCoordinatingEvent.EventType?
}
