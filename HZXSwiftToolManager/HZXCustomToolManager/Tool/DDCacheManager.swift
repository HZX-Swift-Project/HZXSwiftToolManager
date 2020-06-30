//
//  DDCashManager.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import Foundation

struct DDCacheManager {
    /// 获取缓存大小  单位为M
    /// - Returns: 缓存大小
    static func getCacheSize() -> Double {
        /// 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        guard let realCachePath = cachePath else { return 0.0 }
        /// 取出文件夹下所有文件数组
        let fileArray = FileManager.default.subpaths(atPath: realCachePath)
        guard let realFileArray = fileArray else { return 0.0 }
        /// 声明缓存大小
        var totalSize = 0.0
        /// 快速枚举出所有文件名 计算文件大小
        for file in realFileArray {
            let path = realCachePath + ("/\(file)")
            /// 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            for (key, fileSize) in floder {
                /// 累加文件大小
                if key == FileAttributeKey.size {
                    totalSize += (fileSize as AnyObject).doubleValue
                }
            }
        }
        return totalSize / (1024.0 * 1024.0)
    }
    
    /// 清除缓存
    static func clearCache() {
        /// 取出cache文件夹目录
        let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
        guard let realCachePath = cachePath else { return }
        /// 取出文件夹下所有文件数组
        let fileArray = FileManager.default.subpaths(atPath: realCachePath)
        guard let realFileArray = fileArray else { return }
        /// 逐个移除缓存文件
        for file in realFileArray {
            let path = realCachePath + ("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
        
    }
}


