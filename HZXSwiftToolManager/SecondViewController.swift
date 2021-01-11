//
//  SecondViewController.swift
//  HZXSwiftToolManager
//
//  Created by Meet on 2021/1/11.
//

import UIKit

class SecondViewController: UIViewController {

    lazy var label = UILabel().then {
      $0.textAlignment = .center
      $0.textColor = .black
      $0.text = "Hello, World!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let testView = UIView().then { (make) in
            make.backgroundColor = .red
        }
        view.addSubview(testView)
        testView.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 100, height: 200))
            make.center.equalToSuperview()
        }
        
        view.addSubview(label)
        label.makeConstraints { (make) in
            make.top.equalTo(DD_StatusBarHeight)
            make.centerX.equalToSuperview()
        }
    }
   
    
    deinit {
        print("控制器销毁了")
    }
}
