//
//  ViewController.swift
//  HZXSwiftToolManager
//
//  Created by Meet on 2020/6/30.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
import Then
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let secondVC = SecondViewController()
        self.present(secondVC, animated: true, completion: nil)
    }
}

