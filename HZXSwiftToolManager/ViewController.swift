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
        
        
        let a = "123"[0]
        
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 200, height: 300))
            $0.center.equalToSuperview()
        }
        
        let contentView = UIView()
        contentView.backgroundColor = .yellow
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets.zero)
            make.width.equalToSuperview()
        }
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        contentView.addSubview(greenView)
        greenView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.width.equalToSuperview()
            make.height.equalTo(200)
        }
        
        let redView = UIView()
        redView.backgroundColor = .red
        contentView.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom)
            make.right.equalTo(-10)
            make.height.equalTo(200)
            make.width.equalTo(100)
            
            make.bottom.equalTo(-10)
        }
        
    }

}

