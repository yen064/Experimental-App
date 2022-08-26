//
//  FactoryPattern.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation

class FactoryPattern {
    
    static func test() {
        
        var trainingCamp: TraninigCamp
        
        trainingCamp = ArcherTrainingCamp()
        let adventurer1 = trainingCamp.trainAdventurer()
        
        trainingCamp = WarriorTrainingCamp()
        let adventurer2 = trainingCamp.trainAdventurer()
        
        
        print(adventurer1.getType())
        print(adventurer2.getType())
        
    }
    
    // MARK: -
    
    class ArcherTrainingCamp: TraninigCamp {
        func trainAdventurer() -> Adventurer {
            print("訓練一個弓箭手")
            return SimpleFactoryPattern.Archer()
        }
    }
    class WarriorTrainingCamp: TraninigCamp {
        func trainAdventurer() -> Adventurer {
            print("訓練一個鬥士")
            return SimpleFactoryPattern.Warrior()
        }
    }
    
}
