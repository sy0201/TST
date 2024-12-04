//
//  Bundle+Extension.swift
//  TS_Weather
//
//  Created by siyeon park on 12/3/24.
//

import Foundation

extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
