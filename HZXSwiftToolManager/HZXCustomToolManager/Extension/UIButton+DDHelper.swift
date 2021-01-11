//
//  UIButton+DDHelper.swift
//  haiTongApp
//
//  Created by Meet on 2020/6/28.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

public enum ButtonImageLocation {
    /// 图片的位置
    case left, top, right, bottom
}

extension UIButton {
    
    /// 调整button图片与文字的位置与间距 默认间距为0
    /// - Parameters:
    ///   - location: 图片的位置
    ///   - space: 图片与文字的间距
    public func setImageLocation(_ location: ButtonImageLocation, space: CGFloat = 0.0) {
        /// 位置偏移量
        let offSet = space / 2
        
        /// 图片视图的尺寸
        let imageWidth = self.imageView?.bounds.size.width ?? 0.0
        let imageHeight = self.imageView?.bounds.size.height ?? 0.0
        /// 文字视图的尺寸
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        /// 图片内边距
        var imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        /// 文字的内边距
        var labelEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        switch location {
        case .top:
            /// 图片居上
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - offSet, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - offSet, right: 0)
        case .left:
            /// 图片居左
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -offSet, bottom: 0, right: offSet)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: offSet, bottom: 0, right: offSet)
        case .bottom:
            /// 图片居下
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - offSet, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - offSet, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            /// 图片居右
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + offSet, bottom: 0, right: -labelWidth - offSet)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - offSet, bottom: 0, right: imageWidth + offSet)
        }
        /// 赋值
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}

