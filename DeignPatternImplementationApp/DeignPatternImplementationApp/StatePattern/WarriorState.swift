//
//  State.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import Foundation


protocol WarriorState {
    func move(warrior: StatePattern.Warrior)
}
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
