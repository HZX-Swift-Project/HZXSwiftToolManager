//
//  DDDefaultImage.swift
//  HZXSwiftToolProject
//
//  Created by 侯仲祥 on 2020/5/16.
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
func DD_UIImageNamed(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

/// 把网络图转换成URL
/// - Parameter name: 网络图片链接
/// - Returns: 处理好的URL
func DD_HTTPURLImageWith(_ name: String?) -> URL? {
    var urlStr = ""
    if let name = name, !name.isEmpty {
        urlStr = name.hasPrefix("http") ? name : (DD_ServiceIP + name)
    }
    return URL(string: urlStr)
}
