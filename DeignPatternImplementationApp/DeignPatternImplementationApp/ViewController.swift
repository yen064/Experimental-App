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
        
//        test1()
        
    }
    
    func test1() {
        let okAA = FunctionHelper.defaultOkAlertAction("OK, 好") { aa in
            print("okAA")
        }
        FunctionHelper.loading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            FunctionHelper.stopLoading()
            FunctionHelper.alert(message: "測試1", okAlertAction: okAA)
        }
    }


}

