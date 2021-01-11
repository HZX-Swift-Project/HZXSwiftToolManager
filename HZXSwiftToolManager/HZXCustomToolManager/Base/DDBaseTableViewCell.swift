//
//  DDTableViewCell.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit

class DDBaseTableViewCell: UITableViewCell {
    /// 索引
    var indexPath: NSIndexPath?
    
    /// 顶部线条
    lazy var topLine: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = DD_GrayLineColor
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    /// 底部线条
    lazy var bottomLine: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = DD_GrayLineColor
        self.contentView.addSubview(imageView)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = DD_GrayLineColor
        configNewView()
    }
    
    /// 创建界面
    func configNewView() {}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
