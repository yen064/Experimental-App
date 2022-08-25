//
//  Storyboarded.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import Foundation
import UIKit

protocol Storyboarded {
    
    static func storyboardName() -> String?
    static func storyboardFromBundle() -> Bundle?
    static func instantiate() -> Self?
    
}

extension Storyboarded where Self: UIViewController {
    static func storyboardVC() -> Self? {
        return instantiate()
    }
    static func instantiate() -> Self? {
        
        guard
            let storyboardName = storyboardName()
        else {
            return nil
        }
        
        let bundle = storyboardFromBundle() ?? Bundle(for: Self.self)
        let viewControllerID = String(describing: self)
        let storyboard: UIStoryboard = UIStoryboard.init(name: storyboardName, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: viewControllerID) as? Self
    }
}
