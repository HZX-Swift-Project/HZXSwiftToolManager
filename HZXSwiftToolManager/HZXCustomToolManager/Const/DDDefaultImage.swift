//
//  DDDefaultImage.swift
//  HZXSwiftToolProject
//
//  Created by Meet on 2020/5/16.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

/// 返回按钮图片
let DD_LeftPopImage = UIImage(named: "")
/// 更多按钮图片
let DD_RightArrowImage = UIImage(named: "")
/// 默认头像
let DD_HeaderDefaultImage = UIImage(named: "")
/// 正方形默认图
let DD_SquareDefaultImage = UIImage(named: "")
/// 轮播图默认图
let DD_BannerDefaultImage = UIImage(named: "")

/// 加载本地图片
/// - Parameter name: 图片名
/// - Returns: 本地图片Image
func DD_UIImage(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

/// 把网络图转换成URL
/// - Parameter urlStr: 网络图片链接
/// - Returns: 处理好的URL
func DD_HTTPImage(_ urlStr: String?) -> URL? {
    var httpUrlStr = ""
    if let name = urlStr, !name.isEmpty {
        httpUrlStr = name.hasPrefix("http") ? name : (DD_ServiceIP + name)
    }
    return URL(string: httpUrlStr)
}
