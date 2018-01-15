//
//  EYNetworkServerManager+Login.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/14.
//

import Foundation
import PerfectHTTP

extension EYNetworkServerManager {
    /// 注册接口
    func addLoginPort(routes: inout Routes) {
        routes.add(method: .post, uri: EYLoginString) { (request, response) in
            guard let account = request.param(name: "account"),
                let password = request.param(name: "password") else {
                    let jsonString = self.baseResponseBodyJSONData(status: 200, errorCode: EYErrorCodeParams, data: "")
                    response.setBody(string: jsonString)
                    response.completed()
                    return
            }

            let result = EYDataBaseManager.shared.loginAccount(account: account, password: password)
            let jsonString = self.baseResponseBodyJSONData(status: 200, errorCode: result.errorCode, data: result.data)
            response.setBody(string: jsonString)
            response.completed()

        }
    }
}
