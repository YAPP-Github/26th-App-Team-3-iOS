//
//  AppProperties.swift
//  DataSource
//
//  Created by 최정인 on 6/23/25.
//

import Foundation

enum AppProperties {
    static var baseURL: String {
        Bundle.module.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }

    static var test: String {
        Bundle.module.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "네임 읽기 실패 ...."
    }
}
