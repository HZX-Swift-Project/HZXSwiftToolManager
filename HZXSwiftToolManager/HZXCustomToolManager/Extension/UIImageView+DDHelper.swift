//
//  UIImageView+DDHelper.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//
import UIKit
import Kingfisher

extension UIImageView {
    
    /// Kingfisher 加载网络图片
    /// 这个方法只是简单的封装了一下， 如果想继续使用Kingfisher，也是可以的
    /// - Parameters:
    ///   - name: 网络图片地址
    ///   - placeHolderImage: 占位图
    func DD_setURLImage(urlStr: String?, placeHolderImage: UIImage? = DD_SquareDefaultImage) {
        self.kf.setImage(with: DD_HTTPImage(urlStr), placeholder: placeHolderImage)
    }
}
