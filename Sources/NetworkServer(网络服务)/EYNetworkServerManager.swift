//
//  NetworkServerManager.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/11.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

open class EYNetworkServerManager {

    fileprivate var server: HTTPServer
    internal init(root: String, port: UInt16) {

        server = HTTPServer.init()                          //创建HTTPServer服务器
        var routes = Routes.init(baseUri: EYBaseURIString)  //创建路由器
        configure(routes: &routes)                          //注册路由
        server.addRoutes(routes)                            //路由添加进服务
        server.serverPort = port                            //端口
        server.documentRoot = root                          //根目录
        server.setResponseFilters([(Filter404(), .high)])   //404过滤

    }

    //MARK: 开启服务
    open func startServer() {

        do {
            EYLog("启动HTTP服务器")
            try server.start()
        } catch PerfectError.networkError(let err, let msg) {
            EYLog("网络出现错误：\(err) \(msg)")
        } catch {
            EYLog("网络未知错误")
        }

    }
    // MARK: -----------------------private------------------------
    //MARK: 注册路由
    ///
    /// - Parameter routes: 需要注册的路由
    private func configure(routes: inout Routes) {
        addRegisterPort(routes: &routes)
        addLoginPort(routes: &routes)
    }

    /// 通用响应格式
    ///
    /// - Parameters:
    ///   - status: 状态码
    ///   - message: 描述信息
    ///   - data: 返回的数据信息
    /// - Returns: json字符串
    func baseResponseBodyJSONData(status: Int, errorCode: Int, data: Any!) -> String {

        var result = Dictionary<String, Any>()
        result.updateValue(status, forKey: "status")
        result.updateValue(errorCode, forKey: "errorCode")
        if (data != nil) {
            result.updateValue(data, forKey: "data")
        } else {
            result.updateValue("", forKey: "data")
        }
        guard let jsonString = try? result.jsonEncodedString() else {
            return ""
        }
        return jsonString

    }

    /// 404过滤
    private struct Filter404: HTTPResponseFilter {

        func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            callback(.continue)
        }

        func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
            if case .notFound = response.status {
                response.setBody(string: "404 文件\(response.request.path)不存在。")
                response.setHeader(.contentLength, value: "\(response.bodyBytes.count)")
                callback(.done)

            } else {
                callback(.continue)
            }
        }
    }
}

