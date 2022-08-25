//
//  Coordinator.swift
//  iAmSDK
//
//  Created by Aaron Yen on 2022/8/22.
//

import Foundation
import UIKit

//reference:
//  https://www.youtube.com/watch?v=SAZzcKvOvAE
//      Swift Coordinator Design Pattern (iOS, Xcode 12, 2022) - iOS Design Patterns

protocol Coordinator {
    //    var navigationController: UINavigationController? { get set }
    var startViewController: UIViewController? { get set }
    
    func eventOccurred(with event: CoordinatingEvent)
    func start()
}
extension Coordinator {
    //read only
    var navigationController: UINavigationController? {
        get {
            guard let navVC = startViewController as? UINavigationController else { return nil }
            return navVC
        }
    }
}
// MARK: -
protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
@objc class CoordinatingEvent: NSObject {
    var coordinating: Coordinating?
    init(fromCoordinating: Coordinating?) {
        self.coordinating = fromCoordinating
        super.init()
    }
    convenience override init() {
        self.init(fromCoordinating: nil)
    }
    open override var description: String {
        return "\(super.description),\n coordinating=\(String(describing: coordinating)),"
    }
}
