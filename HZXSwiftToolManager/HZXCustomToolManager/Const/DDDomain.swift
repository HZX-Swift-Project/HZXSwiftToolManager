//
//  DDDomain.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

/// 服务器地址
let DD_ServiceIP = "http://qixingqizhiapp.yanglingeducation.com"

/// AppStore下载地址  不同的App只需要修改id（括号中的数字）就行了
let DD_APPStoreUrl = "https://itunes.apple.com/cn/app/id\(1504424289)?mt=8"

/// 判断请求是否成功
/// - Parameter code: 请求返回的code码
/// - Returns: 是否成功
func DDSuccessCode(_ code: String) -> Bool {
    return code == "0"
}

