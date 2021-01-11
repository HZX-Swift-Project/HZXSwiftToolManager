//
//  DDWebViewController.swift
//  DDSwiftToolProject
//
//  Created by Meet on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
import WebKit
class DDWebViewController: DDBaseViewController {
    /// 标题
    var webTitleStr = "详情"
    /// 详情链接   默认是服务器地址
    var linkUrlStr = DD_ServiceIP
    /// webview
    private var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configNewNavi()
        configWebView()
    }
    // MARK: ----------------------- 创建WebView
    func configWebView() {
        webView.frame = CGRect(x: 0, y: DD_NaviAndStatusTotalHeight, width: DD_ScreenWidth, height: DD_SafeAreaHeight - DD_NaviAndStatusTotalHeight)
        /// 先添加到界面 再加载网址 否则控制台会打印一串东西
        view.addSubview(webView)
        
        webView.load(URLRequest(url: URL(string: linkUrlStr)!))
    }
    // MARK: ----------------------- 配置导航
    func configNewNavi() {
        titleLabel.text = webTitleStr
        popButton.addTarget(self, action: #selector(popAction), for: .touchUpInside)
    }
    @objc func popAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
