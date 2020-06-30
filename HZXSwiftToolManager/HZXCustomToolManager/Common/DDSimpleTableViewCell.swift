//
//  DDSimpleTableViewCell.swift
//  haiTongApp
//
//  Created by 侯仲祥 on 2020/5/16.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

class DDSimpleTableViewCell: DDBaseTableViewCell {
    /// 标题
    let titleLabel = UILabel()
    
    /// 是否显示右边箭头
    var isShowRightArrow = false
    /// 右边箭头
    let rightImageView = UIImageView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    func configNewView() {
        titleLabel.font = regular15Font
        titleLabel.textColor = DD_BlackTextColor
        self.contentView.addSubview(titleLabel)
        
        rightImageView.image = DD_RightArrowImage
        self.contentView.addSubview(rightImageView)
        
    }
    
    override func layoutSubviews() {
        if isShowRightArrow {
            rightImageView.frame = CGRect(x: self.width - AutoSize(10) - AutoSize(22), y: self.height/2 - AutoSize(22)/2, width: AutoSize(22), height: AutoSize(22))
            titleLabel.frame = CGRect(x: AutoSize(15), y: 0, width: rightImageView.left - AutoSize(25), height: self.height)
        } else {
            titleLabel.frame = CGRect(x: AutoSize(15), y: 0, width: self.width - AutoSize(30), height: self.height)
        }
        
        self.bottomLine.frame = CGRect(x: AutoSize(15), y: self.height - DD_LineHeight, width: self.width - AutoSize(15), height: DD_LineHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
