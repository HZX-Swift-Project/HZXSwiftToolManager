//
//  DDDeviceConst.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
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
let DD_IsHasLiuHai = judgeHasLiuHai()
/// 状态栏高度
let DD_StatusBarHeight = getDeviceStatusBarHeight()
/// 导航栏高度
let DD_NavigationBarHeight: CGFloat  = 44.0
/// 导航栏和状态栏高度总和
let DD_NaviAndStatusTotalHeight = DD_StatusBarHeight + DD_NavigationBarHeight
/// tabBar高度
let DD_TabBarHeight: CGFloat = DD_IsHasLiuHai ? 49 + 34 : 49
/// home indicator
let DD_BottomSafeAreaHeight: CGFloat = DD_IsHasLiuHai ? 34 : 0
/// 安全区域的高度
let DD_SafeAreaHeight: CGFloat = DD_ScreenHeight - DD_BottomSafeAreaHeight

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

/// 获取状态栏高度
/// - Returns: 状态栏高度
private func getDeviceStatusBarHeight() -> CGFloat {
    if #available(iOS 13.0, *) {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 44.0
    } else {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

/// 判断设备是否有刘海
/// - Returns: 是否有刘海
private func judgeHasLiuHai() -> Bool {
    if DD_CurrentDeviceModel != .phone {
        return false
    }
    if #available(iOS 11.0, *) {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0 > 0
    } else {
        return false;
    }
}



