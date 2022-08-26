//
//  ViewController.swift
//  DeignPatternImplementationApp
//
//  Created by Aaron Yen on 2022/8/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTestButtonTapped(_ sender: Any) {
//        testAlert()
//        testCoordinator()
//        testStatePattern()
//        testSimpleFactoryPattern()
    }
    func testSimpleFactoryPattern() {
        if let memberA: Adventurer = SimpleFactoryPattern.TraninigCamp.trainAdventurer(type: "ARCHER") {
            print(memberA.getType())
        }
        if let memberB: Adventurer = SimpleFactoryPattern.TraninigCamp.trainAdventurer(type: "warrior") {
            print(memberB.getType())
        }
        
        
    }
    func testCoordinator() {    
        let coordinator = MainCoordinator()
        coordinator.completion = { result in
            switch result {
            case .success(let event):
                let aa = FunctionHelper.defaultOkAlertAction("OK, 好") { aa in
                    print(event)
                }
                FunctionHelper.alert(message: "已達目的! (MainCoordinator completion)", okAlertAction: aa)
            case .failure(let err):
                print(err.toReason())
            }
        }
        coordinator.start()
    }
    func testStatePattern() {
        StatePattern.test()
    }



}

