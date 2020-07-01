//
//  Color+DDHelper.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
extension UIColor {
    /// 获取随机一个颜色值
    /// - Returns: 随机颜色值
    public class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1.0)
    }
    
    /// 十六进制字符串获取颜色
    /// - Parameter hexString: 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    /// - Returns: 处理后的颜色
    public class func colorWithHexString(_ hexString: String) -> UIColor {
        return UIColor.colorWithHexString(hexString, alpha: 1.0)
    }
    
    /// 十六进制字符串获取颜色
    /// - Parameters:
    ///   - hexString: 16进制色值  支持@“#123456”、 @“0X123456”、 @“123456”三种格式
    ///   - alpha: 透明度
    /// - Returns: 处理后的颜色
    public class func colorWithHexString(_ hexString: String, alpha: CGFloat) -> UIColor {
        var defaultCoclor = UIColor.clear
        //去除空白字符
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        var tempStr = hexString.trimmingCharacters(in: whitespace).uppercased()
        //判断字符串你是否是以6-8位
        if tempStr.count < 6 || tempStr.count > 8 {
            return defaultCoclor
        }
        //判断是否是0X开头，如果是去除0X
        if tempStr.hasPrefix("0X") {
            tempStr = tempStr.subStringFrom(startIndex: 2)
        }
        //判断是否是#号开头，如果是去除#
        if tempStr.hasPrefix("#") {
            tempStr = tempStr.subStringFrom(startIndex: 1)
        }
        // 判断是否是6位十六进制字符串
        if tempStr.count != 6 {
            return defaultCoclor
        }
        /// 获取red色值
        let redColorStr = tempStr.getString(startIndex: 0, count: 2)
        /// 获取green色值
        let greenColorStr = tempStr.getString(startIndex: 2, count: 2)
        /// 获取blue色值
        let blueColorStr = tempStr.getString(startIndex: 4, count: 2)
        
        //存储转换后的数值
        var redColor:UInt64 = 0
        var greenColor:UInt64 = 0
        var blueColor:UInt64 = 0
        //进行转换
        Scanner(string: redColorStr).scanHexInt64(&redColor)
        Scanner(string: greenColorStr).scanHexInt64(&greenColor)
        Scanner(string: blueColorStr).scanHexInt64(&blueColor)

        /// 转化为UIColor
        defaultCoclor = UIColor(red: CGFloat(redColor)/255.0, green: CGFloat(greenColor)/255.0, blue: CGFloat(blueColor)/255.0, alpha: alpha)
        return defaultCoclor
    }
    
    /// 适配暗黑模式颜色   传入的UIColor对象
    /// - Parameters:
    ///   - lightColor: 普通模式颜色
    ///   - darkColor: 暗黑模式颜色
    /// - Returns: 处理后的颜色
    public class func colorWithUIColor(lightColor: UIColor?, darkColor: UIColor?) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.init { (trainCollection) -> UIColor in
                // 判断是light模式 返回lightColor
                if (trainCollection.userInterfaceStyle == .light) {
                    //这里对lightColor 解包 如果是是nil 则返回clearColor
                    return lightColor ?? UIColor.clear
                } else {
                    return darkColor ?? UIColor.clear
                }
            }
        } else {
            //数据解包 解包出lightColor
            guard let lightColor = lightColor else {
                //数据解包 解包出darkColor
                guard let darkColor = darkColor else {
                    return UIColor.clear
                }
                return darkColor
            }
            return lightColor
        }
    }
    
    /// 适配暗黑模式颜色   颜色传入的是16进制字符串
    /// - Parameters:
    ///   - lightHexString: 普通模式颜色
    ///   - darkHexString: 暗黑模式颜色
    /// - Returns: 处理后的颜色
    public class func colorWithLightHexColorStr(lightHexString: String, darkHexString: String) -> UIColor {
        return UIColor.colorWithUIColor(lightColor: colorWithHexString(lightHexString), darkColor: colorWithHexString(darkHexString))
    }
    
    /// 适配暗黑模式颜色   颜色传入的是16进制字符串 还有颜色的透明度
    /// - Parameters:
    ///   - lightHexString: 普通模式颜色
    ///   - lightAlpha: 普通模式颜色透明度
    ///   - darkHexString: 暗黑模式颜色透明度
    ///   - darkAlpha:  暗黑模式颜色
    /// - Returns: 处理后的颜色
    public class func colorWithHexColorStr(lightHexString: String, lightAlpha: CGFloat, darkHexString: String, darkAlpha: CGFloat) -> UIColor {
        let lightColor = colorWithHexString(lightHexString, alpha: lightAlpha)
        let darkColor = colorWithHexString(darkHexString, alpha: darkAlpha)
        return UIColor.colorWithUIColor(lightColor: lightColor, darkColor: darkColor)
    }
}
