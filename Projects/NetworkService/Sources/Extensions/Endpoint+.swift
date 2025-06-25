//
//  Endpoint+.swift
//  NetworkService
//
//  Created by 최정인 on 6/21/25.
//

import Foundation
import DataSource

extension Endpoint {
    func makeURLRequest() throws -> URLRequest {
        var request = try URLRequest(urlString: path)
        request.httpMethod = method.rawValue
        request.makeHeaders(headers: headers)
        try request.makeParameters(
            with: parameters,
            method: method,
            path: path)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        return request
    }
}
