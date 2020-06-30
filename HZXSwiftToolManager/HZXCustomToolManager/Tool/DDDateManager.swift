//
//  DDDateManager.swift
//  HZXSwiftToolProject
//
//  Created by 侯仲祥 on 2020/6/2.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import Foundation

struct DDDateManager {
    /// 默认的时间样式
    private static let defaultDateFormatter = "yyyy-MM-dd HH:mm:ss"
    
    
    /// 配置当前时间的样式
    /// - Parameter formatter: 时间样式
    /// - Returns: 配置过后的时间样式
    private static func configDateFormatter(formatter: String = defaultDateFormatter) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = formatter
        /// 设置系统时区
        let timeZone = TimeZone.current
        dateFormatter.timeZone = timeZone
        return dateFormatter
    }
    
    /// 获取当前时间戳 默认秒
    /// - Parameter isMillisecond: 是否是毫秒级
    /// - Returns: 时间戳
    static func getCurrentTimestamp(isMillisecond: Bool = false) -> String {
        /// 当前日期
        let currentDate = Date()
        let currentTimestamp = currentDate.timeIntervalSince1970
        if isMillisecond {
            /// 毫秒级
            let millseconds = currentTimestamp * 1000
            return "\(Int(millseconds))"
        } else {
            /// 秒级
            return "\(Int(currentTimestamp))"
        }
    }
    
    
    /// 获取当前时间
    /// - Parameter formatter: 时间格式
    /// - Returns: 当前时间
    static func getCurrentDate(formatter: String = defaultDateFormatter) -> String {
        let dateFormatter = configDateFormatter(formatter: formatter)
        /// 当前日期
        let currentDate = Date()
        let dateStr = dateFormatter.string(from: currentDate)
        return dateStr
    }
    
    
    /// 把date转化成时间字符串
    /// - Parameters:
    ///   - date: date类型时间
    ///   - formatter: 时间格式
    /// - Returns: 时间字符串
    static func getTimeStrByDate(date: Date, formatter: String = defaultDateFormatter) -> String {
        let dateFormatter = configDateFormatter(formatter: formatter)
        return dateFormatter.string(from: date)
    }
    
    
    /// 把字符串转化成Date类型
    /// - Parameters:
    ///   - timeStr: 时间字符串
    ///   - formatter: 时间格式
    /// - Returns: Date类型
    static func getDateByTime(timeStr: String, formatter: String = defaultDateFormatter) -> Date? {
        let dateFormatter = configDateFormatter(formatter: formatter)
        return dateFormatter.date(from: timeStr)
        
    }
    
    
    /// 获取距离现在多长时间
    /// - Parameter timestamp: 过去的时间戳
    /// - Returns: 过去的时间
    static func getPastTimeStr(timestamp: String) -> String {
        guard let pastTime = Int(timestamp) else {return ""}
        guard let currentTimestamp = Int(getCurrentTimestamp()) else { return "" }
        /// 时间差
        let timeDifference = currentTimestamp - pastTime
        if timeDifference < 0 {
            return ""
        }
        /// 年
        let year = timeDifference / (3600 * 24 * 365)
        /// 月
        let month = timeDifference / (3600 * 24 * 30)
        /// 日
        let day = timeDifference / (3600 * 24)
        /// 时
        let hour = timeDifference / 3600
        /// 分
        let minute = timeDifference / 60
        /// 秒
        let secode = timeDifference % 60
        
        if year > 0 {
            return "\(year)年前"
        } else if month > 0 {
            return "\(month)月前"
        } else if day > 0 {
            return "\(day)天前"
        } else if hour > 0 {
            return "\(hour)小时前"
        } else if minute > 0 {
            return "\(minute)分钟前"
        } else if secode > 0 {
            return "\(secode)秒前"
        }
        return ""
    }
    
    
    /// 获取将来的时间
    /// - Parameter timestampStr: 将来的时间戳
    /// - Returns: 将来时间 用于倒计时
    static func getFutureTime(timestampStr: String) -> String {
        guard let futureTime = Int(timestampStr) else {return ""}
        guard let currentTimestamp = Int(getCurrentTimestamp()) else { return "" }
        /// 时间差
        let timeDifference = futureTime - currentTimestamp
        if timeDifference < 0 {
            return ""
        }
        
        let day = timeDifference / (3600 * 24)
        let hour = timeDifference % (3600 * 24) / 3600
        let minute = timeDifference % 3600 / 60
        let second = timeDifference % 60
        
        let dayStr = String(format: "%d", day)
        let hourStr = String(format: "%02d", hour)
        let minuteStr = String(format: "%02d", minute)
        let secondStr = String(format: "%02d", second)
        
        return dayStr + hourStr + minuteStr + secondStr
    }
    
    
    
}
