//
//  DDCustomTabBarController.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

class DDCustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addControllers()
    }
    /// 在这个方法中 向tabbar中添加导航控制器
    private func addControllers() {
        /// 测试
        addNavigationController(ViewController(), title: "测试")
    }
    
    /// 创建并添加导航的具体实现
    private func addNavigationController(_ rootVC: UIViewController, title: String? = nil, imageName: String? = nil, selectedImageName: String? = nil){
        /// 未选中图片
        let image = UIImage(named: imageName ?? "")
        /// 已选中图片
        let selectedImage = UIImage(named: selectedImageName ?? "")
        /// tabbarItem
        let tabbarItem = UITabBarItem.init(title: title, image: image, selectedImage: selectedImage)
        configTabBarItems(tabbarItem)
        let naviVC = UINavigationController(rootViewController: rootVC)
        naviVC.tabBarItem = tabbarItem
        addChild(naviVC)
    }
    
    /// tabbarItem 切换时的颜色
    private func configTabBarItems(_ tabbarItem: UITabBarItem) {
        //设置字体与图片距离
        tabbarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        ///未选中是的状态呢
        tabbarItem.setTitleTextAttributes([NSAttributedString.Key.font : DD_Bold12Font, .foregroundColor: UIColor.color(hex: "777777")], for: UIControl.State.normal)
        ///选中时的状态
        tabbarItem.setTitleTextAttributes([.font : DD_Bold12Font, .foregroundColor: DD_BlueColor], for: UIControl.State.selected)
    }
}
