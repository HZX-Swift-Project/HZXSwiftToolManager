//
//  UIScrollView+DDHelper.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
import MJRefresh
private class YJGIFRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        
        /// 设置普通状态的动画图片
        var idleImages = Array<UIImage>()
        for index in 1 ... 60 {
            let image = UIImage.init(named: "dropdown_anim__000\(index)")
            if let image = image {
                idleImages.append(image)
            }
        }
        self.setImages(idleImages, for: .idle)
        
        /// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var pullingImages = Array<UIImage>()
        for index in 1 ... 3 {
            let image = UIImage.init(named: "dropdown_loading_0\(index)")
            if let image = image {
                pullingImages.append(image)
            }
        }
        self.setImages(pullingImages, for: .pulling)
        
        // 设置正在刷新状态的动画图片
        var refreshingImages = Array<UIImage>()
        for index in 1 ... 3 {
            let image = UIImage.init(named: "dropdown_loading_0\(index)")
            if let image = image {
                refreshingImages.append(image)
            }
        }
        self.setImages(pullingImages, for: .refreshing)
    }
}

private class YJGIFRefreshFooter: MJRefreshBackGifFooter {
    override func prepare() {
        super.prepare()
        
        /// 设置普通状态的动画图片
        var idleImages = Array<UIImage>()
        for index in 1 ... 60 {
            let image = UIImage.init(named: "dropdown_anim__000\(index)")
            if let image = image {
                idleImages.append(image)
            }
        }
        self.setImages(idleImages, for: .idle)
        
        /// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        var pullingImages = Array<UIImage>()
        for index in 1 ... 3 {
            let image = UIImage.init(named: "dropdown_loading_0\(index)")
            if let image = image {
                pullingImages.append(image)
            }
        }
        self.setImages(pullingImages, for: .pulling)
        
        // 设置正在刷新状态的动画图片
        var refreshingImages = Array<UIImage>()
        for index in 1 ... 3 {
            let image = UIImage.init(named: "dropdown_loading_0\(index)")
            if let image = image {
                refreshingImages.append(image)
            }
        }
        self.setImages(pullingImages, for: .refreshing)
    }
}


extension UIScrollView {
    /// 添加下拉刷新控件
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 下拉刷新方法
    func addHeaderRefresh(_ target: Any, action: Selector) {
        let header = MJRefreshNormalHeader.init(refreshingTarget: target, refreshingAction: action)
        /// 修改文字
        header.lastUpdatedTimeLabel?.isHidden = true
        self.mj_header = header
    }
    
    /// 添加下拉刷新控件 (带动画)
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 下拉刷新方法
    func addGifHeaderRefresh(_ target: Any, action: Selector) {
        let header = YJGIFRefreshHeader.init(refreshingTarget: target, refreshingAction: action)
        /// 修改文字
        header.lastUpdatedTimeLabel?.isHidden = true
        self.mj_header = header
    }
    
    /// 添加上拉加载方法
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 上拉加载方法
    func addFooterRefresh(_ target: Any, action: Selector) {
        let footer = MJRefreshBackNormalFooter.init(refreshingTarget: target, refreshingAction: action)
        self.mj_footer = footer
    }
    
    /// 添加上拉加载方法
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 上拉加载方法
    func addGifFooterRefresh(_ target: Any, action: Selector) {
        let footer = YJGIFRefreshFooter.init(refreshingTarget: target, refreshingAction: action)
        self.mj_footer = footer
    }
    
    /// 停止刷新
    func endRefresh() {
        self.mj_header?.endRefreshing()
        self.mj_footer?.endRefreshing()
    }
    
    /// 显示没有更多数据提示
    func endRefreshNoMoreData() {
        self.mj_footer?.endRefreshingWithNoMoreData()
    }
    
    /// 隐藏上拉加载动画
    func hiddenFooter() {
        self.mj_footer?.isHidden = true
    }
}
