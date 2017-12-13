//
//  String+Extensions.swift
//  PerfectDemoProject
//
//  Created by gujiabin on 2017/12/13.
//

import Foundation

extension String {
    var converToDictionaryFromJSONString: Dictionary<String, Any> {
        let jsonData: Data = self.data(using: .utf8, allowLossyConversion: false) ?? Data()
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            return Dictionary<String, Any>()
        }

        return dict!
    }
}
