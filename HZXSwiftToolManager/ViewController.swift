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
        self.view.backgroundColor = .blue
        self.title = "测试一下"
        DDMBProgressHUD.showTipMessage(message: "测试一下")
    }


}

