//
//  LoginInfoManager.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/22.
//

import Foundation

class LoginInfoManager {
    
    enum LoginStatus {
        case login
        case unregister
        case logout
    }
    
    public static var shared: LoginInfoManager = LoginInfoManager()
    
    private var _currentStatus: LoginStatus = .unregister
    var currenStatus: LoginStatus {
        get {
            return _currentStatus
        }
    }
    
    func login() {
        _currentStatus = .login
    }
    func logout() {
        _currentStatus = .logout
    }
    
    
    func getLoginStatus(_ isApiOK: Bool=true,
                        completion: @escaping((Swift.Result<LoginInfoManager.LoginStatus, SDKError>) -> Void)) {
        
//        DispatchQueue.main.async {
//        } // end of ... DispatchQueue.main.async
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            
            
            let isApiOK_ = isApiOK
            
            if isApiOK_ {
                
                completion(.success(self.currenStatus))
                
            } else {
                
                let errCode: SDKErrorCode = .SHITS_HAPPENNED_MOTHER_FXXKER
                let commonError = SDKError.commonError(errCode: errCode.rawValue,
                                                       reason: errCode.toString(),
                                                       err: nil)
                
                completion(.failure(commonError))
            }
            
        } // end of ... DispatchQueue.main.asyncAfter
        
    }
}
