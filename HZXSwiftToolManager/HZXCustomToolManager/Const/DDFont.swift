//
//  DDFontConst.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

/// 适配比例
let DD_Scale = UIScreen.main.bounds.size.width / 375.0
/// 自动适配
func AutoSize(_ num: CGFloat) -> CGFloat {
    return num * DD_Scale
}

// MARK: ----------------- 常规字体
let regular10Font = UIFont.systemFont(ofSize: 10 * DD_Scale)
let regular11Font = UIFont.systemFont(ofSize: 11 * DD_Scale)
let regular12Font = UIFont.systemFont(ofSize: 12 * DD_Scale)
let regular13Font = UIFont.systemFont(ofSize: 13 * DD_Scale)
let regular14Font = UIFont.systemFont(ofSize: 14 * DD_Scale)
let regular15Font = UIFont.systemFont(ofSize: 15 * DD_Scale)
let regular16Font = UIFont.systemFont(ofSize: 16 * DD_Scale)
let regular17Font = UIFont.systemFont(ofSize: 17 * DD_Scale)
let regular18Font = UIFont.systemFont(ofSize: 18 * DD_Scale)

/// 自定义系统字体大小 适配手机
/// - Parameter ofSize: 字体大小
/// - Returns: UIFont
func regularCustomFont(ofSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: ofSize * DD_Scale)
}

// MARK: ----------------- 粗体
let bold10Font = UIFont.boldSystemFont(ofSize: 10 * DD_Scale)
let bold11Font = UIFont.boldSystemFont(ofSize: 11 * DD_Scale)
let bold12Font = UIFont.boldSystemFont(ofSize: 12 * DD_Scale)
let bold13Font = UIFont.boldSystemFont(ofSize: 13 * DD_Scale)
let bold14Font = UIFont.boldSystemFont(ofSize: 14 * DD_Scale)
let bold15Font = UIFont.boldSystemFont(ofSize: 15 * DD_Scale)
let bold16Font = UIFont.boldSystemFont(ofSize: 16 * DD_Scale)
let bold17Font = UIFont.boldSystemFont(ofSize: 17 * DD_Scale)
let bold18Font = UIFont.boldSystemFont(ofSize: 18 * DD_Scale)

/// 自定义系统字体大小 适配手机
/// - Parameter ofSize: 字体大小
/// - Returns: UIFont
func boldCustomFont(ofSize: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: ofSize * DD_Scale)
}

/// 自定义系统字体大小 适配手机
/// - Parameters:
///   - ofSize: 字体大小
///   - weight: 字体权重
/// - Returns: UIFont
func customWeighFont(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
    return UIFont.systemFont(ofSize: ofSize * DD_Scale, weight: weight)
}
