//
//  API.swift
//  CodeCoverage
//
//  Created by Ashok Rawat on 15/09/22.
//

import Foundation

enum API {
    static let baseURL = Bundle.infoPlistAPIValue(forKey: "baseURL",
        valueType: String.self)
    static let sourceService = "sources.json"
}

extension Bundle {
    static func infoPlistAPIValue<T>(forKey key: String, valueType: T.Type) ->
    T? {
        guard let path = Bundle.main.path(forResource: "ServiceAPI", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict.object(forKey: key) as? T else {
            return nil
        }
        return value
    }
}
