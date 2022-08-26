//
//  StatePattern.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/26.
//

import Foundation
class StatePattern {
    
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
    
    // MARK: -
    
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
        
    }
    
    // MARK: -
    
    class NormalState: WarriorState {
        func move(warrior: StatePattern.Warrior) {
            
            if warrior.getHP() < 70 {
                warrior.setState(state: FuryState())
                warrior.move()
                return
            }
            
            let message = String(format: "HP=%d, 一般狀態", warrior.getHP())
            print(message)
        }
    }
    class FuryState: WarriorState {
        func move(warrior: StatePattern.Warrior) {
            
            if warrior.getHP() >= 70 {
                warrior.setState(state: NormalState())
                warrior.move()
                return
            }
            if warrior.getHP() <= 30 {
                warrior.setState(state: DesperateState())
                warrior.move()
                return
            }
            
            let message = String(format: "HP=%d, 狂怒狀態, 傷害增加 30%%", warrior.getHP())
            print(message)
        }
    }
    class DesperateState: WarriorState {
        func move(warrior: StatePattern.Warrior) {
            
            let hp = warrior.getHP()
            
            if hp <= 0 {
                warrior.setState(state: UnableState())
                warrior.move()
                return
            }
            if hp > 30 {
                warrior.setState(state: FuryState())
                warrior.move()
                return
            }
            let message = String(format: "HP=%d, 背水一戰, 傷害增加 50%%, 防禦增加 50%%", hp)
            print(message)
        }
    }
    class UnableState: WarriorState {
        func move(warrior: StatePattern.Warrior) {
            let message = String(format: "HP=%d, 無法戰鬥, 死翹翹", warrior.getHP())
            print(message)
        }
    }
}
