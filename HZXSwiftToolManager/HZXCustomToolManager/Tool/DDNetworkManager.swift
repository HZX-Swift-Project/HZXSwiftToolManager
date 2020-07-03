//
//  DDNetworkManager.swift
//  DDSwiftToolProject
//
//  Created by 侯仲祥 on 2020/4/27.
//  Copyright © 2020 houZhongXiang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DDNetworkManager {
    // MARK: ---------------- 配置请求参数
    /// 返回的数据回调闭包
    typealias resultClosure = (String, String, JSON) -> Void
    /// 初始化单利
    static let share = DDNetworkManager()
    
    /// 这是除了服务器地址和接口名之外 另外需要拼接的接口名
    let insertUrlStr = "/app/"
    
    /// 上传文件的类型
    enum UpDateFileType {
        case picture
        case voice
        case video
    }
    
    /// 数据请求方式
    enum MethodType: Int {
        case GET
        case POST
        public var httpMethod: HTTPMethod {
            switch self {
            case .GET:
                return HTTPMethod.get
            case .POST:
                return HTTPMethod.post
            }
        }
    }
    
    /// 数据请求头 这里可以填写 请求头的一些公共内容
    var headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    // 接收数据类型
    let contentTppe = ["application/json", "text/json", "text/plain", "text/javascript", "text/html"]
}
extension DDNetworkManager {
    // MARK: ---------------- 普通数据请求方法
    /// 普通数据请求 默认是POST请求
    /// - Parameters:
    ///   - urlStr: 数据请求URL
    ///   - methodType: 数据请求方式 默认是POST请求
    ///   - parameters: 参数
    ///   - hasToken: 是否需要传入 token  默认是true
    ///   - resultClosure: 返回结果
    func requestService(_ urlStr: String, methodType: MethodType = .POST, parameters: [String: Any]? = nil, hasToken:Bool = true, resultClosure: @escaping resultClosure) {
        /// 如果需要传入token 则追加这个值
        if hasToken {
            headers.add(name: "Authorization", value: "Bearer a2216a73-7927-47b3-8ec7-301c8243c900")
        }
        /// 拼接请求地址
        let requestUrl = urlStr.hasPrefix("http") ? urlStr : DD_ServiceIP + insertUrlStr + urlStr
        /// 发起请求
        AF.request(requestUrl, method: methodType.httpMethod, parameters: parameters, headers: headers){ urlRequest in
            /// 这个闭包可以设置URLRequest一些相关的参数
            /// 请求超时时间
            urlRequest.timeoutInterval = 15
        }.validate(contentType:self.contentTppe).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                /// 请求成功回调
                let result = JSON(value)
                let code = result["code"].stringValue
                let message  = result["message"].stringValue
                resultClosure(code, message, result)
            case .failure(let error):
                /// 请求失败回调
                resultClosure("", error.errorDescription ?? "未知错误", JSON.init([:]))
            }
        }
    }
    
    /// 上传文件的方法 把图片放进数组中 一张也要放进去
    /// - Parameters:
    ///   - urlStr: 上传接口
    ///   - methodType: 上传方法
    ///   - parameters: 其他参数，除了上传的文件外
    ///   - files: 图片参数数组
    ///   - fileNames: 图片文件参数名
    ///   - fileType: 文件类型 图片、视频、音频
    ///   - hasToken: 是否需要传入token 默认true
    ///   - resultClosure: 请求结果
    private func updateFiles<T>(_ urlStr: String, methodType: MethodType = .POST, parameters: [String: Any]? = nil, files:[T], fileNames:[String], fileType:UpDateFileType, hasToken: Bool = true, resultClosure: @escaping resultClosure) {
        /// 如果需要传入token 则追加这个值
        if hasToken {
            headers.add(name: "Authorization", value: "Bearer a2216a73-7927-47b3-8ec7-301c8243c900")
        }
        /// 拼接请求地址
        let requestUrl = urlStr.hasPrefix("http") ? urlStr : DD_ServiceIP + insertUrlStr + urlStr
        /// 发起请求，上传文件
        AF.upload(multipartFormData: { (formData) in
            /// 这个是判断上传的文件类型类型
            var mimeType = ""
            var subFileName = ""
            switch fileType {
            case .picture:
                mimeType = "image/jpg"
                subFileName = ".jpg"
            case .voice:
                mimeType = "amr/mp3/wmr"
                subFileName = ".mp3"
            case .video:
                mimeType = "video/mp4"
                subFileName = ".mp4"
            }
            
            /// 上传的是图片类型
            for index in 0 ..< files.count {
                let file = files[index]
                /// 获取上传是图片的参数
                var withName = ""
                if fileNames.count == 1  {
                    withName = fileNames[0]
                } else {
                    withName = fileNames[index]
                }
                let fileName = withName + subFileName
                /// 获取数据类型
                if file is Data {
                    /// 判断数据类型
                    formData.append(file as! Data, withName: withName, fileName: fileName, mimeType: mimeType)
                } else if file is String {
                    /// 判断图片是String类型
                    if let data = try? Data.init(contentsOf: DD_HTTPImage(file as? String)!) {
                        formData.append(data, withName: withName, fileName: fileName, mimeType: "image/jpg")
                    }
                } else if file is UIImage {
                    /// 判断图片是UIImage类型
                    let data = (file as! UIImage).compress()!
                    formData.append(data, withName: withName, fileName: fileName, mimeType: "image/jpg")
                } else if file is URL {
                    /// 传入的是视频或者音频 本地的视频或音频都是URL类型
                    formData.append(file as! URL, withName: withName, fileName: fileName, mimeType: mimeType)
                }
            }
            
            /// 这里是其他普通参数
            if parameters != nil {
                for (key, value) in parameters! {
                    if value is String {
                        formData.append((value as! String).data(using: .utf8)!, withName: key)
                    }
                }
            }
            
        }, to: requestUrl, method: methodType.httpMethod, headers: headers){ urlRequest in
            /// 请求超时时间
            urlRequest.timeoutInterval = 15
        }.uploadProgress(queue: .main) { (progress) in
            /// 这里传递的是上传速度
            print(progress)
        }.responseJSON{ (response) in
            /// 这里是回调结果
            switch response.result {
            case .success(let value):
                /// 请求成功回调
                let result = JSON(value)
                let code = result["code"].stringValue
                let message  = result["message"].stringValue
                resultClosure(code, message, result)
            case .failure(let error):
                /// 请求失败回调
                resultClosure("", error.errorDescription ?? "未知错误", JSON.init([:]))
            }
        }
    }
}

