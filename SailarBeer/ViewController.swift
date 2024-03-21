//
//  ViewController.swift
//  SailarBeer
//
//  Created by 陳宗廷 on 2024/3/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        // Do any additional setup after loading the view.
    }
    func hideBackButton(){
        navigationItem.hidesBackButton = true
    }

}

