//
//  String+Extensions.swift
//  PerfectDemoProject
//
//  Created by lieryang on 2017/12/13.
//

import Foundation

extension String {
    var converToDictionary: Dictionary<String, Any> {
        let jsonData: Data = self.data(using: .utf8, allowLossyConversion: false) ?? Data()
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
            return Dictionary<String, Any>()
        }

        return dict!
    }
}
