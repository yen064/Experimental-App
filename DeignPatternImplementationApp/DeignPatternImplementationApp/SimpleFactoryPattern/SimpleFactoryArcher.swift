//
//  Archer.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation


class SimpleFactoryArcher: SimpleFactoryAdventurer {
    func getType() -> String {
        print("我是弓箭手")
        let myType = type(of: self)
        return String(describing: myType)
    }
}
