//
//  DDCustomEnum.swift
//  HZXSwiftToolManager
//
//  Created by 侯仲祥 on 2020/7/14.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import Foundation

/**
 * 手机短信验证码类型
 */
public enum DDPhoneCodeType: Int {
    /// 注册
    case register = 0
    /// 忘记密码
    case forggetPwd
    /// 修改密码
    case changePwd
}

/**
 * 订单状态
 */
public enum DDOrderStauts: Int {
    /// 全部订单
    case all = 0
    /// 待支付
    case daiZhiFu
    /// 代发货
    case daiFaHuo
    /// 待收货
    case daiShouHuo
    /// 待评价
    case daiPingJia
    /// 已完成
    case completed
    /// 已取消
    case canceled
    
}
