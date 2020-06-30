//
//  DDJsonStringManager.swift
//  HZXSwiftToolProject
//
//  Created by 侯仲祥 on 2020/5/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import Foundation

class DDJsonStringManager {
    /// 把数组转化成Json字符串
    /// - Parameter array: 数组
    /// - Returns: Json字符串
    private class func jsonStringWithArray(array: NSArray) -> String {
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        return DDJsonStringManager.jsonStringWithData(data: data as Data)
    }
    
    /// 把字典转化成Json字符串
    /// - Parameter dictionary: 字典
    /// - Returns: json字符串
    private class func jsonStringWithDictionary(dictionary: NSDictionary) -> String {
        if (!JSONSerialization.isValidJSONObject(dictionary)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        return DDJsonStringManager.jsonStringWithData(data: data as Data)
    }
    
    private class func jsonStringWithData(data: Data) -> String {
        let JSONString = NSString(data:data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}

extension DDJsonStringManager {
    
    /// 将字典或者数组转化成Json字符串 （NSDictionary, Dictionary, NSArray, Array, NSData, Data）
    /// - Parameter data: 传入的数据
    /// - Returns: 转换后的字符串
    class func getJsonStringWith<T>(_ dataSources: T) -> String {
        if dataSources is NSDictionary {
            return DDJsonStringManager.jsonStringWithDictionary(dictionary: dataSources as! NSDictionary)
        } else if dataSources is Dictionary<String, Any> {
            return DDJsonStringManager.jsonStringWithDictionary(dictionary: dataSources as! NSDictionary)
        } else if dataSources is NSArray {
            return DDJsonStringManager.jsonStringWithArray(array: dataSources as! NSArray)
        } else if dataSources is Array<Any> {
            return DDJsonStringManager.jsonStringWithArray(array: dataSources as! NSArray)
        } else if dataSources is NSData {
            return DDJsonStringManager.jsonStringWithData(data: dataSources as! Data)
        } else if dataSources is Data {
            return DDJsonStringManager.jsonStringWithData(data: dataSources as! Data)
        }
        return ""
    }
}
