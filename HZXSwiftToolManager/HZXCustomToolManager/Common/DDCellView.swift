//
//  DDCellView.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

class DDCellView: UIView {
    /// 上方线条
    let topLine = UIImageView()
    /// 底部线条
    var bottomLine = UIImageView()
    /// 右箭头
    var rightImageView = UIImageView()
    /// 点击cell 的按钮
    var clickButton = UIButton()
    /// 标题
    var titleLabel = UILabel()
    /// 是否显示右箭头
    var isShowRight = true
    /// 底部线条是否是短线条
    var isShortLine = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = DD_WhiteColor
        configUI()
    }
    
    private func configUI() {
        
        titleLabel.textColor = DD_BlackTextColor
        titleLabel.font = regular15Font
        self.addSubview(titleLabel)
        
        clickButton.backgroundColor = DD_ClearColor
        self.addSubview(clickButton)
        
        topLine.backgroundColor = DD_GrayLineColor
        topLine.isHidden = true
        self.addSubview(topLine)
        
        rightImageView.image = DD_RightArrowImage
        self.addSubview(rightImageView)
        
        bottomLine.backgroundColor = DD_GrayLineColor
        self.addSubview(bottomLine)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: AutoSize(15), y: 0, width: self.width - AutoSize(50) , height: self.height)
        
        topLine.frame = CGRect(x: 0, y: 0, width: self.width, height: DD_LineHeight)
        
        rightImageView.frame = CGRect(x: self.width - AutoSize(30) - AutoSize(5), y: self.height/2 - AutoSize(30)/2, width: AutoSize(30), height: AutoSize(30))
        
        rightImageView.isHidden = !isShowRight
        
        if isShortLine {
            bottomLine.frame = CGRect(x: AutoSize(15), y: self.height - DD_LineHeight, width: self.width - AutoSize(15)*2, height: DD_LineHeight)
        } else {
            bottomLine.frame = CGRect(x: 0, y: self.height - DD_LineHeight, width: self.width, height: DD_LineHeight)
        }
        
        clickButton.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height);
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
