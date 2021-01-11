//
//  UIImage+DDHelper.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

extension UIImage {
    /// 根据颜色生成图片
    /// - Parameter color: 图片颜色
    /// - Returns: 生成后的图片
    public static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    /// 系统压缩图片 默认压缩为原来的 0.1
    /// - Parameters:
    ///   - compressionQuality: 压缩比例 默认为0.1
    /// - Returns: 压缩后的数据
    func compress(compressionQuality: CGFloat = 0.1) -> Data? {
        return self.jpegData(compressionQuality: compressionQuality)
    }
    
    /// 图片压缩 单位 kb
    /// - Parameter maxLength: 压缩图片存储空间大小 单位 kb
    /// - Returns: 压缩后的大小
    func compress(maxLength: Int) -> Data {
        let dataMaxLength = maxLength * 1024
        var compression: CGFloat = 0.9
        let minCompression: CGFloat = 0.1
        if self.compress(compressionQuality: 1.0)!.count <= dataMaxLength {
            return self.compress()!
        } else {
            var imageData = self.jpegData(compressionQuality: compression)!;
            while imageData.count > dataMaxLength && compression > minCompression {
                compression -= 0.1
                imageData = self.jpegData(compressionQuality: compression)!;
            }
            return imageData
        }
    }
}
