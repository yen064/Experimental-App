//
//  Warrior2.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation

class SimpleFactoryWarrior: SimpleFactoryAdventurer {
    func getType() -> String {
        print("我是鬥士")
        let myType = type(of: self)
        return String(describing: myType)
    }
}
