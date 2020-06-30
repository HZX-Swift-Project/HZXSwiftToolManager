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
        addNavigationController(ViewController(), title: "测试", imageName: "", selectedImageName: "")
    }
    
    /// 创建并添加导航的具体实现
    private func addNavigationController(_ rootVC: UIViewController, title: String?, imageName: String?, selectedImageName: String?){
        var image: UIImage? {
            guard let imageName = imageName else { return nil}
            return UIImage(named: imageName)
        }
        var selectedImage: UIImage? {
            guard let selectedImageName = selectedImageName else { return nil}
            return UIImage(named: selectedImageName)
        }
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
        tabbarItem.setTitleTextAttributes([NSAttributedString.Key.font : bold12Font, .foregroundColor: UIColor.colorWithHexString("777777")], for: UIControl.State.normal)
        ///选中时的状态
        tabbarItem.setTitleTextAttributes([.font : bold12Font, .foregroundColor: DD_BlueColor], for: UIControl.State.selected)
    }
}
