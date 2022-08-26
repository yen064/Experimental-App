//
//  TrainingCamp.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation

class TraninigCamp {
    static func trainAdventurer(type: String) -> SimpleFactoryAdventurer? {
        switch type.lowercased() {
        case "archer":
            print("訓練了一個弓箭手")
            return SimpleFactoryArcher()
        case "warrior":
            print("訓練了一個鬥士")
            return SimpleFactoryWarrior()
        default:
            return nil
        }
    }
}
