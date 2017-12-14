//
//  EYNetworkServerManager+Register.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/14.
//

import Foundation
import PerfectHTTP

extension EYNetworkServerManager {
    /// 注册接口
    func addRegisterPort(routes: inout Routes) {
        routes.add(method: .post, uri: EYRegisterString) { (request, response) in
            guard let params = request.postBodyString?.converToDictionary,
                let account = params["account"],
                let password = params["password"] else {
                    let jsonString = self.baseResponseBodyJSONData(status: 200, errorCode: EYErrorCodeParams, data: "")
                    response.setBody(string: jsonString)
                    response.completed()
                    return
            }

            let result = EYDataBaseManager.shared.registerAccount(account: account as! String, password: password as! String)
            let jsonString = self.baseResponseBodyJSONData(status: 200, errorCode: result.errorCode, data: result.data)
            response.setBody(string: jsonString)
            response.completed()

        }
    }
}
