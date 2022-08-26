//
//  SimpleFactoryPattern.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation

class SimpleFactoryPattern {
    
    static func test() {
        if let memberA: Adventurer = TraninigCamp.trainAdventurer(type: "ARCHER") {
            print(memberA.getType())
        }
        if let memberB: Adventurer = TraninigCamp.trainAdventurer(type: "warrior") {
            print(memberB.getType())
        }
    }
    
    // MARK: -
    
    class Warrior: Adventurer {
        func getType() -> String {
            print("我是鬥士")
            let myType = type(of: self)
            return String(describing: myType)
        }
    }
    class Archer: Adventurer {
        func getType() -> String {
            print("我是弓箭手")
            let myType = type(of: self)
            return String(describing: myType)
        }
    }
    class TraninigCamp {
        static func trainAdventurer(type: String) -> Adventurer? {
            switch type.lowercased() {
            case "archer":
                print("訓練了一個弓箭手")
                return Archer()
            case "warrior":
                print("訓練了一個鬥士")
                return Warrior()
            default:
                return nil
            }
        }
    }

}


/**
 *
 https://mermaid.live/edit#pako:eNqNkstugzAQRX_FmlWqUgSYpxVFitouuk6kShWbETiJ1WCQMVHTlH-vA-RBmkW9su_ce-yxfYCszDkwyLZY1y8C1wqLp52XSmJGJ5KlQiGFXD9jUZFDXzmOR1M46ZOHK32e77jUjeKK6GP2vJ4stDIBovcVHwLt9U5zlW1M6HqPXhrhB8ia66XhTO6B3lEpUY5Jg_Y_VD-5NDK17dE1MLLB-o_px7aHFhgRRbXlhanctZ0OOPb1zun0TWquVpjx2ewSu8Wwe8cHCwquChS5edOu-xT0xvBTYGaao_pMIZWt8TVVjpq_5kKXCtgKtzW3ABtdLvYyA6ZVw0-m4V-cXRVKYAf4AuZG1KZBEMZeSKnj-6FvwR5YGNuxFyU0SVw3iT3HbS34LktDcOwocKnrx2HsRD4NIr_DfXTFDt_-AmKIzvo
 *
 *
 classDiagram-v2
     class TrainingCamp {
         +TraningCamp()
         +Adventurer trainAdventure(String type)
     }
     class Archer {
         +Archer()
         +String getType()
     }
     class Warrior {
         +Warrior()
         +String getType()
     }

     Adventurer<..TrainingCamp : has
     Adventurer<|..Archer : implements
     Adventurer<|..Warrior : implements

     <<Interface>>Adventurer
     Adventurer: +String getType()

 *
 *
 */

