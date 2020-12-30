//
//  ViewController.swift
//  HZXSwiftToolManager
//
//  Created by 侯仲祥 on 2020/6/30.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(DDAppNeedUpdate("1.0.1.0.0.01") ? "更新" : "不更新")
    }


}

