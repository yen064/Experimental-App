//
//  SDKError.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import Foundation

enum SDKError: Error {
    
    //
    // migrate some good things from +Pay.
    //
    case commonError(errCode: Int, reason: String, err: Error?)
    case networkError(err: Error)
    case apiRtnCodeError(rtnCode: Int, rtnMsg: String, model: Any)
    
    // MARK: - test some shit
    
    
    func test() {
        print(self.toNSError())
    }
    
    // MARK: -
    
    func toDomain() -> String {
        return String(
            format: "%@",
            FunctionHelper.bundleIdentifier()
        )
    }
    
    func toCode() -> Int {
        
        let code: Int
        
        switch self {
        case .apiRtnCodeError(let rtnCode, _, _):
            code = rtnCode
        default:
            code = 0
        }
        
        return code
    }
    
    func toReason() -> String {
        switch self {
        case .commonError(let errCode, let reason, _):
            return String(
                format: "%@ (%d)",
                reason, errCode
            )
        default:
            return self.description
        }
    }
    
    //Handling Cocoa Errors in Swift
    //
    //  https://developer.apple.com/documentation/swift/cocoa_design_patterns/handling_cocoa_errors_in_swift
    //
    func toNSError() -> NSError {
        let userInfo = [
            NSLocalizedDescriptionKey: self.description
        ]
        return NSError(domain: self.toDomain(), code: self.toCode(), userInfo: userInfo)
    }
    
    func throwError() throws {
        throw toNSError()
    }
    
}
// MARK: - CustomStringConvertible

extension SDKError: CustomStringConvertible {
    var description: String {
        String(
            format: "%@",
            self.localizedDescription
        )
    }
}

// MARK: - error code enum

enum SDKErrorCode: Int {
    
    case EXCHANGE_SDK_API_KEY_URL_IS_NOT_AVAILABLE = 101
    case SHITS_HAPPENNED_MOTHER_FXXKER = 99
    
    func toString() -> String {
        
        let str: String
        
        switch self {
        case .EXCHANGE_SDK_API_KEY_URL_IS_NOT_AVAILABLE:
            str = "EXCHANGE_SDK_API_KEY_URL_IS_NOT_AVAILABLE"
        case .SHITS_HAPPENNED_MOTHER_FXXKER:
            str = "SHITS_HAPPENNED_MOTHER_FXXKER"
        }
        return str
    }
}
