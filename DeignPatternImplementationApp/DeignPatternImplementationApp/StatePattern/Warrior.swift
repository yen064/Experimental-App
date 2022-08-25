//
//  Warrior.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import Foundation

class StatePattern {
}
extension StatePattern {
    class Warrior {
        private var hp: Int
        private var state: WarriorState
        
        init() {
            self.hp = 100
            self.state = NormalState()
        }
        
        func heal(healingPoint: Int) {
            if state is UnableState {
                return
            }
            self.hp += healingPoint
            if hp > 100 {
                hp = 100
            }
        }
        func getDamage(damagePoint: Int) {
            self.hp -= damagePoint
            if hp < 0 {
                hp = 0
            }
        }
        func move() {
            self.state.move(warrior: self)
        }
        func getHP() -> Int {
            return hp
        }
        func setState(state: WarriorState) {
            self.state = state
        }
        
        // MARK: - 
        
        static func test() {
            let warrior = StatePattern.Warrior()
            
//            warrior.getDamage(damagePoint: 30)
//            warrior.move()
//
//            warrior.getDamage(damagePoint: 50)
//            warrior.move()
//
//            warrior.heal(healingPoint: 120)
//            warrior.move()
            
            warrior.getDamage(damagePoint: 120)
            warrior.move()
            
            warrior.heal(healingPoint: 50)
            warrior.move()
            
        }
    }
}
