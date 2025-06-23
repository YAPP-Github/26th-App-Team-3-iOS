//
//  Endpoint.swift
//  DataSource
//
//  Created by 최정인 on 6/21/25.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
}
