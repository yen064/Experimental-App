//
//  MemberUpgradeCoordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/24.
//

import Foundation
import UIKit

class MemberUpgradeCoordinator: Coordinator, Coordinating {
    
    // 子 coordinators
    var securityPwdSetupCoordinator: (Coordinator & Coordinating)?
//    var emailSetupCoordinator: (Coordinator & Coordinating)?
    
    // MARK: - Coordinating
    var coordinator: Coordinator?
    
    // MARK: - Coordinator
    var startViewController: UIViewController?
    
    func eventOccurred(with event: CoordinatingEvent) {
        
        guard let event_ = event as? MemberUpgradeCoordinatingEvent else {
            print("非預期的 CoordinatorEvent")
            return
        }
        switch event_.type {
            
        case .nextStep1:
            securityPwdSetupCoordinator?.start()
            
        case .nextStep2:
            FunctionHelper.alert(message: "nextStep2 尚未實作")
            
            
        case .finishNextStep1:
            print("finishNextStep1")
            self.checkVerifyStatus()

        case .quitNextStep1:
            //略過升級, 回到 MainCoordinator
            if coordinator is MainCoordinator {
                let event = MainCoordinatingEvent(fromCoordinating: self)
                event.type = .exitMemberUpgrade
                coordinator?.eventOccurred(with: event)
            }
            
        case .nextStep100:
            //完成升級, 回到 MainCoordinator
            if coordinator is MainCoordinator {
                let event = MainCoordinatingEvent(fromCoordinating: self)
                event.type = .afterMemberUpgrade
                coordinator?.eventOccurred(with: event)
            }
        default:
            print("do nothing")
        }
    }
    
    func start() {
        
        securityPwdSetupCoordinator = SecurityPwdSetupCoordinator()
        securityPwdSetupCoordinator?.coordinator = self
        
        _currentStepIndex = 0
        checkVerifyStatus()
        
    }
    
    // MARK: - private
    private var _currentStepIndex: Int = 0
    private func checkVerifyStatus() {
        
        //模擬 api 遞迴
        
        FunctionHelper.loading()
        
        let testNextSteps: [MemberUpgradeCoordinatingEvent.EventType] = [
            .nextStep1
            , .nextStep100
            , .nextStep2, .nextStep3, .nextStep4, .nextStep5
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            FunctionHelper.stopLoading()

            if self._currentStepIndex > testNextSteps.count - 1 {
                return
            }
            
            let event = MemberUpgradeCoordinatingEvent()
            event.type = testNextSteps[self._currentStepIndex]
            self.eventOccurred(with: event)
            
            self._currentStepIndex += 1
        }
        
        
    }
    
}

// MARK: -

class MemberUpgradeCoordinatingEvent: CoordinatingEvent {
    enum EventType: CaseIterable {
        case unknown
        
        case nextStep1
        case quitNextStep1
        case finishNextStep1
        
        case nextStep2
        case nextStep3
        case nextStep4
        case nextStep5
        
        case nextStep100
    }
    var type: MemberUpgradeCoordinatingEvent.EventType?
}
