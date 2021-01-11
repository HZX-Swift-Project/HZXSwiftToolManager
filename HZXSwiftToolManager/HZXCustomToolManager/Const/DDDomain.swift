//
//  DDDomain.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
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

/// 判断是否需要升级
/// - Parameter serviceVersion: 服务器返回的版本号
/// - Returns: 返回是否需要升级
func DDAppNeedUpdate(_ with: String?) -> Bool {
    guard let serviceVersion = with else { return false }
    /// 获取系统版本号
    let appVersion = DD_AppVersion
    /// 如果版本号一致 返回false
    if appVersion == serviceVersion {
        return false
    }
    /// 根据小数点把字符串分组
    let appVersionArray = appVersion.split(separator: ".")
    let serviceVersionArray = serviceVersion.split(separator: ".")
    /// 计算最小数组长度
    let minCount = min(appVersionArray.count, serviceVersionArray.count)
    /// 此次循环 比较出前minCount位数值的大小
    for index in 0..<minCount {
        let appVersionNum = Int(appVersionArray[index])
        let serviceVersionNum = Int(serviceVersionArray[index])
        if serviceVersionNum! > appVersionNum! {
            /// 如果服务器版本比较大 则直接结束循环 返回需要升级 例如 1.1   1.2
            return true
        }
    }
    /// 此次判断 是对上方循环未比较出明确大小 例如  1.0.1  1.0.1.2 或者是 1.0.1   1.0.1.0.0.0.02
    if serviceVersionArray.count > minCount {
        for i in minCount..<serviceVersionArray.count {
            let serviceVersionNum = Int(serviceVersionArray[i])
            if serviceVersionNum! > 0 {
                return true
            }
        }
    }
    return false
}