extension DDNetworkManager {
    
    // MARK: ---------------- 上传图片
    /// 上传图片 即使有一张图片也要放到数组中
    /// - Parameters:
    ///   - urlStr: 接口名称
    ///   - methodType: 请求方式 POST（默认）， GET
    ///   - parameters: 其他参数
    ///   - files: 文件数据
    ///   - fileNames: 文件对应的参数 如果参数一致，则数组中传入一个值即可 只要有不一样的参数，那么文件数据就得和文件参数名称一一对应
    ///   - hasToken: 是否包含token
    ///   - resultClosure: 请求结果
    func updateImages<T>(_ urlStr: String, methodType: MethodType = .POST, parameters: [String: Any]? = nil, files:[T], fileNames:[String], hasToken: Bool = true, resultClosure: @escaping resultClosure) {
        updateFiles(urlStr, methodType: methodType, parameters: parameters, files: files, fileNames: fileNames, fileType: .picture, hasToken: hasToken, resultClosure: resultClosure)
    }
    
    // MARK: ---------------- 上传音频MP3
    /// 上传音频 可以带封面图 即使只有一个音频文件也要放到数组中
    /// 这个接口是上传音频的接口，这个接口可以上传封面图，我们需要吧files，filesName 两个数组的值相互对应
    /// 例如 [音频1，音频1封面，音频2，音频2封面] 对应的应该是 [音频1key，音频1封面key，音频2key，音频2封面key]
    /// - Parameters:
    ///   - urlStr: 接口名称
    ///   - methodType: 请求方式 POST（默认）， GET
    ///   - parameters: 其他参数
    ///   - files: 文件数据
    ///   - fileNames: 文件对应的参数 如果参数一致，则数组中传入一个值即可 只要有不一样的参数，那么文件数据就得和文件参数名称一一对应
    ///   - hasToken: 是否包含token
    ///   - resultClosure: 请求结果
    func updateVoice(_ urlStr: String, methodType: MethodType = .POST, parameters: [String: Any]? = nil, files:[URL], fileNames:[String], hasToken: Bool = true, resultClosure: @escaping resultClosure) {
        updateFiles(urlStr, methodType: methodType, parameters: parameters, files: files, fileNames: fileNames, fileType: .voice, hasToken: hasToken, resultClosure: resultClosure)
    }
    
    // MARK: ---------------- 上传视频MP4
    /// 上传视频 可以上传封面图 即使只有一个视频文件也要放到数组中
    /// 这个接口是上传视频的接口，这个接口可以上传封面图，我们需要吧files，filesName 两个数组的值相互对应
    /// 例如 [视频1，视频1封面，视频2，视频2封面] 对应的应该是 [视频1key，视频1封面key，视频2key，视频2封面key]
    /// - Parameters:
    ///   - urlStr: 接口名称
    ///   - methodType: 请求方式 POST（默认）， GET
    ///   - parameters: 其他参数
    ///   - files: 文件数据
    ///   - fileNames: 文件对应的参数 如果参数一致，则数组中传入一个值即可 只要有不一样的参数，那么文件数据就得和文件参数名称一一对应
    ///   - hasToken: 是否包含token
    ///   - resultClosure: 请求结果
    func updateVideo(_ urlStr: String, methodType: MethodType = .POST, parameters: [String: Any]? = nil, files:[URL], fileNames:[String], hasToken: Bool = true, resultClosure: @escaping resultClosure) {
        updateFiles(urlStr, methodType: methodType, parameters: parameters, files: files, fileNames: fileNames, fileType: .video, hasToken: hasToken, resultClosure: resultClosure)
    }
}
