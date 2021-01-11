//
//  DDUserDefaluts.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import Foundation
/// 数据存储
///  使用的时候直接使用这个结构体就可以了
struct DDUserDefaluts {
    /**
     * 使用的时候请注意 key 这个字段保留的value 值是什么类型，下边的变量名称就是什么类型
     * 例如登录和手机号这两个 是否登录是bool类型， 手机号是 String 类型
     * 其中 “key” 是userdefalt中保留的字段名，跟下边的属性变量没有必要一致，当然也可以一致
     */
    
    //MARK: -------------- 存储用户信息
    /// 用户Id
    @DDCustomUserDefaluts(key: "DD_userID", defaultValue: "")
    static var userId: String
    /// 用户手机号
    @DDCustomUserDefaluts(key: "DD_userTel", defaultValue: "")
    static var userTel: String
    /// 用户登录密码
    @DDCustomUserDefaluts(key: "DD_userPassword", defaultValue: "")
    static var userPassword: String
    /// 用户名
    @DDCustomUserDefaluts(key: "DD_userName", defaultValue: "")
    static var userName: String
    /// 用户昵称
    @DDCustomUserDefaluts(key: "DD_nickName", defaultValue: "")
    static var nickName: String
    /// 用户头像
    @DDCustomUserDefaluts(key: "DD_userLogo", defaultValue: "")
    static var userLogo: String
    
    //MARK: -------------- 存储登录信息
    /// 是否登录
    @DDCustomUserDefaluts(key: "DD_isLogin", defaultValue: false)
    static var isLogin: Bool
    /// 是否显示了引导页
    @DDCustomUserDefaluts(key: "DD_isGuided", defaultValue: true)
    static var showGuide: Bool
    
    //MARK: -------------- 存储第三方登录信息
    /// 设备token
    @DDCustomUserDefaluts(key: "DD_deviceToken", defaultValue: "")
    static var deviceToken: String
}

/// 做项目开发的时候不要使用这个结构体存储数据，使用上面的结构体存储
@propertyWrapper
struct DDCustomUserDefaluts<T> {
    /// 保存的key值
    let key: String
    /// 保存的默认值
    let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    /// 利用计算属性存储数据
    var wrappedValue: T {
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
    }
}


