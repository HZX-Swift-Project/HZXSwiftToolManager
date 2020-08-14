//
//  DDBaseViewController.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class DDBaseViewController: UIViewController {
    // MARK: ------------------------------------ 懒加载视图 用到的时候在初始化
    /// 导航栏试图
    lazy var naviImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: DD_ScreenWidth, height: DD_NaviAndStatusTotalHeight))
        imageView.backgroundColor = DD_BlueColor
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    /// 返回按钮
    lazy var popButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: DD_StatusBarHeight, width: DD_NavigationBarHeight, height: DD_NavigationBarHeight))
        button.setImage(DD_LeftPopImage, for: .normal)
        button.setImage(DD_LeftPopImage, for: .highlighted)
        naviImageView.addSubview(button)
        return button
    }()
    /// 标题
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: DD_NavigationBarHeight, y: DD_StatusBarHeight, width: DD_ScreenWidth - 88.0, height: DD_NavigationBarHeight))
        label.font = DD_Regular17Font
        label.textColor = DD_WhiteColor
        label.textAlignment = .center
        naviImageView.addSubview(label)
        return label
    }()
    /// table表格
    lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0.0, y: DD_NavigationBarHeight, width: DD_ScreenWidth, height: DD_SafeAreaHeight - DD_NaviAndStatusTotalHeight), style: .grouped)
        tableView.backgroundColor = DD_WhiteColor
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.scrollIndicatorInsets = tableView.contentInset
            tableView.estimatedRowHeight = 0.0
            tableView.estimatedSectionHeaderHeight = 0.0
            tableView.estimatedSectionFooterHeight = 0.0
        }
        view.addSubview(tableView)
        return tableView
    }()
    /// 滚动视图UIScrollView
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0.0, y: DD_NavigationBarHeight, width: DD_ScreenWidth, height: DD_SafeAreaHeight - DD_NaviAndStatusTotalHeight))
        scrollView.backgroundColor = DD_DefaultBgColor
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        view.addSubview(scrollView)
        return scrollView
    }()
    
    // MARK: ------------------------------------ ViewDidLoad初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 支持侧滑返回
        self.fd_prefersNavigationBarHidden = true;
        /// 设置默认背景颜色
        view.backgroundColor = DD_DefaultBgColor
        /// 添加导航视图
        view.addSubview(naviImageView)
        /// 隐藏默认的导航
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
}

extension DDBaseViewController {
    //MARK: ------------------------------------ 点击事件
    //MARK: - 点击空界面的方法
    /// 点击空白界面的操作 可在子类中重写这个方法
    func superClickEmptyViewAction() {}
    /// 点击空白界面按钮时候的操作  可在子类中重写这个方法
    func superClickEmptyViewButtonAction() {}
    //MARK: - 拨打电话
    /// 拨打电话
    /// - Parameter with: 电话号码
    func makePhone(with: String?) {
        /// 判断是否有获取到电话信息
        guard let telphone = with, !telphone.isEmptyString() else {
            DDMBProgressHUD.showTipMessage(message: "为获取到电话号码")
            return
        }
        let telphoneUrl = "tel://" + telphone
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: telphoneUrl)!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: telphoneUrl)!)
        }
    }
}

extension DDBaseViewController {
    // MARK: ------------------------------------ 系统弹窗提示
    typealias alertHandler = () -> Void
    
    /// 弹出系统对话框（只有一个确定按钮）
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - confirmTitle: 确定按钮的标题
    ///   - handler: 回调闭包
    func showOkAlertMesssage(title: String?, message: String?, confirmTitle: String = "确定", handler: alertHandler? = nil) {
        let alerAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: confirmTitle, style: .default) { (UIAlertAction) in
            if let handler = handler {
                handler()
            }
        }
        confirmAlert.setValue(DD_BlueColor, forKey: "_titleTextColor")
        alerAction.addAction(confirmAlert)
        self.present(alerAction, animated: true, completion: nil)
    }
    
    /// 弹出系统对话框（有取消和确定按钮）
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    ///   - cancelTitle: 取消按钮标题
    ///   - confirmTitle: 确定按钮的标题
    ///   - cancelHandler: 取消的回调闭包
    ///   - confirmHandler: 确定的回调闭包
    func showCancelAlertMessage(title: String?, message: String, cancelTitle: String = "取消", confirmTitle: String = "确定", cancelHandler: alertHandler? = nil, confirmHandler: alertHandler?) {
        let alerAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        /// 取消弹窗
        let cancelAlert = UIAlertAction(title: cancelTitle, style: .default) { (UIAlertAction) in
            if let cancelHandler = cancelHandler {
                cancelHandler()
            }
        }
        /// 确定弹窗
        let confirmAlert = UIAlertAction(title: confirmTitle, style: .default) { (UIAlertAction) in
            if let confirmHandler = confirmHandler {
                confirmHandler()
            }
        }
        /// 修改按钮颜色字体
        cancelAlert.setValue(DD_GrayTextColor, forKey: "_titleTextColor")
        confirmAlert.setValue(DD_BlueColor, forKey: "_titleTextColor")
        /// 加入系统弹窗
        alerAction.addAction(cancelAlert)
        alerAction.addAction(confirmAlert)
        self.present(alerAction, animated: true, completion: nil)
    }
}

import EmptyDataSet_Swift
extension DDBaseViewController: EmptyDataSetDelegate, EmptyDataSetSource {
    // MARK: ------------------------------------ 空白界面占位图
    //MARK: - DZNEmptyDataSetSource
    /// 空白界面占位标题
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        /// 配置字体属性
        let attributed = [NSAttributedString.Key.font: DD_Regular15Font,
                          NSAttributedString.Key.foregroundColor: DD_BlackTextColor
        ]
        return NSAttributedString(string: "暂无数据", attributes: attributed)
    }
    /// 空白界面占位详细信息
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let attributed = [NSAttributedString.Key.font: DD_Regular15Font,
                          NSAttributedString.Key.foregroundColor: DD_GrayLineColor
        ]
        return NSAttributedString(string: "这个是详细信息", attributes: attributed)
    }
    
    /// 占位图
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return DD_UIImage("logo_")
    }
    /// 动画
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView) -> CAAnimation? {
        return nil
    }
    /// 按钮标题
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> NSAttributedString? {
        let attributed = [NSAttributedString.Key.font: DD_Regular15Font,
                          NSAttributedString.Key.foregroundColor: DD_BlueColor
        ]
        return NSAttributedString(string: "这个是按钮", attributes: attributed)
    }
    /// 按钮背景图
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView, for state: UIControl.State) -> UIImage? {
        return nil
    }
    /// 空界面背景颜色
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return DD_OrangeColor
    }
    /// 占位图的偏移量
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
    /// 控件的距离
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return 10
    }
    
    //MARK: - DZNEmptyDataSetDelegate Methods
    /// 是否显示空界面
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    /// 空界面是否可以点击
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    /// 空界面是否可以拖动
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    /// 空界面是否可以动画
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return false
    }
    /// 点击空界面触发的方法
    func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        superClickEmptyViewAction()
    }
    /// 点击按钮触发的方法
    func emptyDataSet(_ scrollView: UIScrollView, didTapButton button: UIButton) {
        superClickEmptyViewButtonAction()
    }
}
