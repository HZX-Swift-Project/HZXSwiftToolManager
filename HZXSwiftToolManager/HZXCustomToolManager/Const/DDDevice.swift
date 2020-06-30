//
//  DDDeviceConst.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

// MARK: ================= 这里定义一些关与设备的尺寸常量

/// 屏幕宽度
let DD_ScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let DD_ScreenHeight = UIScreen.main.bounds.height
/// 判断是否是iPhone
let DD_IsiPhone = (DD_CurrentDeviceModel == UIUserInterfaceIdiom.phone)
/// 刘海屏
let DD_IsHasLiuHai = (DD_IsiPhone && DD_ScreenHeight >= 812)
/// 状态栏高度
let DD_StatusBarHeight:CGFloat = DD_IsHasLiuHai ? 44 : 20
/// 导航栏高度
let DD_NavigationBarHeigh:CGFloat  = DD_IsHasLiuHai ? 88 : 64
/// tabBar高度
let DD_TabBarHeigh:CGFloat = DD_IsHasLiuHai ? 49 + 34 : 49
/// home indicator
let DD_BottomSafeAreaHeight:CGFloat = DD_IsHasLiuHai ? 34 : 0
/// 安全区域的高度
let DD_SafeAreaHeight:CGFloat = DD_ScreenHeight - DD_BottomSafeAreaHeight

// MARK: ================= 获取App软件信息

/// 获取KeyWindow
let DD_KeyWindow = getKeyWindow()
/// 获取软件的AppDelegate
let DD_AppDelegate = UIApplication.shared.delegate as! AppDelegate
/// 获取App版本号
let DD_AppVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
/// 获取当前设备的型号
let DD_CurrentDeviceModel = getCurrentDevieModel()

/// 获取当前设备的型号
private func getCurrentDevieModel() -> UIUserInterfaceIdiom {
    if #available(iOS 13.0, *) {
        return UIDevice.current.userInterfaceIdiom
    } else {
        return UI_USER_INTERFACE_IDIOM()
    }
}
/// 获取keyWindow
private func getKeyWindow() -> UIWindow? {
    return UIApplication.shared.keyWindow
}
