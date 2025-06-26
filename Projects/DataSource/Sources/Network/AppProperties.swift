//
//  AppProperties.swift
//  DataSource
//
//  Created by 최정인 on 6/23/25.
//

import Foundation

enum AppProperties {
    static var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
}
